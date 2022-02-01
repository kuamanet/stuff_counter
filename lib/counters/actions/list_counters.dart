import 'package:stuff_counter/counters/core/action.dart';
import 'package:stuff_counter/counters/core/counters_repository.dart';
import 'package:stuff_counter/counters/entities/counter.dart';

class ListCounters extends Action<List<Counter>> {
  final CountersRepository countersRepository;

  ListCounters({required this.countersRepository});

  @override
  Future<List<Counter>> run() {
    return countersRepository.getAll();
  }
}
