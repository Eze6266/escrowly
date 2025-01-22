import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trustbridge/Controllers/Providers/AuthProviders/auth_provider.dart';
import 'package:trustbridge/Controllers/Providers/TransactionProviders/transaction_provider.dart';
import 'package:trustbridge/Utilities/Functions/show_toast.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/custom_txtfield.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/Components/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/Components/select_bank_sheet.dart';
import 'package:trustbridge/Views/HomeScreens/Components/show_add_new_bank_dialog.dart';
import 'package:trustbridge/Views/HomeScreens/Components/withdraw_processing.dart';

void showWithdrawFundsDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      Size size = MediaQuery.of(context).size;

      return Dialog(
        insetPadding: EdgeInsets.all(10),
        child: WithdrawFundsDialog(size: size),
      );
    },
  );
}

class WithdrawFundsDialog extends StatefulWidget {
  const WithdrawFundsDialog({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<WithdrawFundsDialog> createState() => _WithdrawFundsDialogState();
}

class _WithdrawFundsDialogState extends State<WithdrawFundsDialog> {
  List bankList = [];
  TextEditingController amountCtrler = TextEditingController();

  int selectedAccount = 0;
  var selectedBankAccountId = '';
  bool isLoading = false;
  bool isLessThan100 = false;
  TextEditingController accNumCtrler = TextEditingController();
  bool verifiedName = false;
  bool accNumberError = false;

  void _validateInput() {
    final enteredValue = double.tryParse(amountCtrler.text);

    if (enteredValue != null && enteredValue >= 1000) {
      setState(() {
        isLessThan100 = false;
      });
    } else {
      setState(() {
        isLessThan100 = true;
      });
    }
  }

  final confetticontroller = ConfettiController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var trxnProvider = Provider.of<TransactionProvider>(context);
    var authProvider = Provider.of<AuthProvider>(context);
    return Container(
      width: 95 * widget.size.width / 100,
      height: 60 * widget.size.height / 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: kColors.whiteColor,
      ),
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
                text: 'Withdraw Funds',
                size: 18,
                weight: FontWeight.w600,
              ),
            ),
            Height(h: 3),
            TitleTField(
              hint: 'Enter amount',
              title: 'Enter amount',
              elevated: true,
              isLoading: isLoading,
              controller: amountCtrler,
              onChanged: (value) {
                setState(() {
                  _validateInput();
                });
              },
            ),
            isLessThan100
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: kTxt(
                      text: 'Minimum withdrawal amount is N1,000',
                      size: 10,
                      color: kColors.red,
                      weight: FontWeight.w600,
                    ),
                  )
                : SizedBox.shrink(),
            Height(h: 2.5),
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
              txt: trxnProvider.selectedBank == ''
                  ? 'Please select bank'
                  : trxnProvider.selectedBank,
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
                if (accNumCtrler.text.length == 10) {
                  setState(() {
                    accNumberError = false;
                  });
                  if (trxnProvider.selectedBank == '') {
                  } else {
                    setState(() {
                      trxnProvider
                          .validateAccName(
                        accNumber: accNumCtrler.text,
                        bankCode: trxnProvider.selectedCode,
                        context: context,
                      )
                          .then((value) {
                        if (value == 'success') {
                          setState(() {});
                        } else {
                          showCustomErrorToast(
                              context, trxnProvider.validateAccNameMessage);
                        }
                      });
                    });
                  }
                } else {
                  setState(() {
                    accNumberError = true;
                    trxnProvider.accName = '';
                  });
                }
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
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: kTxt(
            //     text: 'Select account',
            //     color: kColors.textGrey,
            //     size: 13,
            //     weight: FontWeight.w500,
            //   ),
            // ),
            // Height(h: 2),
            // bankList.isEmpty
            //     ? Padding(
            //         padding: EdgeInsets.only(bottom: 2 * size.height / 100),
            //         child: kTxt(
            //           size: 14,
            //           weight: FontWeight.w500,
            //           text: 'You Have No Saved Accounts',
            //         ),
            //       )
            //     : Expanded(
            //         child: ListView.builder(
            //           itemCount: bankList.length,
            //           itemBuilder: (context, index) {
            //             return Padding(
            //               padding:
            //                   EdgeInsets.only(bottom: 1 * size.height / 100),
            //               child: SelectBankAccountTile(
            //                 name: 'Emmanuel Eze',
            //                 accNumber: '7067581951',
            //                 value: index,
            //                 groupValue: selectedAccount,
            //                 onChanged: (int? newValue) {
            //                   setState(() {
            //                     // selectedBankAccountId = trxnProvider
            //                     //     .savedAccountList[index]['id']
            //                     //     .toString();
            //                     // selectedAccount = newValue!;
            //                   });
            //                 },
            //               ),
            //             );
            //           },
            //         ),
            //       ),
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: AddFundsWithdrawBtn(
            //     txt: 'Add new bank account',
            //     width: 45 * size.width / 100,
            //     contentColor: kColors.primaryColor,
            //     radius: 25,
            //     txtSize: 11,
            //     height: 4 * size.height / 100,
            //     img: kImages.addicon,
            //     onTap: () {
            //       showAddNewBankDialog(context);
            //     },
            //   ),
            // ),

            Height(h: trxnProvider.accName == '' ? 1.5 : 0.2),
            trxnProvider.validateAccNameIsLoading
                ? Padding(
                    padding: EdgeInsets.only(left: 2 * size.width / 100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SpinKitFadingCube(
                          color: kColors.primaryColor,
                          size: 15,
                        ),
                      ],
                    ),
                  )
                : SizedBox.shrink(),
            trxnProvider.accName == ''
                ? SizedBox.shrink()
                : Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 80 * size.width / 100,
                      child: kTxt(
                        text: '${trxnProvider.accName}',
                        color: kColors.primaryColor,
                        maxLine: 2,
                        weight: FontWeight.w600,
                        size: 10,
                      ),
                    ),
                  ),
            Height(h: 4),
            GenBtn(
              size: widget.size,
              width: 70,
              isLoading: isLoading,
              borderRadius: 55,
              height: 5,
              btnColor: kColors.primaryColor,
              btnText: 'Proceed',
              borderColor: kColors.primaryColor,
              txtColor: kColors.whiteColor,
              txtWeight: FontWeight.w500,
              tap: () {
                if (trxnProvider.accName == '') {
                  showCustomErrorToast(context, 'Unverified account');
                } else {
                  goBack(context);
                  showWithdrawProcessingDialog(context, confetticontroller);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SelectBankAccountTile extends StatelessWidget {
  final String name;
  final String accNumber;
  final int value;
  final int groupValue;
  final ValueChanged<int?> onChanged;

  SelectBankAccountTile({
    super.key,
    required this.name,
    required this.accNumber,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            SizedBox(
              width: 56 * size.width / 100,
              child: kTxt(
                text: name,
                weight: FontWeight.w500,
                size: 12,
                maxLine: 1,
              ),
            ),
            Width(w: 2),
            kTxt(
              text: accNumber,
              weight: FontWeight.w400,
              size: 12,
              color: kColors.textGrey,
            ),
          ],
        ),
        SizedBox(
          height: 1 * size.height / 100,
          child: Radio<int>(
            value: value,
            groupValue: groupValue,
            activeColor: kColors.primaryColor,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
