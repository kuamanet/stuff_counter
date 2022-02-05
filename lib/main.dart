import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/riverpod_providers.dart';
import 'package:kcounter/screens/create_counter_page.dart';
import 'package:kcounter/screens/dashboard_page.dart';
import 'package:kcounter/theme/neumorphic_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(
    child: CountersApp(),
  ));
}

class CountersApp extends ConsumerWidget {
  const CountersApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRoute = ref.watch(routeProvider);
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      title: 'Counters',
      themeMode: ThemeMode.light,
      theme: const NeumorphicThemeData(
        baseColor: Colors.white,
        lightSource: LightSource.topLeft,
        depth: NeumorphicConstants.neumorphicDepth,
        accentColor: Colors.white,
      ),
      home: Navigator(
        pages: [
          const MaterialPage(child: DashboardPage()),
          if (currentRoute == AppRoute.create) const MaterialPage(child: CreateCounterPage())
        ],
        onPopPage: (route, result) {
          // this runs each time the user hits the back button
          // we need to sync our route state here.
          // since we have a simple 1 depth structure (home -> subpage)
          // if user is going back, he can only go to the dashboard
          ref.read(routeProvider.notifier).toDashboardPage();
          return route.didPop(result);
        },
      ),
    );
  }
}
