import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/main.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text("Create counter"),
          onPressed: () {
            final router = ref.read(routeProvider.originProvider);
            router.toCreatePage();
          },
        ),
      ),
    );
  }
}
