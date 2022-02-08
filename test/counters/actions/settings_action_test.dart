import 'package:flutter_test/flutter_test.dart';
import 'package:kcounter/counters/actions/get_settings.dart';
import 'package:kcounter/counters/entities/settings_dto.dart';
import 'package:mocktail/mocktail.dart';

import '../test_utils.dart';

void main() {
  test("It allows to read the current app settings", () async {
    final databaseMock = LocalDatabaseMock();
    final collectionRef = CollectionRefMock();
    const settings = SettingsDto(online: false);
    final action = GetSettings(db: databaseMock);

    when(() {
      return collectionRef.stream;
    }).thenAnswer((_) async* {
      yield settings.toMap();
    });

    when(() {
      return databaseMock.collection(any());
    }).thenReturn(collectionRef);

    expect(
        action.run(),
        emitsInOrder([
          equals(settings),
          emitsDone,
        ]));

    verify(() => databaseMock.collection(GetSettings.settingsKey));
    verify(() => collectionRef.stream);
  });
}
