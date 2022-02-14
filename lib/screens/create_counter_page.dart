import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/counters/actions/create_counter.dart';
import 'package:kcounter/counters/core/counter_logger.dart';
import 'package:kcounter/extensions/color.dart';
import 'package:kcounter/extensions/context.dart';
import 'package:kcounter/riverpod_providers/riverpod_providers.dart';
import 'package:kcounter/theme/spacing_constants.dart';
import 'package:kcounter/widgets/color_picker_row.dart';
import 'package:kcounter/widgets/counter_header.dart';
import 'package:kcounter/widgets/counters_icon_button.dart';
import 'package:kcounter/widgets/counters_scaffold.dart';
import 'package:kcounter/widgets/counters_text_field.dart';

class CreateCounterPage extends ConsumerStatefulWidget {
  const CreateCounterPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateCounterPage> createState() => _CreateCounterPageState();
}

class _CreateCounterPageState extends ConsumerState<CreateCounterPage> {
  final TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  Color? counterColor;
  bool secretCounter = false;

  @override
  Widget build(BuildContext context) {
    return CountersScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CounterHeader(title: "Add counter"),
          CountersSpacing.spacer(),
          CountersTextField(
            hintText: "Name",
            controller: nameController,
          ),
          CountersSpacing.spacer(),
          ColorPickerRow(onColorChanged: (color) {
            counterColor = color;
          }),
          CountersSpacing.spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Should this counter be secret?"),
                    CountersSpacing.spacer(height: CountersSpacing.smallSpace),
                    Text(
                      "If you activate this option, this counter will be visible only when you shake your phone",
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: CountersSpacing.midSpace),
              NeumorphicSwitch(
                style: const NeumorphicSwitchStyle(
                  inactiveTrackColor: Colors.white,
                  inactiveThumbColor: Colors.white,
                  activeThumbColor: Colors.black,
                  activeTrackColor: Colors.white,
                ),
                value: secretCounter,
                onChanged: (secretSwitchValue) {
                  setState(() {
                    secretCounter = secretSwitchValue;
                  });
                },
              ),
            ],
          ),
          const Spacer(flex: 1),
          CountersIconButton(
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
                final action = ref.read(createCounterActionProvider);

                await action.run(
                  CreateCounterParams(
                    name: nameController.text,
                    color: counterColor!.asCounterColor(),
                    secret: secretCounter,
                  ),
                );

                final router = ref.read(routeProvider.notifier);
                context.snack("Counter ${nameController.text} was created 🚀🚀🚀🚀");
                router.toDashboardPage();
              } catch (error, stacktrace) {
                context.snack("Could not create counter");
                CounterLogger.error("While creating the counter", error, stacktrace);
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
