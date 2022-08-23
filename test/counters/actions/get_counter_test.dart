import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:kcounter/counters/actions/get_counter.dart';

import '../test_utils.dart';

void main() {
  late CounterRepositoryMock repo;

  setUp(() {
    repo = CounterRepositoryMock();
  });

  test("it retrieves a counter given its id", () async {
    const id = "1";
    final mockCounter = readEmptyCounter(id: id);
    when(() {
      return repo.getOne(any());
    }).thenAnswer((_) async => mockCounter);

    final action = GetCounter(countersRepository: repo);
    final result = await action.run(id);

    expect(result, equals(readEmptyDailyCounter(id: id)));
    verify(() => repo.getOne(id));
  });
}
