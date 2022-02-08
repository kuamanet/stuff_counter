import 'package:kcounter/counters/core/action.dart';
import 'package:kcounter/counters/entities/settings_dto.dart';
import 'package:localstore/localstore.dart';


const String settingsKey = "settings";
const String settingsId = "0";

class GetSettings extends StreamAction<SettingsDto> {
  final Localstore db;

  GetSettings({required this.db});

  @override
  Stream<SettingsDto> run() {
    return db.collection(settingsKey).stream.map<SettingsDto>((event) => SettingsDto.from(event[settingsId]));
  }
}
