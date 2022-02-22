import 'package:kcounter/counters/actions/get_settings.dart';
import 'package:kcounter/counters/core/action.dart';
import 'package:kcounter/counters/entities/settings_dto.dart';
import 'package:localstore/localstore.dart';

class UpdateSettingsParams {
  bool? authenticated;
  bool? online;
  bool? dailyReminder;

  UpdateSettingsParams({
    this.authenticated,
    this.online,
    this.dailyReminder,
  });
}

class UpdateSettings extends ParamsAction<UpdateSettingsParams, void> {
  final Localstore db;

  UpdateSettings({required this.db});

  @override
  Future<void> run(UpdateSettingsParams params) async {
    final collection = db.collection(settingsKey);
    final record = collection.doc(settingsId);

    final storedValue = await record.get();
    final value = storedValue == null ? SettingsDto.defaultValue() : SettingsDto.from(storedValue);
    final nextValue = value.copyWith(
      online: params.online ?? params.authenticated ?? value.online,
      dailyReminder: params.dailyReminder ?? value.dailyReminder,
      authenticated: params.authenticated ?? value.authenticated,
    );
    await record.set(nextValue.toMap());
  }
}
