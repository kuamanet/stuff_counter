import 'package:kcounter/counters/core/counters_repository.dart';
import 'package:kcounter/counters/entities/counter_create_dto.dart';
import 'package:kcounter/counters/entities/counter_read_dto.dart';
import 'package:localstore/localstore.dart';

class LocalCountersRepository implements CountersRepository {
  final _collectionName = "counters/";
  late final Localstore _store;
  late final CollectionRef _ref;

  LocalCountersRepository(Localstore localstore) {
    _store = localstore;
    _ref = _store.collection(_collectionName);
  }

  @override
  Future create(CounterCreateDto counter) async {
    final id = _ref.doc().id;
    await _ref.doc(id).set(counter.toMap());
  }

  @override
  Stream<List<CounterReadDto>> getAll() {
    return _ref.stream.map((event) {
      final items = <CounterReadDto>[];
      event.forEach((key, value) {
        items.add(CounterReadDto.from(Map<String, dynamic>.from(value), key));
      });
      return items;
    });
  }

  @override
  Future<CounterReadDto> getOne(String id) async {
    // todo this should be a stream
    final child = _ref.doc(id);
    final snapshot = await child.get();
    if (snapshot == null) {
      throw ArgumentError("Record $id not found");
    }
    return CounterReadDto.from(Map<String, dynamic>.from(snapshot), id);
  }

  @override
  Future update(CounterReadDto counter) async {
    final record = _ref.doc(counter.id);
    await record.set(counter.toMap());
  }

  @override
  delete(String id) async {
    final record = _ref.doc(id);
    await record.delete();
  }
}
