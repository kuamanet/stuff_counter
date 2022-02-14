import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/builders/counters_list_stream_builder.dart';
import 'package:kcounter/riverpod_providers/riverpod_providers.dart';
import 'package:kcounter/theme/spacing_constants.dart';
import 'package:kcounter/widgets/counters_icon_button.dart';
import 'package:shake/shake.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardPage();
}

class _DashboardPage extends ConsumerState<DashboardPage> {
  bool showSecretCounters = false;

  late ShakeDetector _detector;

  @override
  void initState() {
    _detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        setState(() {
          showSecretCounters = !showSecretCounters;
        });
      },
      // shakeThresholdGravity: 0,
      // shakeSlopTimeMS: 0,
      // shakeCountResetTime: 0,
    );
    super.initState();
  }

  @override
  void dispose() {
    _detector.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.read(routeProvider.notifier);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CountersIconButton(
        icon: Icons.add,
        padding: const EdgeInsets.all(CountersSpacing.padding300),
        onPressed: () {
          router.toCreatePage();
        },
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          CountersListStreamBuilder(
            action: ref.read(listCounterActionProvider),
            showSecretCounters: showSecretCounters,
          ),
          Positioned(
            right: CountersSpacing.smallSpace,
            top: CountersSpacing.safeSpace,
            child: CountersIconButton(
              disableDepth: true,
              icon: Icons.more_vert,
              onPressed: () {
                router.toSettingsPage();
              },
            ),
          ),
        ],
      ),
    );
  }
}
