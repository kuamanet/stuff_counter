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
                    NeumorphicSwitch(
                      style: const NeumorphicSwitchStyle(
                        inactiveTrackColor: Colors.white,
                        inactiveThumbColor: Colors.white,
                        activeThumbColor: Colors.black,
                        activeTrackColor: Colors.white,
                      ),
                      value: settings.value?.online ?? false,
                      onChanged: (value) async {
                        if (value == true && (settings.value?.authenticated ?? false) == false) {
                          AuthenticationResult result = await showDialog(
                            context: context,
                            builder: (_) => const AuthenticationDialog(),
                          );

                          if (result == AuthenticationResult.success) {
                            // TODO copy local counters to remote

                            await _updateLocalSettings(
                              value: value,
                              context: context,
                              ref: ref,
                              settings: settings,
                              authenticated: true,
                            );
                          }
                        } else {
                          // TODO copy remote counters to local
                          await _updateLocalSettings(
                            value: value,
                            context: context,
                            ref: ref,
                            settings: settings,
                          );
                        }
                      },
                    ),
                  ],
                ),
                const Spacer(),
                const SettingsLogoutButton(),
              ],
            ),
          )
        ],
      ),
    );
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
