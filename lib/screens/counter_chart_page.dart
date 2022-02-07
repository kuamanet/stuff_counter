import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/counters/actions/group_counter_logs.dart';
import 'package:kcounter/extensions/color.dart';
import 'package:kcounter/extensions/context.dart';
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

  Widget cancelDeleteBtn = TextButton(
    child: const Text("Cancel"),
    onPressed: () {},
  );

  late Widget confirmDeleteBtn;

  late AlertDialog alert;

  @override
  void initState() {
    _setCurrentGroupMode(currentMode);

    confirmDeleteBtn = ElevatedButton(
      child: const Text("Yes, I'm sure, delete this counter!"),
      onPressed: () => _deleteCounter(),
    );

    alert = AlertDialog(
      title: const Text("Destructive action"),
      content: const Text("This will remove your counter and its history, are you sure?"),
      actions: [
        cancelDeleteBtn,
        confirmDeleteBtn,
      ],
    );

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
                  _counterButtonFor(GroupMode.month),
                  _counterButtonFor(GroupMode.day),
                  _counterButtonFor(GroupMode.week),
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
              const SizedBox(
                height: 80,
              ),
              CountersButton(
                text: "Delete",
                background: Colors.redAccent,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: CountersSpacing.padding300,
                  horizontal: CountersSpacing.padding300,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                },
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

  Widget _counterButtonFor(GroupMode mode) {
    String label;
    switch (mode) {
      case GroupMode.day:
        label = "By day";
        break;
      case GroupMode.week:
        label = "By week";
        break;
      case GroupMode.month:
        label = "By month";
        break;
    }
    return CountersButton(
      text: label,
      background: currentMode == mode ? Colors.black : Colors.white,
      color: currentMode == mode ? Colors.white : Colors.black,
      onPressed: () {
        _setCurrentGroupMode(mode);
      },
    );
  }

  void _deleteCounter() async {
    try {
      final counter = ref.read(routeProvider).currentCounter;
      if (counter == null) {
        return;
      }
      final action = await ref.read(deleteCounterActionProvider.future);

      await action.run(counter.id);

      final router = ref.read(routeProvider.notifier);
      context.snack("Counter was deleted");
      Navigator.of(context, rootNavigator: true).pop();
      router.toDashboardPage();
    } catch (e, s) {
      context.snack("Could not delete counter");
      // print("Exception $e");
      // print("StackTrace $s");
    }
  }
}
