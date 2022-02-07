import 'package:flutter_test/flutter_test.dart';
import 'package:kcounter/counters/actions/delete_counter.dart';
import 'package:mocktail/mocktail.dart';

import '../test_utils.dart';

void main() {
  late CounterRepositoryMock repo;

  setUp(() {
    repo = CounterRepositoryMock();
  });

  test("it deletes a counter given its id", () async {
    const id = "1";

    when(() {
      return repo.delete(any());
    }).thenAnswer((_) => Future.value());

    final action = DeleteCounter(countersRepository: repo);
    await action.run(id);

    verify(() => repo.delete(id));
  });
}
