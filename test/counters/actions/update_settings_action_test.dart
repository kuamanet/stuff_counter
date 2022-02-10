import 'package:flutter_test/flutter_test.dart';
import 'package:kcounter/counters/actions/get_settings.dart';
import 'package:kcounter/counters/actions/update_settings.dart';
import 'package:kcounter/counters/entities/settings_dto.dart';
import 'package:mocktail/mocktail.dart';

import '../test_utils.dart';

void main() {
  test("It allows to update the current app settings", () async {
    final databaseMock = LocalDatabaseMock();
    final collectionRefMock = CollectionRefMock();
    final documentMock = DocumentRefMock();
    const settings = SettingsDto(online: true, authenticated: false);
    final action = UpdateSettings(db: databaseMock);

    when(() {
      return documentMock.set(any());
    }).thenAnswer((_) => Future.value());

    when(() {
      return documentMock.get();
    }).thenAnswer((_) => Future.value(settings.toMap()));

    when(() {
      return collectionRefMock.doc(any());
    }).thenReturn(documentMock);

    when(() {
      return databaseMock.collection(any());
    }).thenReturn(collectionRefMock);

    await action.run(
      UpdateSettingsParams(
        authenticated: settings.authenticated,
        online: settings.online,
      ),
    );

    verify(() => databaseMock.collection(settingsKey));
    verify(() => collectionRefMock.doc(settingsId));
    verify(() => documentMock.set(settings.toMap()));
  });
}
