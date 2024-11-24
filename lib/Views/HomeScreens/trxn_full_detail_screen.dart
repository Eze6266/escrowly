import 'package:flutter/material.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/Components/reusables.dart';

class TrxnFullDetailScreen extends StatefulWidget {
  const TrxnFullDetailScreen({super.key});

  @override
  State<TrxnFullDetailScreen> createState() => _TrxnFullDetailScreenState();
}

class _TrxnFullDetailScreenState extends State<TrxnFullDetailScreen> {
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
          child: Column(
            children: [
              Height(h: 2),
              Row(
                children: [
                  BckBtn(),
                  Width(w: 20),
                  kTxt(
                    text: 'Transaction Details',
                    weight: FontWeight.w600,
                    size: 16,
                  ),
                ],
              ),
              Height(h: 5),
              RowTxtWitUnderline(
                lTxt: 'Transacion Type',
                rtxt: 'Withdrawal',
              ),
              Height(h: 3),
              RowTxtWitUnderline(
                lTxt: 'Amount',
                rtxt: 'N40,000',
              ),
              Height(h: 3),
              RowTxtWitUnderline(
                lTxt: 'Escrowly Fee',
                rtxt: 'N300',
              ),
              Height(h: 3),
              RowTxtWitUnderline(
                lTxt: 'Date',
                rtxt: '01 Nov 2024, 01:36PM',
              ),
              Height(h: 3),
              RowTxtWitUnderline(
                lTxt: 'Customer Name',
                rtxt: 'Manuel Eze',
              ),
              Height(h: 3),
              RowTxtWitUnderline(
                lTxt: 'Customer Phone',
                rtxt: '07067581951',
              ),
              Height(h: 3),
              RowTxtWitUnderline(
                lTxt: 'Status',
                rtxt: 'Completed',
                rColor: kColors.greenColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
