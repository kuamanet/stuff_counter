import 'package:flutter_test/flutter_test.dart';
import 'package:kcounter/counters/actions/decrease_counter.dart';
import 'package:kcounter/counters/entities/counter_log.dart';
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

  test("it decrease a counter given its id", () async {
    const id = "1";
    final mockCounter = readEmptyCounter(
      id: id,
      history: [CounterLog(createdAt: DateTime.now(), count: 1)],
      count: 1,
    );

    when(() {
      return repo.getOne(any());
    }).thenAnswer((_) async => mockCounter);

    when(() {
      return repo.update(any());
    }).thenAnswer((_) => Future.value());

    final action = DecreaseCounter(countersRepository: repo);
    await action.run(id);

    verify(() => repo.getOne(id));
    final VerificationResult result = verify(() => repo.update(captureAny<CounterReadDto>()));

    expect((result.captured[0] as CounterReadDto).count, mockCounter.count - 1);
  });
}
