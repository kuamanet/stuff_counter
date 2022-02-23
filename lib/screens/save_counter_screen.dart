import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/counters/actions/create_counter.dart';
import 'package:kcounter/counters/actions/update_counter.dart';
import 'package:kcounter/counters/core/counter_logger.dart';
import 'package:kcounter/counters/entities/counter_read_dto.dart';
import 'package:kcounter/extensions/color.dart';
import 'package:kcounter/extensions/context.dart';
import 'package:kcounter/riverpod_providers/riverpod_providers.dart';
import 'package:kcounter/theme/spacing_constants.dart';
import 'package:kcounter/widgets/color_picker_row.dart';
import 'package:kcounter/widgets/counter_header.dart';
import 'package:kcounter/widgets/counters_icon_button.dart';
import 'package:kcounter/widgets/counters_scaffold.dart';
import 'package:kcounter/widgets/counters_switch.dart';
import 'package:kcounter/widgets/counters_text_field.dart';

class SaveCounterScreen extends ConsumerStatefulWidget {
  static const valueKey = ValueKey("SaveCounterPage");

  const SaveCounterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SaveCounterScreen> createState() => _SaveCounterScreenState();
}

class _SaveCounterScreenState extends ConsumerState<SaveCounterScreen> {
  final TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  Color? counterColor;
  bool secretCounter = false;
  CounterReadDto? counter;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 0), () {
      counter = ref.watch(routeProvider).currentCounter;
      secretCounter = counter?.secret ?? secretCounter;
      nameController.text = counter?.name ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return CountersScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CounterHeader(
            title: counter != null ? "Update ${counter?.name}" : "Add counter",
            onBack: () {
              final router = ref.read(routeProvider.notifier);
              if (counter != null) {
                router.toGraphPage(counter!);
              } else {
                router.toDashboardPage();
              }
            },
          ),
          CountersSpacing.spacer(),
          CountersTextField(
            hintText: "Name",
            controller: nameController,
          ),
          CountersSpacing.spacer(),
          ColorPickerRow(
            onColorChanged: (color) {
              counterColor = color;
            },
            color: counter?.color,
          ),
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
                    CountersSpacing.spacer(height: CountersSpacing.space100),
                    Text(
                      "If you activate this option, this counter will be visible only when you shake your phone",
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: CountersSpacing.space600),
              CountersSwitch(
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
              if (!_validate()) {
                return;
              }

              setState(() {
                isLoading = true;
              });

              if (counter != null) {
                await _updateCounter(counter!);
              } else {
                await _createCounter();
              }

              setState(() {
                isLoading = false;
              });
            },
            loading: isLoading,
            icon: Icons.check,
            padding: CountersSpacing.edgeInsetAll(),
          ),
        ],
      ),
    );
  }

  bool _validate() {
    if (nameController.text.isEmpty) {
      context.snack("Name is required");
      return false;
    }

    if (counterColor == null) {
      context.snack("Color is required");
      return false;
    }

    return true;
  }

  Future _createCounter() async {
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
    }
  }

  Future _updateCounter(CounterReadDto counter) async {
    try {
      final action = ref.read(updateCounterActionProvider);

      await action.run(
        UpdateCounterParams(
          name: nameController.text,
          color: counterColor!.asCounterColor(),
          secret: secretCounter,
          id: counter.id,
        ),
      );

      final router = ref.read(routeProvider.notifier);
      context.snack("Counter ${nameController.text} was updated 🚀🚀🚀🚀");

      final readAction = ref.read(readCounterActionProvider);
      final updatedCounter = await readAction.run(counter.id);
      router.toGraphPage(updatedCounter);
    } catch (error, stacktrace) {
      context.snack("Could not create counter");
      CounterLogger.error("While creating the counter", error, stacktrace);
    }
  }
}
