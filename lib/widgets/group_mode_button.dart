import 'package:flutter/material.dart';
import 'package:kcounter/counters/actions/group_counter_logs.dart';
import 'package:kcounter/widgets/counters_button.dart';

class GroupModeButton extends StatelessWidget {
  String get label {
    switch (mode) {
      case GroupMode.day:
        return "By day";
      case GroupMode.week:
        return "By week";
      case GroupMode.month:
        return "By month";
    }
  }

  final GroupMode mode;
  final Function(GroupMode) onPressed;
  final bool selected;

  const GroupModeButton({
    required this.mode,
    required this.onPressed,
    required this.selected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CountersButton(
      text: label,
      background: selected ? Colors.black : Colors.white,
      color: selected ? Colors.white : Colors.black,
      onPressed: () {
        onPressed(mode);
      },
    );
  }
}
