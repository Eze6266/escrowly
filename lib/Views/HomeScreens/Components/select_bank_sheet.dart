import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:trustbridge/Controllers/Providers/AuthProviders/auth_provider.dart';
import 'package:trustbridge/Controllers/Providers/TransactionProviders/transaction_provider.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/custom_txtfield.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';

class SelectBankSheet extends StatefulWidget {
  const SelectBankSheet({super.key});

  @override
  State<SelectBankSheet> createState() => _SelectBankSheetState();
}

class _SelectBankSheetState extends State<SelectBankSheet> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, String>> filteredBanks = [];
  FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(searchFocusNode);
    });
    // Initialize filteredBanks with the fetched bank list
    var trxnProvider = Provider.of<TransactionProvider>(context, listen: false);
    filteredBanks = trxnProvider.banks
        .map((e) => {
              'name': e['name'] as String,
              'bankcode': e['bankcode']
                  .toString(), // Ensure code is converted to String
            })
        .toList();
  }

  void filterBanks(String query) {
    var trxnProvider = Provider.of<TransactionProvider>(context, listen: false);
    if (query.isEmpty) {
      setState(() {
        filteredBanks = trxnProvider.banks
            .map((e) => {
                  'name': e['name'] as String,
                  'bankcode':
                      e['bankcode'].toString(), // Convert code to String
                })
            .toList();
      });
    } else {
      setState(() {
        filteredBanks = trxnProvider.banks
            .map((e) => {
                  'name': e['name'] as String,
                  'bankcode':
                      e['bankcode'].toString(), // Convert code to String
                })
            .where((bank) =>
                bank['name']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var trxnProvider = Provider.of<TransactionProvider>(context);
    var authProvider = Provider.of<AuthProvider>(context);
    return Container(
      height: 95 * size.height / 100,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: kColors.whiteColor,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 3 * size.width / 100,
        vertical: 2 * size.height / 100,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2 * size.width / 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                kTxt(
                  text: 'Select Bank',
                  size: 18,
                  weight: FontWeight.w600,
                ),
                GestureDetector(
                  onTap: () {
                    goBack(context);
                  },
                  child: CancelCircle(),
                ),
              ],
            ),
          ),
          Height(h: 3),
          // Search Text Field
          SearchTField(
            focused: searchFocusNode,
            hint: 'Search bank name',
            prefixicon: Icon(Icons.search),
            height: 6.5 * size.height / 100,
            controller: searchController,
            onChanged: (value) {
              filterBanks(value); // Call filter function on every input change
            },
          ),
          Height(h: 3),
          // Display the filtered list of banks
          Expanded(
            child: ListView.builder(
              itemCount: filteredBanks.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 1.5 * size.height / 100),
                  child: GestureDetector(
                    onTap: () {
                      trxnProvider.selectedBank = filteredBanks[index]['name']!;
                      trxnProvider.selectedCode =
                          filteredBanks[index]['bankcode']!;
                      trxnProvider.trxnNotifier();
                      goBack(context);
                    },
                    child: SelectBankTile(
                      bankName: filteredBanks[index]['name'].toString(),
                      img: kImages.moniepointsvg,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SelectBankTile extends StatelessWidget {
  SelectBankTile({
    super.key,
    required this.bankName,
    required this.img,
  });
  String bankName, img;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 2 * size.width / 100,
        vertical: 1 * size.height / 100,
      ),
      height: 6 * size.height / 100,
      width: 90 * size.width / 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kColors.whitishGrey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // SvgPicture.asset(img),
              Width(w: 1),
              SizedBox(
                width: 78 * size.width / 100,
                child: kTxt(
                  text: bankName,
                  weight: FontWeight.w500,
                  size: 16,
                  maxLine: 1,
                ),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: kColors.textGrey,
            size: 14,
          ),
        ],
      ),
    );
  }
}
