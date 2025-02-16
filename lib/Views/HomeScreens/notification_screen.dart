import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trustbridge/Controllers/Providers/AuthProviders/auth_provider.dart';
import 'package:trustbridge/Controllers/Providers/OrderProviders/order_provider.dart';
import 'package:trustbridge/Utilities/Functions/format_date_function.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/custom_txtfield.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/Components/notification_detail_dialog.dart';
import 'package:trustbridge/Views/HomeScreens/Components/notification_tile.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
          padding: EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
          child: Column(
            children: [
              Height(h: 2),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2 * size.width / 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            goBack(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                          ),
                        ),
                        Width(w: 1),
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
              ),
              Height(h: 2),
              notifProvider.notifcations.isEmpty
                  ? SizedBox.shrink()
                  : TitleTField(
                      height: 5 * size.height / 100,
                      hasTitle: false,
                      hint: 'Search notification',
                      suffixIcon: Icon(
                        Icons.search,
                        size: 18,
                      ),
                    ),
              Height(h: 1),
              Expanded(
                child: notifProvider.notifcations.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            kImages.emptysvg,
                            height: 5 * size.height / 100,
                          ),
                          Height(h: 1),
                          kTxt(
                            text:
                                'Your notifications are displayed here\n Looks like you dont\'t have any',
                            textalign: TextAlign.center,
                            size: 12,
                          )
                        ],
                      )
                    : ListView.builder(
                        itemCount: notifProvider.notifcations.length,
                        itemBuilder: (context, index) {
                          var notif = notifProvider.notifcations[index];
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: 0.8 * size.height / 100,
                              left: 1.5 * size.width / 100,
                              right: 1.5 * size.width / 100,
                            ),
                            child: NotificationTile(
                              viewTap: () {
                                notifProvider
                                    .readNotification(
                                        id: notif['id'].toString(),
                                        context: context)
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
                              status: notif['status'],
                              time: formatTime(notif['created_at']),
                              description: notif['description'],
                              date: formatDateTime(notif['created_at']),
                              title: notif['title'],
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
