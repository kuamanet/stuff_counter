import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/counters/actions/group_counter_logs.dart';
import 'package:kcounter/counters/entities/counter_read_dto.dart';
import 'package:kcounter/extensions/color.dart';
import 'package:kcounter/extensions/counter.dart';
import 'package:kcounter/theme/neumorphic_constants.dart';
import 'package:kcounter/theme/spacing_constants.dart';
import 'package:kcounter/widgets/counter_graph.dart';

// TODO can this be stateless?
class Counter extends ConsumerStatefulWidget {
  final CounterReadDto counter;
  const Counter({Key? key, required this.counter}) : super(key: key);

  @override
  ConsumerState<Counter> createState() => _CounterState();
}

class _CounterState extends ConsumerState<Counter> {
  @override
  Widget build(BuildContext context) {
    final mainColor = ColorExtension.fromCounterColor(widget.counter.color);

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
                      widget.counter.lastUpdate,
                      style: TextStyle(color: mainColor.withOpacity(0.4)),
                    ),
                    Text(
                      widget.counter.count.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          ?.copyWith(color: mainColor, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.counter.name,
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
                  child: const Icon(Icons.add),
                  onPressed: () {
                    // TODO increase counter
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
                    // TODO go to graph
                  },
                  child: CounterGraph(
                    color: mainColor,
                    logs: widget.counter.history,
                    mode: GroupMode.day,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}