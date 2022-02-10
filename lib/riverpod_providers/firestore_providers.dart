import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/authentication/actions/authenticate.dart';
import 'package:kcounter/authentication/actions/authentication_state.dart';
import 'package:kcounter/authentication/entities/authentication_entities.dart';
import 'package:kcounter/firebase_options.dart';
import 'package:kcounter/riverpod_providers/settings_providers.dart';

final firebaseProvider = FutureProvider<FirebaseApp>((_) async {
  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    // Force disable Crashlytics collection while doing every day development.
    // Temporarily toggle this to true if you want to test crash reporting in your app.
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }

  return app;
});

final authStreamProvider = FutureProvider.autoDispose<AuthenticationStateStream>((ref) async {
  final updateLocalSettingsAction = ref.read(updateLocalSettingsProvider);

  return AuthenticationStateStream(updateLocalSettingsAction: updateLocalSettingsAction);
});

final authProvider = StreamProvider.autoDispose<Authentication>((ref) async* {
  final action = await ref.read(authStreamProvider.future);

  yield* action.run();
});

final signOutProvider = FutureProvider.autoDispose((ref) async {
  await ref.read(firebaseProvider.future);
  await FirebaseAuth.instance.signOut();
});

final signInActionProvider = Provider.autoDispose((_) {
  return Authenticate();
});
