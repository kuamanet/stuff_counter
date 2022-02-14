import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/counters/core/counter_logger.dart';
import 'package:kcounter/counters/entities/counter_read_dto.dart';
import 'package:kcounter/extensions/color.dart';
import 'package:kcounter/extensions/context.dart';
import 'package:kcounter/riverpod_providers/riverpod_providers.dart';
import 'package:kcounter/theme/neumorphic_constants.dart';
import 'package:kcounter/theme/spacing_constants.dart';
import 'package:kcounter/widgets/counter_card_button.dart';
import 'package:kcounter/widgets/counter_card_chart.dart';
import 'package:kcounter/widgets/counter_details.dart';

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
          horizontal: CountersSpacing.padding300,
          vertical: CountersSpacing.padding600,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                CounterDetails(counter: counter),
                const Spacer(),
                Column(
                  children: [
                    CounterCardButton(
                      onPressed: () => _increaseCount(ref, context),
                      color: Colors.white,
                      background: Colors.black,
                      icon: Icons.arrow_upward,
                    ),
                    const SizedBox(height: CountersSpacing.smallSpace),
                    if (counter.count > 0)
                      CounterCardButton(
                        onPressed: () => _decreaseCount(ref, context),
                        color: Colors.black,
                        background: Colors.white,
                        icon: Icons.arrow_downward,
                        elevation: 0,
                        size: CountersSpacing.padding100,
                      ),
                  ],
                )
              ],
            ),
            CountersSpacing.spacer(),
            CounterCardChart(counter: counter)
          ],
        ),
      ),
    );
  }

  void _increaseCount(WidgetRef ref, BuildContext context) async {
    try {
      final action = ref.read(incrementCounterActionProvider);

      await action.run(counter.id);

      final router = ref.read(routeProvider.notifier);
      context.snack("Counter was incremented 🚀🚀🚀🚀");
      router.toDashboardPage();
    } catch (error, stacktrace) {
      context.snack("Could not increment counter");
      CounterLogger.error("While incrementing the counter", error, stacktrace);
    }
  }

  void _decreaseCount(WidgetRef ref, BuildContext context) async {
    try {
      final action = ref.read(decreaseCounterActionProvider);

      await action.run(counter.id);

      final router = ref.read(routeProvider.notifier);
      context.snack("Counter was decreased 🚀🚀🚀🚀");
      router.toDashboardPage();
    } catch (error, stacktrace) {
      context.snack("Could not decrement counter");
      CounterLogger.error("While incrementing the counter", error, stacktrace);
    }
  }
}
