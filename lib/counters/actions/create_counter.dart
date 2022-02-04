import 'package:kcounter/counters/core/action.dart';
import 'package:kcounter/counters/core/counters_repository.dart';
import 'package:kcounter/counters/entities/counter_create_dto.dart';

class CreateCounterParams {
  final String name;
  final String color;

  CreateCounterParams({required this.name, required this.color});
}

class CreateCounter extends ParamsAction<CreateCounterParams, void> {
  final CountersRepository countersRepository;

  CreateCounter({required this.countersRepository});

  @override
  Future<void> run(CreateCounterParams params) async {
    await countersRepository.create(
        CounterCreateDto(name: params.name, color: params.color, count: 0, history: const []));
  }
}
