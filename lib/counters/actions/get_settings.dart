import 'package:kcounter/counters/core/action.dart';
import 'package:kcounter/counters/entities/settings_dto.dart';
import 'package:localstore/localstore.dart';

class GetSettings extends StreamAction<SettingsDto> {
  final Localstore db;
  static const String settingsKey = "settings";

  GetSettings({required this.db});

  @override
  Stream<SettingsDto> run() {
    return db.collection(settingsKey).stream.map<SettingsDto>((event) => SettingsDto.from(event));
  }
}
