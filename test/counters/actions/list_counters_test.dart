import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stuff_counter/counters/actions/list_counters.dart';
import 'package:stuff_counter/counters/entities/counter.dart';

import '../test_utils.dart';

void main() {
  late CounterRepositoryMock repo;

  setUp(() {
    repo = CounterRepositoryMock();
  });

  test("it retrieves all counters", () async {
    final mockCounter = Counter(
      id: "id",
      name: "name",
      count: 0,
      color: Colors.amber.toString(),
      history: [],
    );

    when(() {
      return repo.getAll();
    }).thenAnswer((_) async => [mockCounter]);

    final action = ListCounters(countersRepository: repo);
    final result = await action.run();

    expect(result, equals([mockCounter]));
    verify(() => repo.getAll());
  });
}
