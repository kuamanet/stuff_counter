import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/counters/actions/group_counter_logs.dart';
import 'package:kcounter/counters/core/counter_logger.dart';
import 'package:kcounter/extensions/color.dart';
import 'package:kcounter/extensions/context.dart';
import 'package:kcounter/riverpod_providers/riverpod_providers.dart';
import 'package:kcounter/theme/spacing_constants.dart';
import 'package:kcounter/widgets/counter_back_button.dart';
import 'package:kcounter/widgets/counter_chart.dart';
import 'package:kcounter/widgets/counter_details.dart';
import 'package:kcounter/widgets/counters_button.dart';
import 'package:kcounter/widgets/group_mode_button.dart';

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
            CountersSpacing.space600,
            CountersSpacing.padding900,
            CountersSpacing.space600,
            CountersSpacing.padding900,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: const [
                  CounterBackButton(),
                ],
              ),
              const SizedBox(height: CountersSpacing.space600),
              CounterDetails(counter: counter),
              const SizedBox(height: CountersSpacing.space600),
              Wrap(
                // TODO try to make this a row
                alignment: WrapAlignment.spaceAround,
                children: [
                  GroupModeButton(
                    mode: GroupMode.month,
                    onPressed: _setCurrentGroupMode,
                    selected: currentMode == GroupMode.month,
                  ),
                  GroupModeButton(
                    mode: GroupMode.week,
                    onPressed: _setCurrentGroupMode,
                    selected: currentMode == GroupMode.week,
                  ),
                  GroupModeButton(
                    mode: GroupMode.day,
                    onPressed: _setCurrentGroupMode,
                    selected: currentMode == GroupMode.day,
                  ),
                ],
              ),
              const SizedBox(height: CountersSpacing.space600),
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
                height: CountersSpacing.space900,
              ),
              CountersButton(
                text: "Update",
                background: Colors.black,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: CountersSpacing.padding300,
                  horizontal: CountersSpacing.padding300,
                ),
                onPressed: () {
                  final router = ref.read(routeProvider.notifier);
                  router.toUpdatePage(counter);
                },
              ),
              const SizedBox(
                height: CountersSpacing.space600,
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
                    builder: (BuildContext context) => alert,
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

  void _deleteCounter() async {
    try {
      final counter = ref.read(routeProvider).currentCounter;
      if (counter == null) {
        return;
      }
      final action = ref.read(deleteCounterActionProvider);

      await action.run(counter.id);

      final router = ref.read(routeProvider.notifier);
      context.snack("Counter was deleted");
      Navigator.of(context, rootNavigator: true).pop();
      router.toDashboardPage();
    } catch (error, stacktrace) {
      context.snack("Could not delete counter");
      CounterLogger.error("While deleting the counter", error, stacktrace);
    }
  }
}
