import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/authentication/entities/authentication_entities.dart';
import 'package:kcounter/counters/actions/update_settings.dart';
import 'package:kcounter/counters/core/counter_logger.dart';
import 'package:kcounter/counters/entities/settings_dto.dart';
import 'package:kcounter/extensions/context.dart';
import 'package:kcounter/riverpod_providers/riverpod_providers.dart';
import 'package:kcounter/theme/spacing_constants.dart';
import 'package:kcounter/widgets/authentication_dialog.dart';
import 'package:kcounter/widgets/counter_header.dart';
import 'package:kcounter/widgets/counters_scaffold.dart';
import 'package:kcounter/widgets/counters_switch.dart';
import 'package:kcounter/widgets/settings_logout_button.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(readLocalSettingsProvider);
    return CountersScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CounterHeader(title: "Settings"),
          CountersSpacing.spacer(),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Store counters online"),
                    CountersSwitch(
                      value: settings.value?.online ?? false,
                      onChanged: (value) async {
                        if (value == true) {
                          if (settings.value?.authenticated == true) {
                            // nothing to do

                            return;
                          }

                          AuthenticationResult result = await showDialog(
                            context: context,
                            builder: (_) => const AuthenticationDialog(),
                          );

                          if (result == AuthenticationResult.success) {
                            final action = await ref.read(localToRemoteActionProvider.future);

                            await action.run();

                            await _updateLocalSettings(
                              value: value,
                              context: context,
                              ref: ref,
                              settings: settings,
                              authenticated: true,
                            );
                          }
                        } else {
                          if (settings.value == null || settings.value?.authenticated == false) {
                            // nothing to do

                            return;
                          }

                          _onLogout(ref);
                        }
                      },
                    ),
                  ],
                ),
                const Spacer(),
                SettingsLogoutButton(
                  onPressed: () => _onLogout(ref),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _onLogout(WidgetRef ref) async {
    try {
      final action = await ref.read(remoteToLocalActionProvider.future);

      await action.run();

      await ref.read(signOutProvider.future);
    } catch (error, stacktrace) {
      CounterLogger.error("While trying to sign out", error, stacktrace);
    }
  }

  Future<void> _updateLocalSettings({
    required bool value,
    bool? authenticated,
    required WidgetRef ref,
    required BuildContext context,
    required AsyncValue<SettingsDto> settings,
  }) async {
    final action = ref.read(updateLocalSettingsProvider);
    try {
      await action.run(UpdateSettingsParams(online: value, authenticated: authenticated ?? false));
      CounterLogger.info("updated settings authenticated ${authenticated}");
    } catch (error, stacktrace) {
      context.snack("Could not update settings");
      CounterLogger.error("While updating the settings", error, stacktrace);
    }
  }
}
