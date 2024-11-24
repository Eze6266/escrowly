import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trustbridge/Utilities/Functions/show_toast.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/custom_txtfield.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/Components/select_bank_sheet.dart';

void showAddNewBankDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      Size size = MediaQuery.of(context).size;

      return Dialog(
        insetPadding: EdgeInsets.all(10),
        child: AddNewBankDialog(size: size),
      );
    },
  );
}

class AddNewBankDialog extends StatefulWidget {
  const AddNewBankDialog({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<AddNewBankDialog> createState() => _AddNewBankDialogState();
}

class _AddNewBankDialogState extends State<AddNewBankDialog> {
  TextEditingController accNumCtrler = TextEditingController();
  bool verifiedName = false;
  bool accNumberError = false;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: 95 * widget.size.width / 100,
      height: 47 * widget.size.height / 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: kColors.whiteColor,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => goBack(context),
                  child: CancelCircle(),
                ),
              ),
              Center(
                child: kTxt(
                  text: 'Add new bank',
                  size: 18,
                  weight: FontWeight.w600,
                ),
              ),
              Height(h: 3),
              RowDropDown(
                txtColor: kColors.blackColor,
                size: size,
                onTap: () {
                  accNumCtrler.clear();
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25.0)),
                    ),
                    builder: (BuildContext context) {
                      return SelectBankSheet();
                    },
                  );
                },
                txt: 'Please select bank',
                title: 'Select Bank',
              ),
              Height(h: 3),
              TitleTField(
                hint: 'Account number',
                title: 'Enter account number',
                isLoading: isLoading,
                elevated: true,
                controller: accNumCtrler,
                keyType: TextInputType.number,
                onChanged: (value) {
                  // if (accNumCtrler.text.length == 10) {
                  //   setState(() {
                  //     accNumberError = false;
                  //   });
                  //   if (trxnProvider.selectedBankName == '') {
                  //   } else {
                  //     setState(() {
                  //       trxnProvider
                  //           .validateAccName(
                  //         token: authProvider.token,
                  //         accNumber: accNumCtrler.text,
                  //         bankCode: trxnProvider.selectedBankCode,
                  //         context: context,
                  //       )
                  //           .then((value) {
                  //         if (value == 'true') {
                  //           setState(() {});
                  //         } else {
                  //           showCustomErrorToast(
                  //               context, trxnProvider.validateAccNameMessage);
                  //         }
                  //       });
                  //     });
                  //   }
                  // } else {
                  //   setState(() {
                  //     accNumberError = true;
                  //     trxnProvider.accName = '';
                  //   });
                  // }
                },
              ),
              accNumberError
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: kTxt(
                        text: 'Account number must be 10 digits',
                        size: 10,
                        color: kColors.red,
                        weight: FontWeight.w600,
                      ),
                    )
                  : SizedBox.shrink(),
              // Height(h: trxnProvider.accName == '' ? 1.5 : 0.2),
              // trxnProvider.validateAccNameIsLoading
              //     ? Padding(
              //         padding: EdgeInsets.only(left: 2 * size.width / 100),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             SpinKitFadingCube(
              //               color: kColors.primaryColor,
              //               size: 15,
              //             ),
              //           ],
              //         ),
              //       )
              //     : SizedBox.shrink(),
              // trxnProvider.accName == ''
              //     ? SizedBox.shrink()
              //     : Align(
              //         alignment: Alignment.centerLeft,
              //         child: SizedBox(
              //           width: 80 * size.width / 100,
              //           child: kTxt(
              //             text: '${trxnProvider.accName}',
              //             color: kColors.primaryColor,
              //             maxLine: 2,
              //             weight: FontWeight.w600,
              //             size: 10,
              //           ),
              //         ),
              //       ),
              Height(h: 4),
              GenBtn(
                size: widget.size,
                width: 70,
                borderRadius: 55,
                isLoading: isLoading,
                height: 5,
                btnColor: kColors.primaryColor,
                btnText: 'Add bank Account',
                borderColor: kColors.primaryColor,
                txtColor: kColors.whiteColor,
                txtWeight: FontWeight.w500,
                tap: () {
                  goBack(context);
                  showCustomSuccessToast(context, 'Bank added successfully!');
                  // if (accNumCtrler.text.isEmpty ||
                  //     accNumberError == true ||
                  //     trxnProvider.accName == '') {
                  // } else {
                  //   trxnProvider
                  //       .addBankAccount(
                  //     token: authProvider.token.toString(),
                  //     accNumber: accNumCtrler.text.toString(),
                  //     bankCode: trxnProvider.selectedBankCode.toString(),
                  //     bankName: trxnProvider.selectedBankName,
                  //     context: context,
                  //   )
                  //       .then((value) {
                  //     trxnProvider.fetchAllBanks(
                  //         token: authProvider.token, context: context);
                  //     if (value == 'true') {
                  //       showCustomSuccessToast(
                  //           context, 'Account added successfully!');
                  //       goBack(context);
                  //       trxnProvider.fetchAllBanks(
                  //           token: authProvider.token, context: context);
                  //       showWithdrawFundsDialog(context);
                  //     } else {
                  //       showCustomErrorToast(
                  //           context, trxnProvider.addBankAccountMessage);
                  //     }
                  //   });
                  // }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
