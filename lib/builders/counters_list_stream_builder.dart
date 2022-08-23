import 'package:flutter/material.dart';
import 'package:kcounter/counters/actions/list_counters.dart';
import 'package:kcounter/counters/core/counter_logger.dart';
import 'package:kcounter/counters/entities/counter_read_dto.dart';
import 'package:kcounter/theme/spacing_constants.dart';
import 'package:kcounter/widgets/counter_card.dart';
import 'package:kcounter/widgets/user_greeting.dart';
import 'package:kcounter/widgets/zero_counters.dart';

class CountersListStreamBuilder extends StreamBuilder<List<CounterWithDailyReadDto>> {
  final ListCounters action;
  final bool? showSecretCounters;

  CountersListStreamBuilder({Key? key, required this.action, this.showSecretCounters})
      : super(
          key: key,
          stream: action.run(ListCountersParams(showSecretCounters: showSecretCounters ?? false)),
          builder: (context, countersSnapshot) {
            switch (countersSnapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (countersSnapshot.hasError) {
                  CounterLogger.error(
                    "while loading counters list",
                    countersSnapshot.error,
                    countersSnapshot.stackTrace,
                  );
                  return const SizedBox.shrink();
                }

                var counters = countersSnapshot.data?.map((e) => CounterCard(counter: e)) ?? [];

                if (counters.isEmpty) {
                  return const ZeroCounters();
                }

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      CountersSpacing.space600,
                      CountersSpacing.space1200,
                      CountersSpacing.space600,
                      100,
                    ),
                    child: Wrap(
                      runSpacing: CountersSpacing.space600,
                      children: [
                        const UserGreeting(),
                        ...counters,
                      ],
                    ),
                  ),
                );
            }
          },
        );
}
