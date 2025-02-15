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
  String _selectedOption = 'Option 1';

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
      backgroundColor: kColors.whiteColor,
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
                      text: 'Create order',
                      weight: FontWeight.w500,
                      size: 16,
                    ),
                  ],
                ),
                Height(h: 2),
                Align(
                  alignment: Alignment.centerLeft,
                  child: kTxt(
                    text: 'Buyer order form',
                    weight: FontWeight.w600,
                    color: kColors.textGrey,
                    size: 15,
                  ),
                ),
                Height(h: 1),
                TitleTField(
                  important: true,
                  radius: 10,
                  hint: 'Enter seller email',
                  title: 'Seller email address',
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
                Height(h: 1.5),
                TitleTField(
                  important: true,
                  radius: 10,
                  hint: 'Enter seller numer',
                  title: 'Seller phone number',
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
                Height(h: 1.5),
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
                Height(h: 1.5),
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
                    SizedBox(
                      height: 1 * size.height / 100,
                      child: Radio<String>(
                        value: 'Option 1',
                        groupValue: _selectedOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value!;
                            print('$_selectedOption $naMe $split');

                            if (_selectedOption == 'Option 1') {
                              naMe = true;
                              split = false; // Deselect this option
                            } else {
                              naMe = false; // Select this option
                              split =
                                  true; // Ensure the other option is deselected
                            }
                          });
                        },
                      ),
                    ),
                    kTxt(
                      text: 'Pay full escrow charge',
                      size: 13,
                      weight: FontWeight.w600,
                      color: kColors.textGrey.withOpacity(0.6),
                    ),
                    Width(w: 2),
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
                  ],
                ),
                Height(h: 2),
                Row(
                  children: [
                    SizedBox(
                      height: 1 * size.height / 100,
                      child: Radio<String>(
                        value: 'Option 2',
                        groupValue: _selectedOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value!;

                            if (_selectedOption == 'Option 2') {
                              split = true; // Deselect this option
                              naMe = false;
                              print('$_selectedOption $naMe $split');
                            } else {
                              print('$_selectedOption $naMe $split');

                              split = false; // Select this option
                              naMe =
                                  true; // Ensure the other option is deselected
                            }
                          });
                        },
                      ),
                    ),
                    kTxt(
                      text: 'Split escrow charge',
                      size: 13,
                      weight: FontWeight.w600,
                      color: kColors.textGrey.withOpacity(0.6),
                    ),
                    Width(w: 2),
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
                  ],
                ),
                Height(h: 2),
                Padding(
                  padding: EdgeInsets.only(left: 5 * size.width / 100),
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
                  btnText: 'Send invite link',
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
