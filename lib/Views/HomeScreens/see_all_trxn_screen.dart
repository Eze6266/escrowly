import 'package:flutter/material.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/custom_txtfield.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/Components/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/trxn_full_detail_screen.dart';

class SeeAllTrxnScreen extends StatefulWidget {
  const SeeAllTrxnScreen({super.key});

  @override
  State<SeeAllTrxnScreen> createState() => _SeeAllTrxnScreenState();
}

class _SeeAllTrxnScreenState extends State<SeeAllTrxnScreen> {
  List img = [
    kImages.onboard,
    kImages.onboard2,
    kImages.onboard1,
    kImages.onboard,
    kImages.onboard,
    kImages.onboard2,
    kImages.onboard1,
    kImages.onboard
  ];
  List type = [
    '1',
    '2',
    '1',
    '2',
    '1',
    '2',
    '1',
    '2',
  ];
  List amount = [
    '30000',
    '13000',
    '100000',
    '5000',
    '30000',
    '13000',
    '100000',
    '5000'
  ];
  List product = [
    'Tecno spark 4 phone 254g Ram',
    'Cinderella glass shoes',
    'Royce Black watch diamond',
    'Figo belt',
    'Tecno spark 4 phone 254g Ram',
    'Cinderella glass shoes',
    'Royce Black watch diamond',
    'Figo belt',
  ];
  List typeT = ['1', '2', '3', '4', '1', '2', '3', '4'];
  List status = ['1', '2', '3', '4', '1', '2', '3', '4'];

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
                  Width(w: 26),
                  kTxt(
                    text: 'Transactions',
                    weight: FontWeight.w600,
                    size: 16,
                  ),
                ],
              ),
              Height(h: 2),
              TitleTField(
                hasTitle: false,
                hint: 'Search transactions',
                suffixIcon: Icon(
                  Icons.search,
                ),
              ),
              Height(h: 3),
              Expanded(
                child: ListView.builder(
                  itemCount: status.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 0.8 * size.height / 100),
                      child: GestureDetector(
                        onTap: () {
                          goTo(context, TrxnFullDetailScreen());
                        },
                        child: RecentTransactionTile(
                          datetime: '',
                          title: '',
                          status: status[index],
                          type: typeT[index],
                          amount: amount[index],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
