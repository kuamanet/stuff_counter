import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/counters/core/counter_logger.dart';
import 'package:kcounter/counters/entities/counter_read_dto.dart';
import 'package:kcounter/extensions/color.dart';
import 'package:kcounter/extensions/context.dart';
import 'package:kcounter/riverpod_providers/riverpod_providers.dart';
import 'package:kcounter/theme/neumorphic_constants.dart';
import 'package:kcounter/theme/spacing_constants.dart';
import 'package:kcounter/widgets/counter_card_chart.dart';
import 'package:kcounter/widgets/counter_card_increase_button.dart';
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
                CounterCardIncreaseButton(
                  onPressed: () => _increaseCount(ref, context),
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
}
