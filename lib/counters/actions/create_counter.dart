import 'package:stuff_counter/counters/core/action.dart';
import 'package:stuff_counter/counters/core/counters_repository.dart';
import 'package:stuff_counter/counters/entities/counter_create_dto.dart';

class CreateCounter extends ParamsAction<CounterCreateDto, void> {
  final CountersRepository countersRepository;

  CreateCounter({required this.countersRepository});

  @override
  Future<void> run(CounterCreateDto params) async {
    await countersRepository.create(params);
  }
}
