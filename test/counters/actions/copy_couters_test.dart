import 'package:flutter_test/flutter_test.dart';
import 'package:kcounter/counters/actions/copy_counters.dart';
import 'package:kcounter/counters/entities/counter_read_dto.dart';
import 'package:mocktail/mocktail.dart';

import '../test_utils.dart';

class _CounterReadDtoMock extends Fake implements CounterReadDto {}

void main() {
  late CounterRepositoryMock repo;
  late CounterRepositoryMock repo2;

  setUp(() {
    repo = CounterRepositoryMock();
    repo2 = CounterRepositoryMock();
    registerFallbackValue(_CounterReadDtoMock());
  });

  test("it copies all counters", () async {
    final mockCounter = readEmptyCounter();

    when(() {
      return repo.getAll();
    }).thenAnswer((_) async* {
      yield [mockCounter];
    });
    when(() {
      return repo2.getAll();
    }).thenAnswer((_) async* {
      yield [mockCounter];
    });
    when(() {
      return repo2.create(any(), any());
    }).thenAnswer((_) => Future.value());

    final action = CopyCounters(from: repo, to: repo2);
    await action.run();

    verify(() => repo.getAll());
    verify(() => repo2.create(any(), any()));
  });
}
