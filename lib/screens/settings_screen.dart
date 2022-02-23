import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/authentication/entities/authentication_entities.dart';
import 'package:kcounter/counters/actions/update_settings.dart';
import 'package:kcounter/counters/core/counter_logger.dart';
import 'package:kcounter/counters/entities/settings_dto.dart';
import 'package:kcounter/counters_app.dart';
import 'package:kcounter/extensions/context.dart';
import 'package:kcounter/riverpod_providers/riverpod_providers.dart';
import 'package:kcounter/theme/spacing_constants.dart';
import 'package:kcounter/widgets/authentication_dialog.dart';
import 'package:kcounter/widgets/counter_header.dart';
import 'package:kcounter/widgets/counters_scaffold.dart';
import 'package:kcounter/widgets/counters_switch.dart';
import 'package:kcounter/widgets/settings_logout_button.dart';
import 'package:timezone/timezone.dart' as tz;

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Daily reminder"),
                          CountersSpacing.spacer(height: CountersSpacing.space100),
                          Text(
                            "Remind me each day at 10PM to check if I updated my counters ⏰",
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: CountersSpacing.space600),
                    CountersSwitch(
                      value: settings.value?.dailyReminder ?? false,
                      onChanged: (value) async {
                        await _updateDailyReminder(value, ref, context);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: CountersSpacing.space600),
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
                              online: value,
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
    required bool online,
    bool? authenticated,
    required WidgetRef ref,
    required BuildContext context,
    required AsyncValue<SettingsDto> settings,
  }) async {
    final action = ref.read(updateLocalSettingsProvider);
    try {
      await action.run(UpdateSettingsParams(online: online, authenticated: authenticated ?? false));
    } catch (error, stacktrace) {
      context.snack("Could not update settings");
      CounterLogger.error("While updating the settings", error, stacktrace);
    }
  }

  Future<void> _updateDailyReminder(bool active, WidgetRef ref, BuildContext context) async {
    if (active) {
      await _requestPermissions();
      await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        "Hey!",
        "Did you update your counters?",
        _nextInstanceOfTenPM(),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            "kcounters",
            "kcounters",
            channelDescription: "KCounter's daily reminder",
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    } else {
      await flutterLocalNotificationsPlugin.cancelAll();
    }

    final action = ref.read(updateLocalSettingsProvider);
    try {
      await action.run(UpdateSettingsParams(dailyReminder: active));
    } catch (error, stacktrace) {
      context.snack("Could not update settings");
      CounterLogger.error("While updating the settings", error, stacktrace);
    }
  }

  tz.TZDateTime _nextInstanceOfTenPM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, 22);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<bool?>? _requestPermissions() {
    return flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }
}
