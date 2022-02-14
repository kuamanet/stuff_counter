import 'package:flutter_test/flutter_test.dart';
import 'package:kcounter/counters/repositories/local_counters_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../test_utils.dart';

void main() {
  late LocalDatabaseMock localDatabase;
  late CollectionRefMock ref;
  late DocumentRefMock document;
  late LocalCountersRepository repo;

  setUp(() {
    localDatabase = LocalDatabaseMock();
    ref = CollectionRefMock();
    document = DocumentRefMock();

    when(() {
      return ref.doc();
    }).thenReturn(document);

    when(() {
      return localDatabase.collection(any());
    }).thenReturn(ref);

    repo = LocalCountersRepository(localDatabase);
  });

  test("it should be built with a Localstore instance", () {
    // silly test to enforce the way the constructor should work
    // ignore: unnecessary_type_check
    expect(repo is LocalCountersRepository, true);
  });

  test("it creates a counter inside the local database", () async {
    when(() {
      return document.id;
    }).thenAnswer((_) => "1");
    when(() {
      return document.set(any());
    }).thenAnswer((_) async => Future<void>.value());

    when(() {
      return ref.doc(any());
    }).thenAnswer((_) => document);

    final entity = createEmptyCounter();
    await repo.create(entity);

    verify(() {
      return ref.doc("1").set(entity.toMap());
    });
  });

  test("it updates a counter by id", () async {
    final entity = readEmptyCounter();

    // mock the get by id call
    when(() {
      return ref.doc(any());
    }).thenReturn(document);

    // mock the update call
    when(() {
      return document.set(any());
    }).thenAnswer((_) => Future<void>.value());

    await repo.update(entity);

    verifyInOrder([
      () => ref.doc(entity.id),
      () => document.set(entity.toMap()),
    ]);
  });

  test("it deletes a counter by id", () async {
    final entity = readEmptyCounter();

    // mock the get by id call
    when(() {
      return ref.doc(any());
    }).thenReturn(document);

    // mock the delete call
    when(() {
      return document.delete();
    }).thenAnswer((_) => Future<void>.value());

    await repo.delete(entity.id);

    verifyInOrder([
      () => ref.doc(entity.id),
      () => document.delete(),
    ]);
  });

  test("it returns a counter by id", () async {
    final entity = readEmptyCounter();

    // mock the get by id call
    when(() {
      return ref.doc(any());
    }).thenReturn(document);

    when(() {
      return document.get();
    }).thenAnswer((_) async => entity.toMap());

    final result = await repo.getOne(entity.id);

    expect(result, equals(entity));

    verifyInOrder(
      [
        () => ref.doc(entity.id),
        () => document.get(),
      ],
    );
  });

  test("it returns all counters", () async {
    final entity = readEmptyCounter();
    final entity2 = readEmptyCounter(id: "id2");

    when(() {
      return ref.get();
    }).thenAnswer((_) async {
      return {
        entity.id: entity.toMap(),
        entity2.id: entity2.toMap(),
      };
    });

    expect(
      repo.getAll(),
      emitsInOrder(
        [
          [entity, entity2],
          emitsDone
        ],
      ),
    );
  });
}
