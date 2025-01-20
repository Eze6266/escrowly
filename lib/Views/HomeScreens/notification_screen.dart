import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trustbridge/Controllers/Providers/AuthProviders/auth_provider.dart';
import 'package:trustbridge/Controllers/Providers/OrderProviders/order_provider.dart';
import 'package:trustbridge/Utilities/Functions/format_date_function.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/custom_txtfield.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/Components/notification_detail_dialog.dart';
import 'package:trustbridge/Views/HomeScreens/Components/notification_tile.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List title = [
    'Payout Completed',
    'Escrow Request Received',
    'Withdrawal Requested',
    'Deposit Initiated',
    'Withdrawal Completed',
  ];
  List description = [
    'You got a payout of N50k',
    'John Doe created an escrow with you',
    'You requested a withdrawal of N23,000',
    'You initiated a deposit',
    'You requested a withdrawal of N200k',
  ];
  List date = [
    'November 22, 2024',
    'November 22, 2024',
    'November 22, 2024',
    'November 22, 2024',
    'November 22, 2024',
  ];
  List times = [
    '10:20AM',
    '10:20AM',
    '10:20AM',
    '10:20AM',
    '10:20AM',
  ];
  List status = [
    '1',
    '2',
    '1',
    '1',
    '2',
  ];
  List type = [
    'Payout',
    'Escrow',
    'Withdrawal',
    'Deposit',
    'Withdrawal',
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var notifProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColors.primaryColor,
        toolbarHeight: 0.001,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2 * size.width / 100),
          child: Column(
            children: [
              Height(h: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BckBtn(),
                      Width(w: 5),
                      kTxt(
                        text: 'Notifications',
                        weight: FontWeight.w600,
                        size: 16,
                      ),
                    ],
                  ),
                  kTxt(
                    text: 'Mark all as read',
                    weight: FontWeight.w500,
                    size: 12,
                    color: kColors.primaryColor,
                  ),
                ],
              ),
              Height(h: 2),
              TitleTField(
                hasTitle: false,
                hint: 'Search notification',
                suffixIcon: Icon(
                  Icons.search,
                ),
              ),
              Height(h: 1),
              Expanded(
                child: ListView.builder(
                  itemCount: notifProvider.notifcations.length,
                  itemBuilder: (context, index) {
                    var notif = notifProvider.notifcations[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 0.8 * size.height / 100),
                      child: GestureDetector(
                        onTap: () {
                          notifProvider
                              .readNotification(
                                  id: notif['id'], context: context)
                              .then((value) {
                            if (value == 'true') {
                            } else {}
                          });
                          showNotificationDetailDialog(
                            dateTime:
                                '${formatDateTime(notif['created_at'])} ${formatTime(notif['created_at'])}',
                            description: notif['description'],
                            context: context,
                            title: notif['title'],
                            type: notif['type'],
                          );
                          notifProvider.getNotifcations(context: context);
                          notifProvider.authNotifier();
                        },
                        child: NotificationTile(
                          status: notif['status'],
                          time: formatTime(notif['created_at']),
                          description: notif['description'],
                          date: formatDateTime(notif['created_at']),
                          title: notif['title'],
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
