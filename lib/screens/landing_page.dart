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
        child: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              const Logo(),
              const SizedBox(height: CountersSpacing.padding300),
              const AppName(),
              const SizedBox(height: CountersSpacing.padding300),
              const AppDescription(),
            ])),
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: _computeGridPadding(context),
                vertical: CountersSpacing.space900,
              ),
              sliver: SliverGrid.count(
                crossAxisCount: _computeGridColumnCount(context),
                mainAxisSpacing: CountersSpacing.space600,
                crossAxisSpacing: CountersSpacing.space600,
                children: const [
                  Snapshot(asset: "images/home.png"),
                  Snapshot(asset: "images/detail.png"),
                  Snapshot(asset: "images/add.png"),
                  Snapshot(asset: "images/settings.png"),
                ],
              ),
            ),
            const Links(),
          ],
        ),
      ),
    );
  }

  double _computeGridPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width > 1200) {
      return MediaQuery.of(context).size.width / 4;
    }
    if (width < 800) {
      return MediaQuery.of(context).size.width / 8;
    }

    return CountersSpacing.space600;
  }

  int _computeGridColumnCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 800) {
      return 2;
    }

    return 1;
  }
}

class Links extends StatelessWidget {
  const Links({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          const SizedBox(height: CountersSpacing.spaceSafe),
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
    );
  }
}

class AppDescription extends StatelessWidget {
  const AppDescription({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Count all the things that matter to you",
      textAlign: TextAlign.center,
      style: GoogleFonts.montserrat(
        textStyle: Theme.of(context).textTheme.headline4,
        color: Colors.black87,
      ),
    );
  }
}

class AppName extends StatelessWidget {
  const AppName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const fontSize = 110.0;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 150),
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NeumorphicText(
              "K".toUpperCase(),
              style: const NeumorphicStyle(
                depth: 9,
                intensity: 0.75,
                surfaceIntensity: 0,
                color: Colors.black,
              ),
              textStyle: NeumorphicTextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 5,
                  fontFamily: GoogleFonts.montserrat().fontFamily),
            ),
            NeumorphicText(
              "Counter".toUpperCase(),
              style: const NeumorphicStyle(
                depth: 9,
                intensity: 0.75,
                surfaceIntensity: 0,
                color: Colors.white,
              ),
              textStyle: NeumorphicTextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 5,
                  fontFamily: GoogleFonts.montserrat().fontFamily),
            ),
          ],
        ),
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
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
    );
  }
}

class ScreenshotsGrid extends StatelessWidget {
  final List<Widget> children;
  const ScreenshotsGrid({
    required this.children,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.8,
      child: GridView.count(
        crossAxisCount: 1,
        mainAxisSpacing: CountersSpacing.space600,
        crossAxisSpacing: CountersSpacing.space600,
        children: children,
      ),
    );
  }
}

class Snapshot extends StatelessWidget {
  final String asset;
  const Snapshot({
    required this.asset,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(CountersSpacing.space600),
      child: Image.asset(
        asset,
        alignment: Alignment.topCenter,
        fit: BoxFit.cover,
      ),
    );
  }
}
