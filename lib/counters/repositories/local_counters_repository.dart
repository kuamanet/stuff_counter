import 'dart:async';

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
  Future create(CounterCreateDto counter, [String? id]) async {
    final documentId = id ?? _ref.doc().id;
    final counterRead = CounterReadDto(
      id: documentId,
      name: counter.name,
      count: counter.count,
      color: counter.color,
      secret: counter.secret,
      history: counter.history,
    );
    await _ref.doc(documentId).set(counterRead.toMap());
  }

  @override
  Stream<List<CounterReadDto>> getAll() async* {
    final res = await _ref.get();
    final items = <CounterReadDto>[];
    res?.forEach((key, value) {
      items.add(CounterReadDto.from(Map<String, dynamic>.from(value), value["id"]));
    });

    yield items;
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
