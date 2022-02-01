import 'package:firebase_database/firebase_database.dart';
import 'package:stuff_counter/counters/core/counters_repository.dart';
import 'package:stuff_counter/counters/entities/counter.dart';

class RealTimeCountersRepository implements CountersRepository {
  late DatabaseReference _ref;

  RealTimeCountersRepository(FirebaseDatabase database) {
    _ref = database.ref("counters");
  }

  @override
  Future create(CounterCreateDto counter) async {
    await _ref.push().set(counter);
  }

  @override
  Future<List<CounterReadDto>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<CounterReadDto> getOne(String id) {
    // TODO: implement getOne
    throw UnimplementedError();
  }

  @override
  Future update(CounterReadDto counter) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
