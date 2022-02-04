import 'package:flutter_test/flutter_test.dart';
import 'package:kcounter/counters/repositories/realtime_counters_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../test_utils.dart';

void main() {
  late FirebaseDatabaseMock firebaseDatabase;
  late DatabaseReferenceMock ref;
  late RealTimeCountersRepository repo;
  setUp(() {
    firebaseDatabase = FirebaseDatabaseMock();
    ref = DatabaseReferenceMock();

    when(() {
      return ref.push();
    }).thenReturn(ref);

    when(() {
      return firebaseDatabase.ref(any());
    }).thenReturn(ref);

    repo = RealTimeCountersRepository(firebaseDatabase);
  });

  test("it should be built with a FirebaseDatabase instance", () {
    // silly test to enforce the way the constructor should work
    expect(repo is RealTimeCountersRepository, true);
  });

  test("it creates a counter inside the firebase database", () async {
    when(() {
      return ref.set(any());
    }).thenAnswer((_) => Future.value());

    final entity = createEmptyCounter();
    await repo.create(entity);

    verify(() {
      return ref.push().set(entity);
    });
  });

  test("it updates a counter by id", () async {
    final entity = readEmptyCounter();

    // mock the get by id call
    when(() {
      return ref.child(any());
    }).thenReturn(ref);

    // mock the update call
    when(() {
      return ref.update(any());
    }).thenAnswer((_) => Future.value());

    await repo.update(entity);

    verifyInOrder([
      () => ref.child(entity.id),
      () => ref.update(entity.toMap()),
    ]);
  });

  test("it returns a counter by id", () async {
    final entity = readEmptyCounter();

    // mock the get by id call
    when(() {
      return ref.child(any());
    }).thenReturn(ref);

    final snapshotMock = DataSnapshotMock();

    when(() {
      return snapshotMock.value;
    }).thenReturn({entity.id: entity.toMap()});

    when(() {
      return snapshotMock.exists;
    }).thenReturn(true);

    when(() {
      return snapshotMock.key;
    }).thenReturn(entity.id);

    when(() {
      return ref.get();
    }).thenAnswer((_) async => snapshotMock);

    final result = await repo.getOne(entity.id);

    expect(result, equals(entity));

    verifyInOrder([
      () => ref.child(entity.id),
      () => ref.get(),
    ]);
  });

  test("it returns all counters", () async {
    final entity = readEmptyCounter();
    final entity2 = readEmptyCounter(id: "id2");

    // mock the get call
    final event = DatabaseEventMock();
    final snapshotMock = DataSnapshotMock();

    when(() {
      return event.snapshot;
    }).thenReturn(snapshotMock);

    when(() {
      return snapshotMock.value;
    }).thenReturn({
      entity.id: entity.toMap(),
      entity2.id: entity2.toMap(),
    });

    when(() {
      return snapshotMock.exists;
    }).thenReturn(true);

    when(() {
      return ref.onValue;
    }).thenAnswer((_) async* {
      yield event;
    });

    expect(
        repo.getAll(),
        emitsInOrder([
          [entity, entity2],
          emitsDone
        ]));
  });
}
