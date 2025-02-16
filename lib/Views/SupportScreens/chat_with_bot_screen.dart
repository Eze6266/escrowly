import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';

class ChatWithBotScreen extends StatefulWidget {
  @override
  _ChatWithBotScreenState createState() => _ChatWithBotScreenState();
}

class _ChatWithBotScreenState extends State<ChatWithBotScreen> {
  // A map to define follow-up options for each selected option

  final Map<String, List<Map<String, dynamic>>> followUpOptions = {
/////////////////////////GENERAL ENQUIRY/////////////////////////////////
    'General Enquiry': [
      {
        'question': 'What is your inquiry about?',
        'options': <String>[
          'Favorites',
          'Change Profile Picture',
          'Delete Account',
          'Change Password',
          'Switch Account',
          'Forgot Password',
        ],
      },
    ],
    'Favorites': [
      {
        'question': 'What would you like to do?',
        'options': <String>['Add a new favorite', 'View my favorites'],
      },
    ],
    'Add a new favorite': [
      {
        'question':
            'Adding an item to favorite is quite simple. All you have to do is go on to the FMCG screen and click on the item you wish to add to favorites. Now you should see a screen showing a detailed info of the product. Scroll to the bottom where you should see a heart icon, click on the icon and the product would automatically be added to your favorite list.',
        'options': <String>['Understood'],
      },
    ],
    'View my favorites': [
      {
        'question':
            'After adding items to favorite and want to see them, here is how to go about it. Log in to your Escrowly account as a user, and on the homepage just beside the notifications icon at the top right you would see a heart icon. Click on that icon and you should be navigated to the screen where you would see all your favorited items.',
        'options': <String>['Understood'],
      },
    ],
    'Change Profile Picture': [
      {
        'question':
            'To change your profile picture click on the current profile picture icon/image at the top left corner on the homepage. You should be navigated to the profile screen where you would see your current profile picture and other details like First Name. Now click on the current profile picture on that page, your mobile device photo gallery should open up for you to select a new image',
        'options': <String>['Understood'],
      },
    ],
    'Delete Account': [
      {
        'question':
            'To delete a Escrowly account all you have to do is go to the settings tab on the device and click on Delete Account. A prompt should come up for you to confirm deletion of the account. (Note that when an account is deleted it can\'t be retrevied)',
        'options': <String>['Understood'],
      },
    ],
    'Change Password': [
      {
        'question':
            'To change your password login to your Escrowly account and click on the settings tab below. You should see the Passwords tile, click on it and you should be navigated to a screen to input your old password along side the new desired password.',
        'options': <String>['Understood'],
      },
    ],
    'Switch Accont': [
      {
        'question':
            'To switch account click on the settings tab from the homepage. You should see the switch accounts tile. Click on that and you would be navigated to the screen where you can select how to go in',
        'options': <String>['Understood'],
      },
    ],
    'Forgot Password': [
      {
        'question':
            'If you forgot your password and want to login to your account, here is how to go about it. While on the login screen, you should see a text below the login button that says "forgot password" click on that and an mail for password reset should be sent to your email address.',
        'options': <String>['Understood'],
      },
    ],
/////////////////////////GENERAL ENQUIRY/////////////////////////////////

/////////////////////////WALLET ISSUES/////////////////////////////////

    'Wallet Issues': [
      {
        'question': 'What wallet issue are you having?',
        'options': <String>[
          'Funding',
          'Transfer',
          'Convert Funds',
          'Cards',
        ], // Explicit type
      },
    ],
    'Funding': [
      {
        'question': 'What type of funding?',
        'options': <String>[
          'Escrowly Account Funding',
          'Direct Funding',
        ],
      },
    ],
    'Escrowly Account Funding': [
      {
        'question':
            'To fund your account using your dedicated account number is pretty simple. From the homepage click on the "fund" button, you should be presented with the options on funding methods. Select the "Escrowly Account" option and you should be taken to the screen where your dedicated account number is displayed. Now just make a wire transfer to the account number and click the button that says "I have made the transfer", it should automatically be added to ur account balance.',
        'options': <String>[
          'Understood',
        ],
      },
    ],
    'Direct Funding': [
      {
        'question':
            'To fund your account using your card, ussd, or other means is pretty simple. From the homepage click on the "fund" button, you should be presented with the options on funding methods. Select the "Direct Funding" option and you should be directed to a web page where you select to use either ussd, transfer, or using your card.',
        'options': <String>[
          'Understood',
        ],
      },
    ],
    'Transfer': [
      {
        'question': 'Which Transfer option',
        'options': <String>[
          'Bank Transfer',
          'Transfer To Escrowly Account',
        ],
      },
    ],
    'Bank Transfer': [
      {
        'question':
            'To make a wire transfer to any bank is quite simple on picadilys. From the homepage click on transfer funds, it should take you a page with 2 options. Select Bank Transfer then enter an amount, select bank, enter recipient account number, a description and click proceed.',
        'options': <String>[
          'Understood',
        ],
      },
    ],
    'Transfer To Escrowly Account': [
      {
        'question':
            'To make a wire transfer to a Escrowly account is quite simple. From the homepage click on transfer funds, it should take you a page with 2 options. Select "Send to Escrowly\'s virtual account" then enter the recipient Escrowly account number, an amount, a description and click proceed.',
        'options': <String>[
          'Understood',
        ],
      },
    ],

/////////////////////////WALLET ISSUES/////////////////////////////////

/////////////////////////VAS ENQUIRY/////////////////////////////////
    'VAS Enquiry': [
      {
        'question': 'What vas issue are you having?',
        'options': <String>[
          'Airtime',
          'Data Top-Up',
          'Bill Payments',
          'FMCG',
        ],
      },
    ],
    'Airtime': [
      {
        'question':
            'Purchasing airtime on Escrowly is very easy. From the homepage click on the VAS tab below and select Airtime Recharge. It should take you to a screen where you would select a network provider(MTN, Airtel....), enter a phone number to recharge or select from your phone\'s contact. next you select or enter an amount to recharge and click on next to complete the transaction.',
        'options': <String>[
          'Understood',
        ], // Explicit type
      },
    ],
    'Data Top-Up': [
      {
        'question':
            'To purcahase a data bundle on Escrowly\'s is quite easy, from the homepage click on the VAS tab below and from there click on Data Top-Up. You should be navigated to a screen to select network(MTN, Airtel....), enter or select phone number from your contact list, select a data plan and click on Next. A summary page of the details should be shown for confirmation before proceeding.',
        'options': <String>[
          'Understood',
        ], // Explicit type
      },
    ],
    'Bill Payments': [
      {
        'question': 'which bill payment are you talking about?',
        'options': <String>[
          'Cable TV',
          'Electricity Bill',
        ], // Explicit type
      },
    ],
    'Cable TV': [
      {
        'question':
            'To recharge your cable tv using Escrowly is very simple. From the homepage click on the VAS tab below, then select Bill Payments, then click on Cable TV from the options displayed. Now all you have to do is select your cable provider(DSTV, GOTV...), enter your smart card number, verify the smart card number, select a cable package, then enter the duration for the subscription. (Note: this can only be done after the smart card number has been verified). Click on Next, view the summary to confirm and proceed.',
        'options': <String>[
          'Understood',
        ], // Explicit type
      },
    ],
    'Electricity Bill': [
      {
        'question':
            'To pay for your electricity on Escrowly is swift as a charm. From the homepage click on your VAS and Click Bill Payments. Next select Electricity Bill and fill the necessary infos. Select your electricity provider(ikeja-electric, kano-electric...), select the meter type(prepaid or postpaid), enter meter number, verify the meter number, enter amount and proceed. (Note: you must verify your meter number before proceeding). After that, view the summary of the transaction before continuing.',
        'options': <String>[
          'Understood',
        ], // Explicit type
      },
    ],
    'FMCG': [
      {
        'question':
            'Purchasing FMCG is quite simple, all you need to do is click on the VAS tab from the homepage then select FMCG. it should take you to a page where you can either choose to view all products or a particular type of product. Next you should see a page with the products, you can add the product to cart or click on it to view the product full detail. To checkout the cart item, simply click on the cart icon at the right of the search panel and it should take you to the checkout page. From there clicking on checkout takes you to the page to select billing address and proceeding with payment.',
        'options': <String>[
          'Understood',
        ], // Explicit type
      },
    ],

/////////////////////////VAS ENQUIRY/////////////////////////////////

/////////////////////////SERVICES/////////////////////////////////

    'Services': [
      {
        'question': 'What question do you have about services?',
        'options': <String>[
          'Travel and Leisure',
          //'Food and Drinks',
        ], // Explicit type
      },
    ],
    'Travel and Leisure': [
      {
        'question': 'Which travel & leisure service do you need info on?',
        'options': <String>[
          'Hotels and Shortlets',
          'Land Transport',
        ], // Explicit type
      },
    ],
    'Hotels and Shortlets': [
      {
        'question':
            'To book a hotel or shortlet aprtment on Escrowly is very simple following this simple steps. From the homepage click on the services tab below, next click on the Hotels and Shortlet option then select a hotel or shortlet from the list. it should take you to a screen detailing the information about the hotel/shortlet, the price, name, description and images. Click on the Book Now button below and you\'re good to go.',
        'options': <String>[
          'Understood',
        ], // Explicit type
      },
    ],
    'Land Transport': [
      {
        'question':
            'You can book your land travels on Escrowly very easily. From the homepage click on services and next click on travels and leisure option. You should see 2 options on the next page, click Land transport and fill the form for your travel. After that click on Book travel.',
        'options': <String>[
          'Understood',
        ], // Explicit type
      },
    ],
/////////////////////////SERVICES/////////////////////////////////
  };

  final List<Map<String, dynamic>> _conversation = [
    {
      'type': 'bot',
      'message': 'How can we help you today?',
      'options': <String>[
        'General Enquiry',
        'Wallet Issues',
        'VAS Enquiry',
        'Services',
      ],
    },
  ];

  void _handleOptionSelected(String option, int messageIndex) {
    setState(() {
      // Remove options from the current bot message immediately
      _conversation[messageIndex]
          ['options'] = <String>[]; // Ensure type consistency

      // Add the user's selection to the conversation immediately
      _conversation.add({
        'type': 'user',
        'message': option,
      });
    });

    // Start typing delay after 1 second
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        // Add the "Typing..." message
        _conversation.add({
          'type': 'bot',
          'message': '...',
        });
      });

      // Show the follow-up options after 3 seconds
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          // Remove the "Typing..." message
          _conversation.removeLast();

          // Check if there are follow-up questions for the selected option
          if (followUpOptions.containsKey(option)) {
            // Get the follow-up questions
            List<Map<String, dynamic>> nextQuestions = followUpOptions[option]!;

            // Add the first follow-up question and its options
            _conversation.add({
              'type': 'bot',
              'message': nextQuestions[0]['question'],
              'options': nextQuestions[0]['options'],
            });
          }
        });
      });
    });
  }

  Widget _buildChatBubble(Map<String, dynamic> message) {
    Size size = MediaQuery.of(context).size;

    bool isBot = message['type'] == 'bot';

    return Align(
      alignment: isBot ? Alignment.centerLeft : Alignment.centerRight,
      child: Row(
        mainAxisAlignment:
            isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          isBot
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CircleAvatar(
                    radius: 10,
                    child: Image.asset(kImages.appicon),
                  ),
                )
              : SizedBox.shrink(),
          SizedBox(width: 4),
          message['message'] == '...'
              ? Row(
                  children: [
                    Image.asset(
                      kImages.typing,
                      height: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Typing...',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              : Container(
                  margin: EdgeInsets.only(
                    top: 2.5,
                    bottom: 4,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.0,
                    vertical: 5.0,
                  ),
                  decoration: BoxDecoration(
                    color: isBot ? Colors.white : Colors.green[100],
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: size.width *
                            0.8), // Set a max width for the container
                    child: kTxt(
                      text: message['message'],
                      color: Colors.black,
                      maxLine: 200, // Adjust to fit the desired text limit
                      weight: FontWeight.w500,
                      size: 14,
                      softRap: true, // Ensures text wraps properly
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildOptions(List<String> options, int messageIndex) {
    Size size = MediaQuery.of(context).size;

    return Align(
      alignment: Alignment.centerRight,
      child: Wrap(
        alignment: WrapAlignment.end,
        spacing: 5.0,
        runSpacing: 6.0,
        children: options.map((option) {
          return GestureDetector(
            onTap: () {
              _handleOptionSelected(option, messageIndex); // Pass messageIndex
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 2 * size.width / 100,
                vertical: 0.8 * size.height / 100,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.blue[100],
              ),
              child: kTxt(
                text: option,
                weight: FontWeight.w400,
                maxLine: 200,
                color: Colors.black,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                goBack(context);
              },
              child: Icon(
                Icons.arrow_back,
                size: 20,
              ),
            ),
            Width(w: 2),
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CircleAvatar(
                radius: 13,
                child: Image.asset(kImages.appicon),
              ),
            ),
            Width(w: 1.5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kTxt(
                  text: 'Lizzy Gomez',
                  size: 13,
                  weight: FontWeight.w600,
                ),
                Height(h: 0.2),
                kTxt(
                  text: 'Active',
                  size: 11,
                  weight: FontWeight.w500,
                  color: kColors.primaryColor,
                ),
              ],
            ),
          ],
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
          child: Column(
            children: [
              Height(h: 1),
              Expanded(
                child: ListView.builder(
                  itemCount: _conversation.length,
                  itemBuilder: (context, index) {
                    final message = _conversation[index];

                    // Check if the message is a bot message with options
                    if (message['type'] == 'bot' &&
                        message.containsKey('options')) {
                      // Only show options for the last message with options
                      final isLastWithOptions = index ==
                          _conversation.lastIndexWhere((msg) =>
                              msg['type'] == 'bot' &&
                              msg.containsKey('options'));
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildChatBubble(message), // Bot's response
                          if (isLastWithOptions)
                            _buildOptions(
                                message['options'], index), // Pass index here
                        ],
                      );
                    }
                    return _buildChatBubble(message); // Display other messages
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
