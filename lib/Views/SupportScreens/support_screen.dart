import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:trustbridge/Utilities/Functions/show_toast.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/SupportScreens/chat_with_bot_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  void _launchMailApp() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path:
          'escrowly.services@gmail.com', // You can add a default email address here, e.g., 'example@example.com'
      query: Uri.encodeQueryComponent(
          'Escrowly Support'), // You can add subject or body if needed.
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      print("Could not launch email app.");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kColors.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 0.001,
        backgroundColor: kColors.primaryColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4 * size.width / 100),
          child: Column(
            children: [
              Height(h: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BckBtn(),
                  Width(w: 32),
                  kTxt(
                    color: kColors.blackColor,
                    size: 14.0,
                    text: 'Support',
                    weight: FontWeight.w500,
                  ),
                ],
              ),
              Height(h: 3),
              GestureDetector(
                onTap: () async {
                  FlutterPhoneDirectCaller.callNumber('07067581951');
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 3 * size.width / 100,
                    vertical: 2 * size.height / 100,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    border:
                        Border.all(color: kColors.whitishGrey.withOpacity(0.5)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          kTxt(
                            text: 'Call Our Support Agent',
                            size: 12,
                            weight: FontWeight.w500,
                          ),
                          Icon(
                            Icons.call,
                            color: kColors.primaryColor,
                          ),
                        ],
                      ),
                      Height(h: 1),
                      PhoneNumberTxtThing(number: '07067581951'),
                      PhoneNumberTxtThing(number: '09039363409'),
                    ],
                  ),
                ),
              ),
              Height(h: 5),
              GestureDetector(
                onTap: () {
                  _launchMailApp();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 3 * size.width / 100,
                    vertical: 2 * size.height / 100,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.white,
                    border:
                        Border.all(color: kColors.whitishGrey.withOpacity(0.5)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kTxt(
                            text: 'Send us a mail',
                            size: 13,
                            weight: FontWeight.w600,
                          ),
                          Height(h: 0.2),
                          kTxt(
                            text: 'escrowly.services@gmail.com',
                            size: 11,
                            weight: FontWeight.w500,
                          ),
                        ],
                      ),
                      Image.asset(
                        kImages.escrowsupport,
                        height: 2.5 * size.height / 100,
                      ),
                    ],
                  ),
                ),
              ),
              Height(h: 1.5),
              GestureDetector(
                onTap: () {
                  // goTo(context, ChatWithAgentScreen());
                  Toaster().showToast('Coming soon!');
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 3 * size.width / 100,
                    vertical: 2 * size.height / 100,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    border:
                        Border.all(color: kColors.whitishGrey.withOpacity(0.5)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      kTxt(
                        text: 'Start a new chat',
                        size: 13,
                        weight: FontWeight.w700,
                        color: Color.fromARGB(255, 5, 48, 82),
                      ),
                      Image.asset(
                        kImages.escrowchat,
                        height: 2.5 * size.height / 100,
                      ),
                    ],
                  ),
                ),
              ),
              Height(h: 1.5),
              // GestureDetector(
              //   onTap: () {
              //     goTo(context, ChatWithBotScreen());
              //   },
              //   child: Container(
              //     padding: EdgeInsets.symmetric(
              //       horizontal: 3 * size.width / 100,
              //       vertical: 2 * size.height / 100,
              //     ),
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(12),
              //       color: Colors.white,
              //       border:
              //           Border.all(color: kColors.whitishGrey.withOpacity(0.5)),
              //     ),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         kTxt(
              //           text: 'Chat with Escrowly-Bot',
              //           size: 13,
              //           weight: FontWeight.w700,
              //           color: Color.fromARGB(255, 5, 48, 82),
              //         ),
              //         CircleAvatar(
              //           radius: 12,
              //           backgroundImage: AssetImage(kImages.appicon),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class PhoneNumberTxtThing extends StatelessWidget {
  PhoneNumberTxtThing({
    super.key,
    required this.number,
  });
  String number;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.phone,
          color: Colors.blue,
          size: 14,
        ),
        Width(w: 1),
        kTxt(
          text: '$number',
          size: 11,
          weight: FontWeight.w500,
        ),
      ],
    );
  }
}
