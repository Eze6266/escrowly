// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trustbridge/Controllers/Providers/AuthProviders/auth_provider.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/SettingsScreens/Components/reusables.dart';

class AccountProfileScreen extends StatefulWidget {
  const AccountProfileScreen({super.key});

  @override
  State<AccountProfileScreen> createState() => _AccountProfileScreenState();
}

class _AccountProfileScreenState extends State<AccountProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColors.primaryColor,
        toolbarHeight: 0.001,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5 * size.width / 100),
            child: Column(
              children: [
                Height(h: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BckBtn(),
                    Width(w: 28),
                    kTxt(
                      text: 'Account',
                      size: 16,
                      weight: FontWeight.w400,
                    ),
                  ],
                ),
                Height(h: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    kTxt(
                      text: 'Basic Information',
                      size: 18,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
                Height(h: 2),
                BusinesInfoTile(
                  title: 'Full name',
                  sub: '${authProvider.firstName} ${authProvider.lastName}',
                ),
                Height(h: 2),
                BusinesInfoTile(
                  title: 'Email address',
                  sub: '${authProvider.email}',
                ),
                Height(h: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
