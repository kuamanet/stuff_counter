import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:stuff_counter/theme/spacing_constants.dart';
import 'package:stuff_counter/widgets/color_picker_row.dart';
import 'package:stuff_counter/widgets/counters_rounded_button.dart';
import 'package:stuff_counter/widgets/counters_scaffold.dart';
import 'package:stuff_counter/widgets/counters_text_field.dart';

// TODO save counter
// TODO pop route
class CreateCounterPage extends StatelessWidget {
  CreateCounterPage({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CountersScaffold(
      child: Column(
        children: [
          Text(
            "Add counter",
            style: Theme.of(context).textTheme.headline5,
          ),
          CountersSpacing.spacer(),
          CountersTextField(
            hintText: "Name",
            controller: nameController,
          ),
          CountersSpacing.spacer(),
          colorPickerRow(onColorChanged: (color) {}),
          const Spacer(flex: 1),
          CountersRoundedButton(
            onPressed: () {
              if (nameController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Name is required"),
                  ),
                );
                return;
              }
              print("onClick ${nameController.text}");
            },
            loading: false,
            icon: Icons.check,
            padding: CountersSpacing.edgeInsetAll(),
          ),
        ],
      ),
    );
  }
}
