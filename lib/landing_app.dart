import 'package:flutter/material.dart';
import 'package:kcounter/navigation/web_route.dart';
import 'package:kcounter/screens/landing_page.dart';
import 'package:kcounter/screens/privacy_page.dart';
import 'package:kcounter/screens/terms_and_conditions_page.dart';
import 'package:url_strategy/url_strategy.dart';

class LandingApp extends StatelessWidget {
  const LandingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "KCounter",
      debugShowCheckedModeBanner: false,
      initialRoute: landingPath,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Colors.black,
          inversePrimary: Colors.black,
        ),
      ),
      routes: {
        landingPath: (context) => const LandingPage(),
        privacyPath: (_) => const PrivacyPage(),
        termsAndConditionsPath: (_) => const TermsAndConditionsPage(),
      },
    );
  }
}

void launchLandingApp() {
  setPathUrlStrategy();
  runApp(const LandingApp());
}
