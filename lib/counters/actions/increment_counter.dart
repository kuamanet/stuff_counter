import 'package:stuff_counter/counters/actions/get_counter.dart';
import 'package:stuff_counter/counters/core/action.dart';
import 'package:stuff_counter/counters/core/counters_repository.dart';

class IncrementCounter extends ParamsAction<String, void> {
  final CountersRepository countersRepository;

  IncrementCounter({required this.countersRepository});
  @override
  Future<void> run(String params) async {
    final getCounterAction = GetCounter(countersRepository: countersRepository);

    final counter = await getCounterAction.run(params);

    // TODO: implement run
    throw UnimplementedError();
  }
}
