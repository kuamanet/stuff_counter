import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kcounter/theme/spacing_constants.dart';

class CountersButton extends StatefulWidget {
  final EdgeInsets? padding;
  final String text;
  final void Function() onPressed;
  final Color? background;
  final Color? color;
  final String? icon;

  const CountersButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.padding,
    this.background,
    this.color,
    this.icon,
  }) : super(key: key);

  @override
  State<CountersButton> createState() => _CountersButtonState();
}

class _CountersButtonState extends State<CountersButton> {
  @override
  Widget build(BuildContext context) {
    final text = Text(
      widget.text.toUpperCase(),
      style: TextStyle(
        color: widget.color,
      ),
      textAlign: TextAlign.center,
    );
    return NeumorphicButton(
      onPressed: widget.onPressed,
      style: NeumorphicStyle(
        color: widget.background ?? Colors.white,
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(
            const BorderRadius.all(Radius.circular(CountersSpacing.padding300))),
      ),
      padding: widget.padding,
      child: widget.icon != null
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  widget.icon!,
                  semanticsLabel: widget.text,
                  height: CountersSpacing.midSpace,
                ),
                text
              ],
            )
          : text,
    );
  }
}
