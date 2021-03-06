import 'package:firebase_database/firebase_database.dart';
import 'package:kcounter/counters/core/counters_repository.dart';
import 'package:kcounter/counters/entities/counter_create_dto.dart';
import 'package:kcounter/counters/entities/counter_read_dto.dart';

class RealTimeCountersRepository implements CountersRepository {
  late final String _collectionName;
  late DatabaseReference _ref;

  RealTimeCountersRepository(
    FirebaseDatabase database,
    String guid,
  ) {
    database.setLoggingEnabled(true);
    database.setPersistenceEnabled(true);
    _collectionName = guid;
    _ref = database.ref(_collectionName);
  }

  @override
  Future create(CounterCreateDto counter, [String? id]) async {
    if (id != null) {
      await update(
        CounterReadDto(
          id: id,
          name: counter.name,
          count: counter.count,
          color: counter.color,
          secret: counter.secret,
          history: counter.history,
        ),
      );
    } else {
      await _ref.push().set(counter.toMap());
    }
  }

  @override
  Stream<List<CounterReadDto>> getAll() {
    return _ref.onValue.map((event) {
      final snapshot = event.snapshot;

      if (snapshot.exists && snapshot.value is Map<dynamic, dynamic>) {
        final rawList = snapshot.value as Map<dynamic, dynamic>;
        final items = <CounterReadDto>[];
        rawList.forEach((key, value) {
          items.add(CounterReadDto.from(Map<String, dynamic>.from(value), key));
        });
        return items;
      }
      throw ArgumentError("Base collection $_collectionName does not exist");
    });
  }

  @override
  Future<CounterReadDto> getOne(String id) async {
    // todo this should be a stream
    final child = _ref.child(id);
    final event = await child.once();

    if (event.snapshot.exists) {
      final record = event.snapshot.value! as Map<dynamic, dynamic>;
      return CounterReadDto.from(Map<String, dynamic>.from(record), event.snapshot.key!);
    }

    throw ArgumentError("Record $id not found");
  }

  @override
  Future update(CounterReadDto counter) async {
    final record = _ref.child(counter.id);
    await record.update(counter.toMap());
  }

  @override
  Future<void> delete(String id) async {
    final record = _ref.child(id);
    await record.remove();
  }
}
