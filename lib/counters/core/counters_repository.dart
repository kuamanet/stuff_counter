import 'package:kcounter/counters/entities/counter_create_dto.dart';
import 'package:kcounter/counters/entities/counter_read_dto.dart';

abstract class CountersRepository {
  Future<void> create(CounterCreateDto counter);
  Future<void> update(CounterReadDto counter);
  Stream<List<CounterReadDto>> getAll();
  Future<CounterReadDto> getOne(String id);
}
