import 'package:firebase_auth/firebase_auth.dart';
import 'package:kcounter/authentication/entities/authentication_entities.dart';
import 'package:kcounter/counters/actions/update_settings.dart';
import 'package:kcounter/counters/core/action.dart';
import 'package:kcounter/counters/core/counter_logger.dart';

class AuthenticationStateStream extends StreamAction<Authentication> {
  final UpdateSettings updateLocalSettingsAction;

  AuthenticationStateStream({required this.updateLocalSettingsAction});

  @override
  Stream<Authentication> run() async* {
    yield* FirebaseAuth.instance.userChanges().asyncMap((User? user) async {
      if (user == null) {
        // ensure settings are coherent with state
        try {
          await updateLocalSettingsAction.run(UpdateSettingsParams(authenticated: false));
        } catch (error, stacktrace) {
          CounterLogger.error("While trying to update settings", error, stacktrace);
        }

        return Authentication(state: AuthenticationState.signedOut);
      }

      await updateLocalSettingsAction.run(UpdateSettingsParams(authenticated: true, online: true));
      return Authentication(
        state: AuthenticationState.signedIn,
        username: user.displayName,
        uid: user.uid,
      );
    });
  }
}
