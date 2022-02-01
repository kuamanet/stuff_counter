import 'package:firebase_database/firebase_database.dart';
import 'package:stuff_counter/counters/core/counters_repository.dart';
import 'package:stuff_counter/counters/entities/counter.dart';

class RealTimeCountersRepository implements CountersRepository {
  late DatabaseReference _ref;

  RealTimeCountersRepository(FirebaseDatabase database) {
    _ref = database.ref("counters");
  }

  @override
  Future create(Counter counter) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<List<Counter>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<Counter> getOne(String id) {
    // TODO: implement getOne
    throw UnimplementedError();
  }

  @override
  Future update(Counter counter) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
