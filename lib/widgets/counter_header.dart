import 'package:flutter/material.dart';
import 'package:kcounter/theme/spacing_constants.dart';
import 'package:kcounter/widgets/counter_back_button.dart';

class CounterHeader extends StatelessWidget {
  final String? title;
  final Widget? content;
  const CounterHeader({this.title, this.content, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CounterBackButton(),
        const SizedBox(height: CountersSpacing.midSpace),
        if (content != null) content!,
        if (title != null)
          Text(
            title!,
            style: Theme.of(context).textTheme.headline5,
          )
      ],
    );
  }
}
