import 'package:firebase_database/firebase_database.dart';
import 'package:kcounter/counters/core/counters_repository.dart';
import 'package:kcounter/counters/entities/counter_create_dto.dart';
import 'package:kcounter/counters/entities/counter_read_dto.dart';

class RealTimeCountersRepository implements CountersRepository {
  final _collectionName = "counters/";
  late DatabaseReference _ref;

  RealTimeCountersRepository(FirebaseDatabase database) {
    database.setLoggingEnabled(true);
    database.setPersistenceEnabled(true);
    _ref = database.ref(_collectionName);
  }

  @override
  Future create(CounterCreateDto counter) async {
    await _ref.push().set(counter.toMap());
  }

  @override
  Future<List<CounterReadDto>> getAll() async {
    final snapshot = await _ref.get();
    if (snapshot.exists && snapshot.value is Map<dynamic, dynamic>) {
      final rawList = snapshot.value as Map<dynamic, dynamic>;
      final items = <CounterReadDto>[];
      rawList.forEach((key, value) {
        items.add(CounterReadDto.from(value, key));
      });
      return items;
    }
    throw ArgumentError("Base collection $_collectionName does not exist");
  }

  @override
  Future<CounterReadDto> getOne(String id) async {
    final child = _ref.child(id);
    final snapshot = await child.get();
    if (snapshot.exists) {
      return CounterReadDto.from(snapshot.value!, snapshot.key!);
    }

    throw ArgumentError("Record $id not found");
  }

  @override
  Future update(CounterReadDto counter) async {
    final record = _ref.child(counter.id);
    await record.update(counter.toMap());
  }
}
