import 'package:stuff_counter/counters/core/action.dart';
import 'package:stuff_counter/counters/core/counters_repository.dart';
import 'package:stuff_counter/counters/entities/counter.dart';

class GetCounter extends ParamsAction<String, Counter> {
  final CountersRepository countersRepository;

  GetCounter({required this.countersRepository});

  @override
  Future<Counter> run(String params) {
    return countersRepository.getOne(params);
  }
}
