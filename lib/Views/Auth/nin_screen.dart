import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trustbridge/Controllers/Providers/AuthProviders/auth_provider.dart';
import 'package:trustbridge/Utilities/Functions/show_toast.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/custom_txtfield.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/Auth/verify_otp_screen.dart';

class NinScreen extends StatefulWidget {
  NinScreen({
    super.key,
    required this.email,
    required this.number,
    required this.password,
    required this.firstName,
    required this.lastName,
    this.referCode,
  });
  String email, number, password, firstName, lastName;
  String? referCode;

  @override
  State<NinScreen> createState() => _NinScreenState();
}

class _NinScreenState extends State<NinScreen> {
  TextEditingController ninCtrler = TextEditingController();
  bool ninError = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var authProvider = Provider.of<AuthProvider>(context);
    isLoading = (Provider.of<AuthProvider>(context).senOtpIsLoading ||
        Provider.of<AuthProvider>(context).verifyNinisLoading ||
        Provider.of<AuthProvider>(context).getTokenisLoading);

    return Scaffold(
      backgroundColor: kColors.whiteColor,
      appBar: AppBar(
        toolbarHeight: 0.001,
        backgroundColor: kColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4 * size.width / 100),
          child: Column(
            children: [
              Height(h: 2),
              isLoading
                  ? SizedBox.shrink()
                  : Align(
                      alignment: Alignment.centerLeft,
                      child: BckBtn(),
                    ),
              Center(
                child: kTxt(
                  text: 'Identity Verification',
                  size: 19,
                  weight: FontWeight.w700,
                ),
              ),
              Height(h: 2),
              Center(
                child: SizedBox(
                  width: 80 * size.width / 100,
                  child: kTxt(
                    color: kColors.textGrey,
                    text:
                        'To complete your account setup and confirm it\'s really you, we need to verify your NIN',
                    size: 13,
                    weight: FontWeight.w500,
                    textalign: TextAlign.center,
                    maxLine: 7,
                  ),
                ),
              ),
              Height(h: 5),
              TitleTField(
                radius: 10,
                width: 93 * size.width / 100,
                elevated: false,
                title: 'Input your National Identification Number (NIN)',
                hint: 'Enter your nin',
                controller: ninCtrler,
                isLoading: isLoading,
                keyType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    if (ninCtrler.text.length < 11) {
                      ninError = true;
                    } else {
                      ninError = false;
                    }
                  });
                },
              ),
              ninError
                  ? Padding(
                      padding: EdgeInsets.only(left: 2 * size.width / 100),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: kTxt(
                          text: 'Enter a valid nin',
                          color: kColors.red,
                          size: 12,
                          weight: FontWeight.w600,
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
              Height(h: 3),
              NinverificationBox(),
              Height(h: 8),
              GenBtn(
                borderRadius: 13,
                size: size,
                width: 85,
                height: 6,
                isLoading: isLoading,
                btnColor: kColors.primaryColor,
                btnText: 'Verify',
                txtColor: kColors.whiteColor,
                tap: () {
                  if (ninError == true || ninCtrler.text.isEmpty) {
                    showCustomErrorToast(context, 'Enter a valid NIN');
                  } else {
                    authProvider.generateToken().then((value) {
                      if (value == 'true') {
                        authProvider
                            .verifyNIN(ninCtrler.text, authProvider.getToken)
                            .then(
                          (value) {
                            if (value == 'success') {
                              authProvider
                                  .senOtp(
                                email: widget.email,
                                password: widget.password,
                                referCode: widget.referCode ?? '',
                                context: context,
                              )
                                  .then((value) {
                                if (value == 'success') {
                                  goTo(
                                      context,
                                      VerifyOtpScreen(
                                        email: widget.email,
                                        firstName: widget.firstName,
                                        lastName: widget.lastName,
                                        nin: ninCtrler.text,
                                        number: ninCtrler.text,
                                        password: widget.password,
                                      ));
                                } else {
                                  showCustomErrorToast(
                                      context, authProvider.senOtpMessage);
                                }
                              });
                            } else {
                              showCustomErrorToast(
                                  context, authProvider.verifyNinMessage);
                            }
                          },
                        );
                      } else {
                        showCustomErrorToast(
                            context, authProvider.getTokenMessage);
                      }
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NinverificationBox extends StatelessWidget {
  const NinverificationBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 4 * size.width / 100,
        vertical: 1.5 * size.height / 100,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kColors.primaryColor.withOpacity(0.15),
      ),
      child: Row(
        children: [
          Image.asset(
            kImages.shield,
            height: 3 * size.height / 100,
          ),
          Width(w: 4),
          SizedBox(
            width: 70 * size.width / 100,
            child: kTxt(
              maxLine: 5,
              text:
                  'NIN verification is required to confirm your identity and complete your account setup. Your NIN will only be used for verification purposes to keep your account secure',
              size: 11,
              color: kColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }
}
