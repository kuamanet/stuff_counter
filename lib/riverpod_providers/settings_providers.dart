// Provides local persistence layer
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/counters/actions/get_settings.dart';
import 'package:kcounter/counters/actions/update_settings.dart';
import 'package:kcounter/counters/entities/settings_dto.dart';
import 'package:localstore/localstore.dart';

final localStoreProvider = Provider<Localstore>((_) => Localstore.instance);

final readLocalSettingsProvider = StreamProvider.autoDispose<SettingsDto>((ref) {
  final store = ref.read(localStoreProvider);
  final action = GetSettings(db: store);
  return action.run();
});

final readLocalSettingsOnceProvider = FutureProvider.autoDispose<SettingsDto>((ref) {
  final store = ref.read(localStoreProvider);
  final action = GetSettings(db: store);
  return action.run().first;
});

final updateLocalSettingsProvider = Provider<UpdateSettings>((ref) {
  final store = ref.read(localStoreProvider);
  return UpdateSettings(db: store);
});
