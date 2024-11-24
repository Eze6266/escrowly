import 'package:flutter/material.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/Components/reusables.dart';

class FullEscrowDetailScreen extends StatefulWidget {
  const FullEscrowDetailScreen({super.key});

  @override
  State<FullEscrowDetailScreen> createState() => _FullEscrowDetailScreenState();
}

class _FullEscrowDetailScreenState extends State<FullEscrowDetailScreen> {
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
                    text: 'Escrow Details',
                    weight: FontWeight.w600,
                    size: 16,
                  ),
                ],
              ),
              Height(h: 5),
              RowTxtWitUnderline(
                lTxt: 'Escrow Type',
                rtxt: 'Selling',
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
                rtxt: 'Running',
                rColor: kColors.orange,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
