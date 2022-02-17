import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kcounter/navigation/web_route.dart';
import 'package:kcounter/theme/spacing_constants.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(1, 216, 216, 216),
      body: Padding(
        padding: const EdgeInsets.all(CountersSpacing.padding600),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            Neumorphic(
              style: const NeumorphicStyle(
                depth: 8,
                color: Color.fromARGB(1, 216, 216, 216),
                boxShape: NeumorphicBoxShape.circle(),
              ),
              child: Padding(
                padding: const EdgeInsets.all(CountersSpacing.padding600),
                child: Image.asset(
                  "icon/icon.png",
                  height: CountersSpacing.space600,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            const SizedBox(height: CountersSpacing.padding300),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
              child: FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NeumorphicText(
                      "K".toUpperCase(),
                      style: const NeumorphicStyle(
                        depth: 9, //customize depth here
                        intensity: 0.75,
                        surfaceIntensity: 0,
                        color: Colors.black, //customize color here
                      ),
                      textStyle: NeumorphicTextStyle(
                          fontSize: 130, //customize size here
                          fontWeight: FontWeight.w900,
                          letterSpacing: 5,
                          fontFamily: GoogleFonts.montserrat().fontFamily),
                    ),
                    NeumorphicText(
                      "Counter".toUpperCase(),
                      style: const NeumorphicStyle(
                        depth: 9, //customize depth here
                        intensity: 0.75,
                        surfaceIntensity: 0,
                        color: Colors.white, //customize color here
                      ),
                      textStyle: NeumorphicTextStyle(
                          fontSize: 130, //customize size here
                          fontWeight: FontWeight.w900,
                          letterSpacing: 5,
                          fontFamily: GoogleFonts.montserrat().fontFamily),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: CountersSpacing.padding300),
            Text(
              "Count all the things that matter to you",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                textStyle: Theme.of(context).textTheme.headline4,
                color: Colors.black87,
              ),
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, privacyPath);
                  },
                  child: Text(
                    "Privacy Policy",
                    style: GoogleFonts.montserrat(
                      textStyle: Theme.of(context).textTheme.caption,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: CountersSpacing.padding300),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, termsAndConditionsPath);
                  },
                  child: Text(
                    "Terms and conditions",
                    style: GoogleFonts.montserrat(
                      textStyle: Theme.of(context).textTheme.caption,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
