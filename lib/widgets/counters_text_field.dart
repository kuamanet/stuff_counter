import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:kcounter/theme/neuorphic_constants.dart';
import 'package:kcounter/theme/spacing_constants.dart';

class CountersTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const CountersTextField({Key? key, required this.hintText, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        boxShape: CountersSpacing.countersInputBoxShape,
        depth: NeumorphicConstants.neumorphicDepth,
        lightSource: LightSource.topLeft,
      ),
      child: TextField(
        controller: controller,
        autocorrect: false,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(CountersSpacing.padding300),
          hintText: hintText,
        ),
      ),
    );
  }
}
