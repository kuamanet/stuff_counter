import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/authentication/entities/authentication_entities.dart';
import 'package:kcounter/riverpod_providers/riverpod_providers.dart';
import 'package:kcounter/theme/spacing_constants.dart';

class UserGreeting extends ConsumerWidget {
  const UserGreeting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Authentication> authState = ref.watch(authProvider);
    if (authState.value?.state == AuthenticationState.signedIn) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome",
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: Colors.black45,
                ),
          ),
          const SizedBox(height: CountersSpacing.smallSpace),
          Text(
            authState.value?.username ?? "",
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }
}
