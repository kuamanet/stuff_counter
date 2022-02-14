import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:kcounter/counters/core/counters_repository.dart';
import 'package:kcounter/counters/entities/counter_create_dto.dart';
import 'package:kcounter/counters/entities/counter_log.dart';
import 'package:kcounter/counters/entities/counter_read_dto.dart';
import 'package:localstore/localstore.dart';
import 'package:mocktail/mocktail.dart';

class CounterRepositoryMock extends Mock implements CountersRepository {}

class FirebaseDatabaseMock extends Mock implements FirebaseDatabase {}

class LocalDatabaseMock extends Mock implements Localstore {}

class CollectionRefMock extends Mock implements CollectionRef {}

class DocumentRefMock extends Mock implements DocumentRef {}

class DataSnapshotMock extends Mock implements DataSnapshot {}

class DatabaseEventMock extends Mock implements DatabaseEvent {}

class DatabaseReferenceMock extends Mock implements DatabaseReference {}

CounterCreateDto createEmptyCounter() {
  return CounterCreateDto(
    name: "name",
    count: 0,
    color: Colors.amber.toString(),
    secret: false,
    history: const [],
  );
}

CounterReadDto readEmptyCounter({String id = "id", int count = 0, history = const <CounterLog>[]}) {
  return CounterReadDto(
    id: id,
    name: "name",
    count: count,
    color: Colors.amber.toString(),
    secret: false,
    history: history,
  );
}
