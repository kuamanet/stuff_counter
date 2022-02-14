import 'package:flutter_test/flutter_test.dart';
import 'package:kcounter/counters/actions/list_counters.dart';
import 'package:mocktail/mocktail.dart';

import '../test_utils.dart';

void main() {
  late CounterRepositoryMock repo;

  setUp(() {
    repo = CounterRepositoryMock();
  });

  test("it retrieves all counters", () async {
    final mockCounter = readEmptyCounter();

    when(() {
      return repo.getAll();
    }).thenAnswer((_) async* {
      yield [mockCounter];
    });

    final action = ListCounters(countersRepository: repo);

    expect(
        action.run(ListCountersParams(showSecretCounters: false)),
        emitsInOrder([
          equals([mockCounter]),
          emitsDone
        ]));
    verify(() => repo.getAll());
  });
}
