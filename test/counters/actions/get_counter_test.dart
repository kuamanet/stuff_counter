import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stuff_counter/counters/actions/get_counter.dart';
import 'package:stuff_counter/counters/entities/counter.dart';

import '../test_utils.dart';

void main() {
  late CounterRepositoryMock repo;

  setUp(() {
    repo = CounterRepositoryMock();
  });

  test("it retrieves a counter given its id", () async {
    const id = "1";
    final mockCounter = CounterReadDto(
      id: id,
      name: "name",
      count: 0,
      color: Colors.amber.toString(),
      history: [],
    );

    when(() {
      return repo.getOne(any());
    }).thenAnswer((_) async => mockCounter);

    final action = GetCounter(countersRepository: repo);
    final result = await action.run(id);

    expect(result, equals(mockCounter));
    verify(() => repo.getOne(id));
  });
}
