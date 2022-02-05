import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/counters/actions/group_counter_logs.dart';
import 'package:kcounter/extensions/color.dart';
import 'package:kcounter/extensions/counter.dart';
import 'package:kcounter/riverpod_providers.dart';
import 'package:kcounter/theme/spacing_constants.dart';
import 'package:kcounter/widgets/counter_chart.dart';
import 'package:kcounter/widgets/counters_button.dart';
import 'package:kcounter/widgets/counters_icon_button.dart';

class CounterChartPage extends ConsumerStatefulWidget {
  const CounterChartPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CounterChartPage> createState() => _CounterChartPageState();
}

class _CounterChartPageState extends ConsumerState<CounterChartPage> {
  GroupMode currentMode = GroupMode.month;

  @override
  void initState() {
    _setCurrentGroupMode(currentMode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final counter = ref.watch(routeProvider).currentCounter;
    if (counter == null) {
      return const SizedBox.shrink();
    }
    final mainColor = ColorExtension.fromCounterColor(counter.color);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            CountersSpacing.midSpace,
            CountersSpacing.padding900,
            CountersSpacing.midSpace,
            CountersSpacing.padding900,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  CountersIconButton(
                    color: Colors.white,
                    background: Colors.black,
                    icon: Icons.arrow_back,
                    onPressed: () {
                      final router = ref.read(routeProvider.notifier);
                      router.toDashboardPage();
                    },
                  ),
                ],
              ),
              const SizedBox(height: CountersSpacing.midSpace),
              Text(
                counter.lastUpdate,
                style: TextStyle(color: mainColor.withOpacity(0.4)),
              ),
              Text(
                counter.count.toString(),
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    ?.copyWith(color: mainColor, fontWeight: FontWeight.bold),
              ),
              Text(
                counter.name,
                style: TextStyle(color: mainColor.withOpacity(0.4)),
              ),
              const SizedBox(height: CountersSpacing.midSpace),
              Wrap(
                alignment: WrapAlignment.spaceAround,
                children: [
                  CountersButton(
                    text: "By month",
                    background: currentMode == GroupMode.month ? Colors.black : Colors.white,
                    color: currentMode == GroupMode.month ? Colors.white : Colors.black,
                    onPressed: () {
                      _setCurrentGroupMode(GroupMode.month);
                    },
                  ),
                  CountersButton(
                    text: "By week",
                    background: currentMode == GroupMode.week ? Colors.black : Colors.white,
                    color: currentMode == GroupMode.week ? Colors.white : Colors.black,
                    onPressed: () {
                      _setCurrentGroupMode(GroupMode.week);
                    },
                  ),
                  CountersButton(
                    text: "By day",
                    background: currentMode == GroupMode.day ? Colors.black : Colors.white,
                    color: currentMode == GroupMode.day ? Colors.white : Colors.black,
                    onPressed: () {
                      _setCurrentGroupMode(GroupMode.day);
                    },
                  ),
                ],
              ),
              const SizedBox(height: CountersSpacing.midSpace),
              SizedBox(
                height: 250,
                child: CounterChart(
                  counter: counter,
                  mode: currentMode,
                  color: mainColor,
                  id: "chart",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _setCurrentGroupMode(GroupMode mode) {
    // Pick the counter from the route
    final counter = ref.read(routeProvider).currentCounter;

    if (counter != null) {
      final grouper = ref.read(counterLogsGrouperProvider.notifier);

      // start grouped by month
      grouper.group(
        CounterLogsGrouperParams(
          counter: counter,
          mode: mode,
          id: "chart",
        ),
      );

      setState(() {
        currentMode = mode;
      });
    }
  }
}
