import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/counters/actions/group_counter_logs.dart';
import 'package:kcounter/counters/entities/counter_read_dto.dart';
import 'package:kcounter/extensions/color.dart';
import 'package:kcounter/extensions/context.dart';
import 'package:kcounter/extensions/counter.dart';
import 'package:kcounter/riverpod_providers.dart';
import 'package:kcounter/theme/neumorphic_constants.dart';
import 'package:kcounter/theme/spacing_constants.dart';
import 'package:kcounter/widgets/counter_chart.dart';

class CounterCard extends ConsumerWidget {
  final CounterReadDto counter;
  const CounterCard({Key? key, required this.counter}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainColor = ColorExtension.fromCounterColor(counter.color);

    return Neumorphic(
      style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          depth: NeumorphicConstants.neumorphicDepth,
          color: mainColor.withOpacity(0.05),
          boxShape: NeumorphicConstants.boxShape),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: CountersSpacing.padding300, vertical: CountersSpacing.padding600),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                  ],
                ),
                const Spacer(),
                MaterialButton(
                  shape: const CircleBorder(),
                  textColor: Colors.white,
                  color: Colors.black,
                  padding: const EdgeInsets.all(CountersSpacing.padding300),
                  child: const Icon(Icons.arrow_upward),
                  onPressed: () async {
                    try {
                      final action = await ref.read(incrementCounterActionProvider.future);

                      await action.run(counter.id);

                      final router = ref.read(routeProvider.notifier);
                      context.snack("Counter was incremented 🚀🚀🚀🚀");
                      router.toDashboardPage();
                    } catch (e, s) {
                      context.snack("Could not increment counter");
                      print("Exception $e");
                      // print("StackTrace $s");
                    }
                  },
                )
              ],
            ),
            const SizedBox(
              height: CountersSpacing.midSpace,
            ),
            SizedBox(
                height: 100,
                child: GestureDetector(
                  onTap: () {
                    ref.read(routeProvider.notifier).toGraphPage(counter);
                  },
                  child: CounterChart(
                    color: mainColor,
                    counter: counter,
                    mode: GroupMode.day,
                    hideAxis: true,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
