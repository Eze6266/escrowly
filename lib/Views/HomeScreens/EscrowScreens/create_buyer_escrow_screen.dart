import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trustbridge/Utilities/Functions/add_comma_tostring_number.dart';
import 'package:trustbridge/Utilities/Functions/calculate_fee.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/custom_txtfield.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/EscrowScreens/Components/fee_description_dialog.dart';
import 'package:trustbridge/Views/HomeScreens/EscrowScreens/Components/reusables.dart';
import 'package:trustbridge/Views/SettingsScreens/Components/profile_tiles.dart';

class CreateBuyerEscrowScreen extends StatefulWidget {
  const CreateBuyerEscrowScreen({super.key});

  @override
  State<CreateBuyerEscrowScreen> createState() =>
      _CreateBuyerEscrowScreenState();
}

class _CreateBuyerEscrowScreenState extends State<CreateBuyerEscrowScreen> {
  TextEditingController amountCtrler = TextEditingController();
  bool naMe = false;
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
                  radius: 10,
                  hint: 'Enter seller name',
                  title: 'Seller Name',
                ),
                Height(h: 3),
                TitleTField(
                  radius: 10,
                  hint: 'Enter seller numer',
                  title: 'Seller Phone',
                ),
                Height(h: 3),
                TitleTField(
                  radius: 10,
                  hint: 'Enter seller email',
                  title: 'Seller Email',
                ),
                Height(h: 3),
                TitleTField(
                  radius: 10,
                  hint: 'Enter amount for product/escrow',
                  title: 'Amount',
                  controller: amountCtrler,
                  keyType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {});
                  },
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
                      naMe: naMe,
                      onTap: () {
                        setState(() {
                          naMe = !naMe;
                        });
                      },
                    ),
                  ],
                ),
                Height(h: 1.5),
                naMe
                    ? Padding(
                        padding: EdgeInsets.only(left: 1 * size.width / 100),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: kTxt(
                            weight: FontWeight.w400,
                            text:
                                'Fee: ${amountCtrler.text.isEmpty ? '0' : formatNumberWithCommas(calculateTransactionFee(amountCtrler.text))}',
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                Height(h: 10),
                GenBtn(
                  size: size,
                  width: 90,
                  height: 6,
                  btnColor: kColors.primaryColor,
                  btnText: 'Create Escrow',
                  txtColor: kColors.whiteColor,
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