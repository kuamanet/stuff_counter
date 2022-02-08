import 'package:flutter/material.dart';
import 'package:kcounter/counters/entities/counter_read_dto.dart';
import 'package:kcounter/extensions/color.dart';
import 'package:kcounter/extensions/counter.dart';

class CounterDetails extends StatelessWidget {
  final CounterReadDto counter;

  const CounterDetails({required this.counter, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          counter.lastUpdate,
          style: TextStyle(color: ColorExtension.fromCounterColor(counter.color).withOpacity(0.8)),
        ),
        Text(
          counter.count.toString(),
          style: Theme.of(context).textTheme.headline3?.copyWith(
              color: ColorExtension.fromCounterColor(counter.color), fontWeight: FontWeight.bold),
        ),
        Text(
          counter.name,
          style: TextStyle(color: ColorExtension.fromCounterColor(counter.color).withOpacity(0.8)),
        ),
      ],
    );
  }
}
