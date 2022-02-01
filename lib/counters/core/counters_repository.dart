import 'package:stuff_counter/counters/entities/counter.dart';

abstract class CountersRepository {
  Future create(Counter counter);
  Future update(Counter counter);
  Future<List<Counter>> getAll();
  Future<Counter> getOne(String id);
}
