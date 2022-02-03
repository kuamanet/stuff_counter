import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CountersRoundedButton extends StatefulWidget {
  final EdgeInsets? padding;
  final IconData icon;
  final bool? loading;
  final void Function()? onPressed;
  const CountersRoundedButton({
    Key? key,
    this.padding,
    this.onPressed,
    this.loading,
    required this.icon,
  }) : super(key: key);

  @override
  State<CountersRoundedButton> createState() => _CountersRoundedButtonState();
}

class _CountersRoundedButtonState extends State<CountersRoundedButton> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: widget.onPressed,
      style: const NeumorphicStyle(
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.circle(),
      ),
      padding: widget.padding,
      child: widget.loading == true
          ? const CircularProgressIndicator()
          : Icon(
              widget.icon,
            ),
    );
  }
}
