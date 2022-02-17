import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kcounter/theme/spacing_constants.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  Icons.home,
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
                padding: const EdgeInsets.only(
                  left: CountersSpacing.space900,
                  right: CountersSpacing.padding900,
                  bottom: CountersSpacing.padding900,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Kuama built the KCounter app as a Free app. This SERVICE is provided by Kuama at no cost and is intended for use as is.",
                    ),
                    const SizedBox(
                      height: CountersSpacing.space100,
                    ),
                    const Text(
                      "This page is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service.",
                    ),
                    const SizedBox(
                      height: CountersSpacing.space100,
                    ),
                    const Text(
                      "If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.",
                    ),
                    const SizedBox(
                      height: CountersSpacing.space100,
                    ),
                    const Text(
                      "The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at KCounter unless otherwise defined in this Privacy Policy.",
                    ),
                    const SizedBox(
                      height: CountersSpacing.space600,
                    ),
                    const Text(
                      "Information Collection and Use",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: CountersSpacing.space100,
                    ),
                    const Text(
                      "For a better experience, while using our Service, we may require you to provide us with certain personally identifiable information. The information that we request will be retained by us and used as described in this privacy policy.",
                    ),
                    const SizedBox(
                      height: CountersSpacing.space100,
                    ),
                    const Text(
                      "The app does use third-party services that may collect information used to identify you.",
                    ),
                    const SizedBox(
                      height: CountersSpacing.space100,
                    ),
                    const Text(
                      "Link to the privacy policy of third-party service providers used by the app",
                    ),
                    const SizedBox(
                      height: CountersSpacing.space100,
                    ),
                    TextButton(
                      onPressed: () {
                        launch("https://www.google.com/policies/privacy/");
                      },
                      child: const Text(
                        "\u2022 Google Play Services",
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        launch("https://firebase.google.com/policies/analytics");
                      },
                      child: const Text(
                        "\u2022 Google Analytics for Firebase",
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        launch("https://firebase.google.com/support/privacy/");
                      },
                      child: const Text(
                        "\u2022 Firebase Crashlytics",
                      ),
                    ),
                    const SizedBox(
                      height: CountersSpacing.space600,
                    ),
                    const Text(
                      "Log Data",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: CountersSpacing.space100,
                    ),
                    const Text(
                      "We want to inform you that whenever you use our Service, in a case of an error in the app we collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing our Service, the time and date of your use of the Service, and other statistics.",
                    ),
                    const SizedBox(
                      height: CountersSpacing.space600,
                    ),
                    const Text(
                      "Cookies",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: CountersSpacing.space100,
                    ),
                    const Text(
                      "Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory.",
                    ),
                    const SizedBox(
                      height: CountersSpacing.space100,
                    ),
                    const Text(
                      "This Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.",
                    ),
                    const SizedBox(
                      height: CountersSpacing.space600,
                    ),
                    const Text(
                      "Service Providers",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: CountersSpacing.space100,
                    ),
                    const Text(
                      "We may employ third-party companies and individuals due to the following reasons:",
                    ),
                    const SizedBox(
                      height: CountersSpacing.space100,
                    ),
                    const Text(
                      "\u2022 To facilitate our Service;",
                    ),
                    const Text(
                      "\u2022 To provide the Service on our behalf;",
                    ),
                    const Text(
                      "\u2022 To perform Service-related services; ",
                    ),
                    const Text(
                      "\u2022 To assist us in analyzing how our Service is used.",
                    ),
                    const SizedBox(
                      height: CountersSpacing.space100,
                    ),
                    const Text(
                      "We want to inform users of this Service that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.",
                    ),
                    const SizedBox(
                      height: CountersSpacing.space600,
                    ),
                    const Text(
                      "Security",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: CountersSpacing.space100,
                    ),
                    const Text(
                      "We value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security.",
                    ),
                    const SizedBox(
                      height: CountersSpacing.space600,
                    ),
                    const Text(
                      "Links to Other Sites",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: CountersSpacing.space100,
                    ),
                    const Text(
                      "This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by us. Therefore, we strongly advise you to review the Privacy Policy of these websites. We have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.",
                    ),
                    const SizedBox(
                      height: CountersSpacing.space600,
                    ),
                    const Text(
                      "Children’s Privacy",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: CountersSpacing.space100,
                    ),
                    const Text(
                      "These Services do not address anyone under the age of 13. We do not knowingly collect personally identifiable information from children under 13 years of age. In the case we discover that a child under 13 has provided us with personal information, we immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact us so that we will be able to do the necessary actions.",
                    ),
                    const SizedBox(
                      height: CountersSpacing.space600,
                    ),
                    const Text(
                      "Changes to This Privacy Policy",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: CountersSpacing.space100,
                    ),
                    const Text(
                      "We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page.",
                    ),
                    const SizedBox(
                      height: CountersSpacing.space100,
                    ),
                    const Text(
                      "This policy is effective as of 2022-02-08",
                    ),
                    const SizedBox(
                      height: CountersSpacing.space600,
                    ),
                    const Text(
                      "Contact Us",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: CountersSpacing.space100,
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Text(
                          "If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us at ",
                        ),
                        TextButton(
                          onPressed: () {
                            launch("mailto:info@kuama.net");
                          },
                          child: const Text(
                            "info@kuama.net",
                          ),
                        ),
                      ],
                    )
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
