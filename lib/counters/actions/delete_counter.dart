import 'package:kcounter/counters/core/action.dart';
import 'package:kcounter/counters/core/counters_repository.dart';

class DeleteCounter extends ParamsAction<String, void> {
  final CountersRepository countersRepository;

  DeleteCounter({required this.countersRepository});

  @override
  Future<void> run(String params) async {
    await countersRepository.delete(params);
  }
}
