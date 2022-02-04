import 'package:kcounter/counters/core/action.dart';
import 'package:kcounter/counters/core/counters_repository.dart';
import 'package:kcounter/counters/entities/counter_read_dto.dart';

class GetCounter extends ParamsAction<String, CounterReadDto> {
  final CountersRepository countersRepository;

  GetCounter({required this.countersRepository});

  @override
  Future<CounterReadDto> run(String params) {
    return countersRepository.getOne(params);
  }
}
