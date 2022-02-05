import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/navigation/navigator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(
    child: CountersApp(),
  ));
}

class CountersApp extends StatelessWidget {
  const CountersApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Counters',
      themeMode: ThemeMode.light,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(primary: Colors.black),
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      ),
      home: const AppNavigator(),
    );
  }
}
