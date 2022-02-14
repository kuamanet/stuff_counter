import 'package:kcounter/counters/actions/get_counter.dart';
import 'package:kcounter/counters/core/action.dart';
import 'package:kcounter/counters/core/counters_repository.dart';

class UpdateCounterParams {
  final String? name;
  final String? color;
  final bool? secret;
  final String id;

  UpdateCounterParams({
    required this.id,
    this.name,
    this.color,
    this.secret,
  });
}

class UpdateCounter extends ParamsAction<UpdateCounterParams, void> {
  final CountersRepository countersRepository;

  UpdateCounter({required this.countersRepository});

  @override
  Future<void> run(UpdateCounterParams params) async {
    final getCounterAction = GetCounter(countersRepository: countersRepository);
    final counter = await getCounterAction.run(params.id);
    await countersRepository.update(counter.copyWith(
      name: params.name,
      color: params.color,
      secret: params.secret,
    ));
  }
}
