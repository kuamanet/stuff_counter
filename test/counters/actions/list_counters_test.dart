import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stuff_counter/counters/actions/list_counters.dart';

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
    }).thenAnswer((_) async => [mockCounter]);

    final action = ListCounters(countersRepository: repo);
    final result = await action.run();

    expect(result, equals([mockCounter]));
    verify(() => repo.getAll());
  });
}
