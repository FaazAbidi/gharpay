import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gharpay/screens/MBSettingCommonCard.dart';
import 'package:gharpay/utils/MBColors.dart';
import 'package:gharpay/utils/MBWidgets.dart';
import 'package:gharpay/main.dart';
import 'package:gharpay/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:gharpay/utils/MBWidgets.dart';

import '../backendApiSimulation.dart';
import 'MBSignInScreen.dart';

class MBCardScreen extends StatefulWidget {
  static String tag = '/MBWatchTutorialScreen';

  @override
  MBCardScreenState createState() => MBCardScreenState();
}

class MBCardScreenState extends State<MBCardScreen> {
  bool status = true;
  bool statusValue = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              28.height,
              Text('Your Cards', style: boldTextStyle(size: 26))
                  .paddingOnly(left: 16),
              8.height,
              Text('You have ${User.instance.cards.length} Physical Cards ',
                      style: primaryTextStyle())
                  .paddingOnly(left: 16),
              16.height,
              Container(
                height: 220,
                child: ListView.builder(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    scrollDirection: Axis.horizontal,
                    itemCount: User.instance.cards.length,
                    itemBuilder: (context, index) {
                      return mastercardWidget(
                              width: context.width() * 0.85,
                              name: User.instance.cards[index].name,
                              cardNum: User.instance.cards[index].no,
                              exp: User.instance.cards[index].expiryDate)
                          .paddingOnly(right: 8, left: 8);
                    }),
              ),
              16.height,
              Text('Card Details', style: boldTextStyle())
                  .paddingOnly(left: 16),
              16.height,
              getField("Holder Name", User.instance.cards[0].name),
              16.height,
              getField("Card Number", User.instance.cards[0].no),
              16.height,
              getField("Expiry Date",
                  "${User.instance.cards[0].expiryDate.month}/${User.instance.cards[0].expiryDate.year}"),
              16.height,
              getField("CVV", User.instance.cards[0].cvv),
            ],
          ),
        ),
      ),
    );
  }
}
