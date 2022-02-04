import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/counters/actions/create_counter.dart';
import 'package:kcounter/extensions/color.dart';
import 'package:kcounter/extensions/context.dart';
import 'package:kcounter/main.dart';
import 'package:kcounter/theme/spacing_constants.dart';
import 'package:kcounter/widgets/color_picker_row.dart';
import 'package:kcounter/widgets/counters_rounded_button.dart';
import 'package:kcounter/widgets/counters_scaffold.dart';
import 'package:kcounter/widgets/counters_text_field.dart';

// TODO save counter
// TODO pop route
class CreateCounterPage extends ConsumerStatefulWidget {
  const CreateCounterPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateCounterPage> createState() => _CreateCounterPageState();
}

class _CreateCounterPageState extends ConsumerState<CreateCounterPage> {
  final TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  Color? counterColor;

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
          colorPickerRow(onColorChanged: (color) {
            counterColor = color;
          }),
          const Spacer(flex: 1),
          CountersRoundedButton(
            onPressed: () async {
              if (nameController.text.isEmpty) {
                context.snack("Name is required");
                return;
              }

              if (counterColor == null) {
                context.snack("Color is required");
                return;
              }

              setState(() {
                isLoading = true;
              });

              try {
                final action = await ref.read(createCounterActionProvider.future);

                await action.run(CreateCounterParams(
                  name: nameController.text,
                  color: counterColor!.asCounterColor(),
                ));

                final router = ref.read(routeProvider.notifier);
                context.snack("Counter was created 🚀🚀🚀🚀");
                router.toDashboardPage();
              } catch (e, s) {
                context.snack("Could not create counter");
                print("Exception $e");
                print("StackTrace $s");
              } finally {
                setState(() {
                  isLoading = false;
                });
              }
            },
            loading: isLoading,
            icon: Icons.check,
            padding: CountersSpacing.edgeInsetAll(),
          ),
        ],
      ),
    );
  }
}
