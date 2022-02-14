import 'package:kcounter/counters/core/action.dart';
import 'package:kcounter/counters/core/counters_repository.dart';
import 'package:kcounter/counters/entities/counter_create_dto.dart';

class CreateCounterParams {
  final String name;
  final String color;
  final bool? secret;

  CreateCounterParams({required this.name, required this.color, this.secret});
}

class CreateCounter extends ParamsAction<CreateCounterParams, void> {
  final CountersRepository countersRepository;

  CreateCounter({required this.countersRepository});

  @override
  Future<void> run(CreateCounterParams params) async {
    await countersRepository.create(CounterCreateDto(
      name: params.name,
      color: params.color,
      count: 0,
      secret: params.secret ?? false,
      history: const [],
    ));
  }
}
