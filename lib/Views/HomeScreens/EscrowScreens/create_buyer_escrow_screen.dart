import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trustbridge/Utilities/Functions/add_comma_tostring_number.dart';
import 'package:trustbridge/Utilities/Functions/calculate_fee.dart';
import 'package:trustbridge/Utilities/Functions/check_email_function.dart';
import 'package:trustbridge/Utilities/Functions/format_date_function.dart';
import 'package:trustbridge/Utilities/Functions/show_toast.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/custom_txtfield.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/EscrowScreens/Components/fee_description_dialog.dart';
import 'package:trustbridge/Views/HomeScreens/EscrowScreens/Components/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/EscrowScreens/full_buying_info_screen.dart';
import 'package:trustbridge/Views/SettingsScreens/Components/profile_tiles.dart';

class CreateBuyerEscrowScreen extends StatefulWidget {
  const CreateBuyerEscrowScreen({super.key});

  @override
  State<CreateBuyerEscrowScreen> createState() =>
      _CreateBuyerEscrowScreenState();
}

class _CreateBuyerEscrowScreenState extends State<CreateBuyerEscrowScreen> {
  TextEditingController amountCtrler = TextEditingController();
  TextEditingController descCtrler = TextEditingController();
  TextEditingController emailCtrler = TextEditingController();
  TextEditingController phoneCtrler = TextEditingController();
  bool emailError = false;
  bool phoneError = false;
  bool amountError = false;

  bool naMe = false;
  bool split = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    amountCtrler.text = '0';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kColors.whitishGrey,
      appBar: AppBar(
        backgroundColor: kColors.primaryColor,
        toolbarHeight: 0.001,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5 * size.width / 100),
            child: Column(
              children: [
                Height(h: 2.5),
                Row(
                  children: [
                    BckBtn(),
                    Width(w: 22),
                    kTxt(
                      text: 'Create escrow',
                      weight: FontWeight.w500,
                      size: 16,
                    ),
                  ],
                ),
                Height(h: 5),
                Center(
                  child: Shimmer.fromColors(
                    period: Duration(seconds: 8),
                    baseColor: kColors.red,
                    highlightColor: kColors.starYellow,
                    child: Text(
                      'BUYER',
                      style: GoogleFonts.acme(
                        textStyle: TextStyle(
                          color: kColors.whiteColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Height(h: 1),
                TitleTField(
                  important: true,
                  radius: 10,
                  hint: 'Enter seller email',
                  title: 'Seller Email',
                  controller: emailCtrler,
                  onChanged: (value) {
                    setState(() {
                      if (isValidEmail(emailCtrler.text)) {
                        emailError = false;
                      } else {
                        emailError = true;
                      }
                    });
                  },
                ),
                emailError
                    ? Padding(
                        padding: EdgeInsets.only(left: 2 * size.width / 100),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: kTxt(
                            text: 'Enter a valid email',
                            color: kColors.red,
                            size: 12,
                            weight: FontWeight.w600,
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                Height(h: 3),
                TitleTField(
                  important: true,
                  radius: 10,
                  hint: 'Enter seller numer',
                  title: 'Seller Phone',
                  controller: phoneCtrler,
                  keyType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      if (phoneCtrler.text.length < 10) {
                        phoneError = true;
                      } else {
                        phoneError = false;
                      }
                    });
                  },
                ),
                phoneError
                    ? Padding(
                        padding: EdgeInsets.only(left: 2 * size.width / 100),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: kTxt(
                            text: 'Enter a valid phone number',
                            color: kColors.red,
                            size: 12,
                            weight: FontWeight.w600,
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                Height(h: 3),
                TitleTField(
                  important: true,
                  radius: 10,
                  hint: 'Enter amount for product/escrow',
                  title: 'Amount',
                  controller: amountCtrler,
                  keyType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      if (int.parse(amountCtrler.text) < 1000) {
                        amountError = true;
                      } else {
                        amountError = false;
                      }
                    });
                  },
                ),
                amountError
                    ? Padding(
                        padding: EdgeInsets.only(left: 2 * size.width / 100),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: kTxt(
                            text: 'Amount can\'t be less than N1000',
                            color: kColors.red,
                            size: 12,
                            weight: FontWeight.w600,
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                Height(h: 3),
                TitleTField(
                  radius: 8,
                  hint: 'Enter description for order',
                  title: 'Description',
                  controller: descCtrler,
                  keyType: TextInputType.text,
                  onChanged: (value) {
                    setState(() {});
                  },
                  maxLine: 5,
                ),
                Height(h: 3),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showFeeDescriptionDialog(context, '1');
                      },
                      child: Icon(
                        Icons.info,
                        size: 12,
                        color: kColors.orange,
                      ),
                    ),
                    Width(w: 2),
                    WhoGoPayFee(
                      txt: 'I am paying the transaction fee',
                      naMe: naMe,
                      onTap: () {
                        setState(() {
                          if (naMe) {
                            naMe = false; // Deselect this option
                          } else {
                            naMe = true; // Select this option
                            split =
                                false; // Ensure the other option is deselected
                          }
                        });
                      },
                    ),
                  ],
                ),
                Height(h: 1.5),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showFeeDescriptionDialog(context, '2');
                      },
                      child: Icon(
                        Icons.info,
                        size: 12,
                        color: kColors.orange,
                      ),
                    ),
                    Width(w: 2),
                    WhoGoPayFee(
                      txt: 'Split it',
                      naMe: split,
                      onTap: () {
                        setState(() {
                          if (split) {
                            split = false; // Deselect this option
                          } else {
                            split = true; // Select this option
                            naMe =
                                false; // Ensure the other option is deselected
                          }
                        });
                      },
                    ),
                  ],
                ),
                Height(h: 1.5),
                Padding(
                  padding: EdgeInsets.only(left: 1 * size.width / 100),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: kTxt(
                      weight: FontWeight.w400,
                      text: split
                          ? 'Fee: ${amountCtrler.text.isEmpty ? '0' : formatNumberWithCommas(splitAmount(calculateTransactionFee(amountCtrler.text)))}'
                          : 'Fee: ${amountCtrler.text.isEmpty ? '0' : formatNumberWithCommas(calculateTransactionFee(amountCtrler.text))}',
                    ),
                  ),
                ),
                Height(h: 10),
                GenBtn(
                  size: size,
                  width: 90,
                  height: 6,
                  btnColor: kColors.primaryColor,
                  btnText: 'Create Escrow',
                  txtColor: kColors.whiteColor,
                  tap: () {
                    if (emailCtrler.text.isEmpty ||
                        phoneCtrler.text.isEmpty ||
                        amountCtrler.text.isEmpty ||
                        emailError == true ||
                        phoneError == true ||
                        amountError == true) {
                      showCustomErrorToast(
                          context, 'Make sure all fields are filled properly');
                    } else {
                      goTo(
                        context,
                        FullBuyingDetailScreen(
                          amount: amountCtrler.text,
                          fee: naMe
                              ? formatNumberWithCommas(
                                  calculateTransactionFee(amountCtrler.text))
                              : split
                                  ? formatNumberWithCommas(splitAmount(
                                      calculateTransactionFee(
                                          amountCtrler.text)))
                                  : formatNumberWithCommas(splitAmount(
                                      calculateTransactionFee(
                                          amountCtrler.text))),
                          dateTime: formatDateTime(DateTime.now().toString()),
                          sellerEmail: emailCtrler.text,
                          sellerPhone: phoneCtrler.text,
                          description:
                              descCtrler.text.isEmpty ? 'Non' : descCtrler.text,
                          whoPays: naMe
                              ? 'Me'
                              : split
                                  ? 'Split'
                                  : 'Seller',
                        ),
                      );
                    }
                  },
                ),
                Height(h: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
