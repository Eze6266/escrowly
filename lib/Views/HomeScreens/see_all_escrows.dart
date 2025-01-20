import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trustbridge/Controllers/Providers/OrderProviders/order_provider.dart';
import 'package:trustbridge/Utilities/Functions/add_comma_tostring_number.dart';
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
  String _searchQuery = ''; // Store the search query

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var orderProvider = Provider.of<OrderProvider>(context);

    // Filter transactions based on the search query
    List filteredTransactions = orderProvider.runningOrders
        .where((order) =>
            order['description'].toString().toLowerCase().contains(
                _searchQuery.toLowerCase()) || // Search by description
            order['amount']
                .toString()
                .toLowerCase()
                .contains(_searchQuery.toLowerCase())) // Search by status
        .toList();

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
                hint: 'Search escrows by description or amount',
                suffixIcon: Icon(
                  Icons.search,
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value; // Update the search query
                  });
                },
              ),
              Height(h: 3),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2 * size.width / 100,
                  mainAxisSpacing: 1.2 * size.height / 100,
                  childAspectRatio: 2 / 1,
                ),
                itemCount: filteredTransactions.length,
                itemBuilder: (context, index) {
                  var order = filteredTransactions[index];

                  return GestureDetector(
                    onTap: () {
                      goTo(context, FullEscrowDetailScreen());
                    },
                    child: PendingEscrowsBox(
                      product: order['description'].toString(),
                      amount: formatNumberWithCommas(
                        order['amount'].toString(),
                      ),
                      type: order['role'].toString(),
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
