import 'package:flutter/material.dart';
import 'package:kcounter/theme/spacing_constants.dart';
import 'package:kcounter/widgets/counter_back_button.dart';

class CounterHeader extends StatelessWidget {
  final String? title;
  final Widget? content;
  final void Function()? onBack;

  const CounterHeader({
    this.title,
    this.content,
    this.onBack,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CounterBackButton(
          onPressed: onBack,
        ),
        const SizedBox(height: CountersSpacing.space600),
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
