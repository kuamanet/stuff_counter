import 'dart:async';

import 'package:kcounter/counters/core/counters_repository.dart';
import 'package:kcounter/counters/entities/counter_create_dto.dart';
import 'package:kcounter/counters/entities/counter_read_dto.dart';
import 'package:localstore/localstore.dart';
import 'package:rxdart/rxdart.dart';

/// Device - local source of counters
/// It's based upon [Localstore]
///
/// While [Localstore] grants a stream that gets refreshed upon create / update / set operations,
/// it is missing a refresh upon delete.
/// In order to trigger a refresh on our data even upon delete, we're leveraging rx power
class LocalCountersRepository implements CountersRepository {
  final _collectionName = "counters/";

  /// mixed with [Localstore] stream, ensures we emit our values at the right time
  final _refreshSubject = PublishSubject<bool>();
  late final Localstore _store;
  late final CollectionRef _ref;

  /// Device - local source of counters
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
  Stream<List<CounterReadDto>> getAll() {
    // then map the local database stream merged with our refresh subject
    return _refreshSubject
        .startWith(true)
        .withLatestFrom(
          _ref.stream.startWith({}),
          (_, Map<String, dynamic> localData) => localData,
        )
        .asyncMap((event) async {
      final res = await _ref.get();
      final items = <CounterReadDto>[];
      res?.forEach((key, value) {
        items.add(CounterReadDto.from(
          Map<String, dynamic>.from(value),
          value["id"],
        ));
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
  Future<void> delete(String id) async {
    final record = _ref.doc(id);
    // this operation does not trigger an event on the stream sink
    await record.delete();
    _refreshSubject.add(true);
  }
}
