import 'package:flutter_test/flutter_test.dart';
import 'package:kcounter/counters/actions/create_counter.dart';
import 'package:kcounter/counters/entities/counter_read_dto.dart';
import 'package:mocktail/mocktail.dart';

import '../test_utils.dart';

class _CounterReadDtoMock extends Fake implements CounterReadDto {}

void main() {
  late CounterRepositoryMock repo;

  setUpAll(() {
    registerFallbackValue(_CounterReadDtoMock());
  });

  setUp(() {
    repo = CounterRepositoryMock();
  });

  test("it creates a counters", () async {
    final mockCounter = createEmptyCounter();

    when(() {
      return repo.create(any());
    }).thenAnswer((_) => Future.value());

    final action = CreateCounter(countersRepository: repo);
    await action.run(CreateCounterParams(name: mockCounter.name, color: mockCounter.color));

    verify(() => repo.create(mockCounter));
  });
}
