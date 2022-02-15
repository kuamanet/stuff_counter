import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kcounter/theme/spacing_constants.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: CountersSpacing.space900,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NeumorphicButton(
                onPressed: () => Navigator.of(context).pop(),
                style: const NeumorphicStyle(
                  depth: 4,
                  color: Colors.white,
                  boxShape: NeumorphicBoxShape.circle(),
                ),
                child: NeumorphicIcon(
                  Icons.arrow_back,
                  style: const NeumorphicStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                width: CountersSpacing.space100,
              ),
              Text(
                "Privacy Policy",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  textStyle: Theme.of(context).textTheme.headline4,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: CountersSpacing.space600,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(CountersSpacing.space900),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Kuama built the Kcounetr app as a Free app. This SERVICE is provided by Kuama at no cost and is intended for use as is.",
                    ),
                    SizedBox(
                      height: CountersSpacing.space100,
                    ),
                    Text(
                      "This page is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service.",
                    ),
                    SizedBox(
                      height: CountersSpacing.space100,
                    ),
                    Text(
                      "If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.",
                    ),
                    SizedBox(
                      height: CountersSpacing.space100,
                    ),
                    Text(
                      "The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at Kcounetr unless otherwise defined in this Privacy Policy.",
                    ),
                    SizedBox(
                      height: CountersSpacing.space600,
                    ),
                    Text(
                      "Information Collection and Use",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: CountersSpacing.space100,
                    ),
                    Text(
                      "For a better experience, while using our Service, we may require you to provide us with certain personally identifiable information. The information that we request will be retained by us and used as described in this privacy policy.",
                    ),
                    SizedBox(
                      height: CountersSpacing.space100,
                    ),
                    Text(
                      "The app does use third-party services that may collect information used to identify you.",
                    ),
                    SizedBox(
                      height: CountersSpacing.space100,
                    ),
                    Text(
                      "Link to the privacy policy of third-party service providers used by the app",
                    ),
                    SizedBox(
                      height: CountersSpacing.space100,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
