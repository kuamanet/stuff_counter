import 'package:firebase_database/firebase_database.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stuff_counter/counters/core/counters_repository.dart';

class CounterRepositoryMock extends Mock implements CountersRepository {}

class FirebaseDatabaseMock extends Mock implements FirebaseDatabase {}

class DatabaseReferenceMock extends Mock implements DatabaseReference {}
