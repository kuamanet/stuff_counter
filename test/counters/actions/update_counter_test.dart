import 'package:flutter_test/flutter_test.dart';
import 'package:kcounter/counters/actions/update_counter.dart';
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

  test("it updates a counters", () async {
    final mockCounter = readEmptyCounter();

    when(() {
      return repo.getOne(any());
    }).thenAnswer((_) async => mockCounter);

    when(() {
      return repo.update(any());
    }).thenAnswer((_) => Future.value());

    final action = UpdateCounter(countersRepository: repo);
    await action.run(UpdateCounterParams(
      name: mockCounter.name,
      color: mockCounter.color,
      id: mockCounter.id,
    ));

    verify(() => repo.update(mockCounter));
  });
}
