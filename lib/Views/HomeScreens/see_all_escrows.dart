import 'package:flutter/material.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/custom_txtfield.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/Components/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/EscrowScreens/full_escrow_detail_screen.dart';

class SeeAllescrowsScreen extends StatefulWidget {
  const SeeAllescrowsScreen({super.key});

  @override
  State<SeeAllescrowsScreen> createState() => _SeeAllescrowsScreenState();
}

class _SeeAllescrowsScreenState extends State<SeeAllescrowsScreen> {
  List img = [
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
  ];
  List amount = ['30000', '13000', '100000', '5000'];
  List product = [
    'Tecno spark 4 phone 254g Ram',
    'Cinderella glass shoes',
    'Royce Black watch diamond',
    'Figo belt',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
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
                    text: 'Escrows',
                    weight: FontWeight.w600,
                    size: 16,
                  ),
                ],
              ),
              Height(h: 2),
              TitleTField(
                hasTitle: false,
                hint: 'Search escrows',
                suffixIcon: Icon(
                  Icons.search,
                ),
              ),
              Height(h: 3),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2 * size.width / 100,
                  mainAxisSpacing: 1.2 * size.height / 100,
                  childAspectRatio: 2 / 2,
                ),
                itemCount: product.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      goTo(context, FullEscrowDetailScreen());
                    },
                    child: PendingEscrowsBox(
                      product: product[index],
                      amount: amount[index],
                      img: img[index],
                      type: type[index],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
