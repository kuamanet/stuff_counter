import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CountersSwitch extends NeumorphicSwitch {
  const CountersSwitch({
    required value,
    ValueChanged<bool>? onChanged,
    Key? key,
  }) : super(
          style: const NeumorphicSwitchStyle(
            inactiveTrackColor: Colors.white,
            inactiveThumbColor: Colors.white,
            activeThumbColor: Colors.black,
            activeTrackColor: Colors.white,
          ),
          value: value,
          onChanged: onChanged,
          key: key,
        );
}
