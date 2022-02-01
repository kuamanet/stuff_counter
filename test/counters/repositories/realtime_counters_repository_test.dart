import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stuff_counter/counters/entities/counter.dart';
import 'package:stuff_counter/counters/repositories/realtime_counters_repository.dart';

import '../test_utils.dart';

void main() {
  late FirebaseDatabaseMock firebaseDatabase;
  late DatabaseReferenceMock ref;

  setUp(() {
    firebaseDatabase = FirebaseDatabaseMock();
    ref = DatabaseReferenceMock();

    when(() {
      return ref.push();
    }).thenReturn(ref);

    when(() {
      return firebaseDatabase.ref(any());
    }).thenReturn(ref);
  });

  test("it should be built with a FirebaseDatabase instance", () {
    final repo = RealTimeCountersRepository(firebaseDatabase);

    // silly test to enforce the way the constructor should work
    expect(repo is RealTimeCountersRepository, true);
  });

  test("it creates a counter inside the firebase database", () {
    final repo = RealTimeCountersRepository(firebaseDatabase);

    when(() {
      return ref.set(any());
    }).thenAnswer((_) => Future.value());

    final entity =
        CounterCreateDto(name: "name", count: 0, color: Colors.amber.toString(), history: []);
    repo.create(entity);

    verify(() {
      return ref.push().set(entity);
    });
  });

  test("it returns a counter by id", () {
    // final repo = RealTimeCountersRepository(firebaseDatabase);
    //
    // when(() {
    //   return ref.get();
    // }).thenAnswer((_) => Future.value());
    //
    // final entity =
    //     CounterCreateDto(name: "name", count: 0, color: Colors.amber.toString(), history: []);
    // repo.create(entity);
    //
    // verify(() {
    //   return ref.push().set(entity);
    // });
  });
}
