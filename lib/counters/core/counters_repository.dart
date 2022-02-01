import 'package:stuff_counter/counters/entities/counter.dart';

abstract class CountersRepository {
  Future create(CounterReadDto counter);
  Future update(CounterReadDto counter);
  Future<List<CounterReadDto>> getAll();
  Future<CounterReadDto> getOne(String id);
}
