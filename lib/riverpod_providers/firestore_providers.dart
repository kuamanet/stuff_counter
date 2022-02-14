import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/authentication/actions/authenticate.dart';
import 'package:kcounter/authentication/actions/authentication_state.dart';
import 'package:kcounter/authentication/entities/authentication_entities.dart';
import 'package:kcounter/counters/actions/update_settings.dart';
import 'package:kcounter/riverpod_providers/settings_providers.dart';

final authStreamProvider = FutureProvider.autoDispose<AuthenticationStateStream>((ref) async {
  final updateLocalSettingsAction = ref.read(updateLocalSettingsProvider);

  return AuthenticationStateStream(updateLocalSettingsAction: updateLocalSettingsAction);
});

final authProvider = StreamProvider<Authentication>((ref) async* {
  final action = await ref.read(authStreamProvider.future);

  yield* action.run();
});

final signOutProvider = FutureProvider.autoDispose((ref) async {
  final action = ref.read(updateLocalSettingsProvider);
  await action.run(UpdateSettingsParams(online: false));
  await FirebaseAuth.instance.signOut();
});

final signInActionProvider = Provider.autoDispose((_) {
  return Authenticate();
});
