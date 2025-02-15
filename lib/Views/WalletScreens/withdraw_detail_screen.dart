import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/Components/reusables.dart';
import 'package:trustbridge/Views/WalletScreens/reusables.dart';
import 'package:trustbridge/Views/WalletScreens/witdraw_faq_screen.dart';

class WithdrawDetailScreen extends StatefulWidget {
  WithdrawDetailScreen({
    super.key,
    required this.amount,
    required this.statusColor,
    required this.statusTxt,
    required this.accNum,
    required this.accname,
    required this.bankName,
    required this.dateTime,
    required this.withdrawId,
    required this.description,
  });
  String amount,
      statusTxt,
      accname,
      accNum,
      bankName,
      dateTime,
      withdrawId,
      description;
  Color statusColor;

  @override
  State<WithdrawDetailScreen> createState() => _WithdrawDetailScreenState();
}

class _WithdrawDetailScreenState extends State<WithdrawDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColors.whiteColor,
        toolbarHeight: 0.001,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
        child: Column(
          children: [
            Height(h: 1.5),
            Row(
              children: [
                BckBtn(),
                Width(w: 18),
                kTxt(
                  text: 'Transaction details',
                  size: 16,
                  weight: FontWeight.w500,
                ),
              ],
            ),
            Height(h: 2.5),
            TransactionDetailBox(
              title: 'Payout withdrawal',
              statusColor: widget.statusColor,
              statusTxt: widget.statusTxt,
              amount: widget.amount,
            ),
            Height(h: 2),
            Align(
              alignment: Alignment.centerLeft,
              child: kTxt(
                text: '  Transaction details',
                color: kColors.blackColor,
                size: 13,
              ),
            ),
            Height(h: 2),
            RowTxtWitUnderline(lTxt: 'Amount', rtxt: 'N${widget.amount}'),
            Height(h: 1.5),
            RowTxtWitUnderline(lTxt: 'Bank name', rtxt: '${widget.bankName}'),
            Height(h: 1.5),
            RowTxtWitUnderline(lTxt: 'Account name', rtxt: '${widget.accname}'),
            Height(h: 1.5),
            RowTxtWitUnderline(
                lTxt: 'Account number', rtxt: '${widget.accNum}'),
            Height(h: 1.5),
            RowTxtWitUnderline(lTxt: 'Date', rtxt: '${widget.dateTime}'),
            Height(h: 1.5),
            RowTxtWitUnderline(
                lTxt: 'Transaction ID', rtxt: '${widget.withdrawId}'),
            Height(h: 2),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  goTo(context, WithdrawFaqScreen());
                },
                child: kTxt(
                  text: 'FAQ   ',
                  color: kColors.orange,
                  size: 14,
                  weight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
