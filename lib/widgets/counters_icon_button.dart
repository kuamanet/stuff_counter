import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CountersIconButton extends StatefulWidget {
  final EdgeInsets? padding;
  final IconData? icon;
  final Widget? child;
  final bool? loading;
  final bool? disableDepth;
  final void Function()? onPressed;
  final Color? color;
  final Color? background;
  const CountersIconButton({
    Key? key,
    this.icon,
    this.child,
    this.padding,
    this.disableDepth,
    this.color,
    this.background,
    this.onPressed,
    this.loading,
  }) : super(key: key);

  @override
  State<CountersIconButton> createState() => _CountersIconButtonState();
}

class _CountersIconButtonState extends State<CountersIconButton> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: widget.onPressed,
      style: NeumorphicStyle(
        color: widget.background ?? Colors.white,
        shape: NeumorphicShape.flat,
        disableDepth: widget.disableDepth,
        boxShape: const NeumorphicBoxShape.circle(),
      ),
      padding: widget.padding,
      child: widget.loading == true
          ? const Center(child: CircularProgressIndicator())
          : widget.icon != null
              ? Icon(
                  widget.icon,
                  color: widget.color,
                )
              : widget.child,
    );
  }
}
