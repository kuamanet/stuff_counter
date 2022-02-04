import 'package:kcounter/counters/core/action.dart';
import 'package:kcounter/counters/core/counters_repository.dart';
import 'package:kcounter/counters/entities/counter_read_dto.dart';

class ListCounters extends StreamAction<List<CounterReadDto>> {
  final CountersRepository countersRepository;

  ListCounters({required this.countersRepository});

  @override
  Stream<List<CounterReadDto>> run() {
    return countersRepository.getAll();
  }
}
