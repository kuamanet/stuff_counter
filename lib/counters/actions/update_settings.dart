import 'package:kcounter/counters/actions/get_settings.dart';
import 'package:kcounter/counters/core/action.dart';
import 'package:kcounter/counters/entities/settings_dto.dart';
import 'package:localstore/localstore.dart';

class UpdateSettings extends ParamsAction<SettingsDto, void> {
  final Localstore db;

  UpdateSettings({required this.db});

  @override
  Future<void> run(SettingsDto params) async {
    final collection = db.collection(settingsKey);
    final record = collection.doc(settingsId);
    await record.set(params.toMap());
  }
}
