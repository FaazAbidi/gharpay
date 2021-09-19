import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gharpay/models/MBModel.dart';
import 'package:gharpay/screens/MBAccountAnalyticsScreen.dart';
import 'package:gharpay/screens/MBBudgetScreen.dart';
import 'package:gharpay/screens/MBNewCardScreen.dart';
import 'package:gharpay/screens/MBSendMoneyScreen.dart';
import 'package:gharpay/screens/MBSetAmountScreen.dart';
import 'package:gharpay/utils/MBConts.dart';
import 'package:gharpay/utils/MBDataProvider.dart';
import 'package:gharpay/utils/MBImages.dart';
import 'package:gharpay/main.dart';
import 'package:gharpay/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../backendApiSimulation.dart';
import '../utils/AppColors.dart';

class MBHomeScreen extends StatefulWidget {
  @override
  MBHomeScreenState createState() => MBHomeScreenState();
}

class MBHomeScreenState extends State<MBHomeScreen> {
  List<BudgetDetails> operationsList = getOperationsList();
  List<BudgetDetails> operationsList1 = getOperationsList1();
  List<BudgetDetails> operationsList2 = getOperationsList2();
  bool HRAselected=true;
  // List<BudgetDetails> completeList = getCompleteList();

  TextEditingController dateController = TextEditingController();

  int i = 0;

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
        // appBar: AppBar(
        //   title: const Text('GharPAY'),
        //   backgroundColor: appPrimaryColor,
        // ),
        body: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: boxDecorationWithRoundedCorners(
                  backgroundColor: Colors.white,
                  boxShadow: defaultBoxShadow(),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            8.height,
                            Text(MBHelloText, style: TextStyle(fontSize: 17, color: Colors.black45)),

                            Text.rich(
                              TextSpan(
                                text: User.instance.name.split(new RegExp('\\s+'))[0],
                                style: TextStyle(fontSize: 25),
                                children: <TextSpan>[TextSpan(text: User.instance.name.split(new RegExp('\\s+'))[1], style: TextStyle(fontSize:23, color: appPrimaryColor, fontWeight: FontWeight.w600))],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    16.height,
                    ClipRRect(borderRadius: BorderRadius.all(Radius.circular(30)), child: Image.asset(User.instance.image, width: 100, height: 100)),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(MBOverViewText, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      Text(MBInSightText, style: TextStyle(fontSize: 16, color: gray.withOpacity(0.5), fontWeight: FontWeight.w500)),
                    ],
                  ),
                ],
              ).paddingAll(16),
              Container(
                height: 150,
                child: ListView.builder(
                  itemCount: 2,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(8),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: boxDecorationWithRoundedCorners(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        backgroundColor: i == index ? appPrimaryColor : appStore.cardColor,
                        boxShadow: defaultBoxShadow(),
                      ),
                      alignment: Alignment.center,
                      width: context.width() * 0.55,
                      margin: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Icon(index==0 ? Icons.public : Icons.account_balance_wallet, size: 50, color: i == index ? white : Colors.black),
                          15.width,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(index==0 ? "HRA Balance" : "Wallet Balance", style: TextStyle(color: i == index ? white : Colors.black)),
                              Text("Rs.", style: TextStyle(fontSize: 14, color: i == index ? white : Colors.black)),
                              Text(index==0 ? User.instance.hraWalletBalance.toStringAsFixed(1) : User.instance.jsWalletBalance.toStringAsFixed(1), style: boldTextStyle(size: 16, color: i == index ? white : Colors.black)),
                            ],
                          ),
                        ],
                      ),
                    ).onTap(() {
                      i = index;
                      setState(() {
                        if (i==0){
                          HRAselected=true;
                          print("true");
                        }else{
                          HRAselected=false;
                          print("false");
                        }
                      });
                    });
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  8.height,
                  Text(MBOperationText, style: TextStyle()),
                  16.height,
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    alignment: WrapAlignment.spaceEvenly,
                    runAlignment: WrapAlignment.spaceEvenly,
                    children: List.generate(
                      HRAselected? operationsList1.length : operationsList2.length,
                      (index) {
                        BudgetDetails data;
                        if (HRAselected==true){
                          data = operationsList1[index];
                        }else {
                          data = operationsList2[index];
                        }
                        // BudgetDetails data = operationsList1[index];
                        return Container(
                          width: HRAselected? context.width() * 1 : context.width() * 0.28,
                          margin: EdgeInsets.all(1),
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          decoration: boxDecorationWithRoundedCorners(borderRadius: BorderRadius.all(Radius.circular(16)),boxShadow: defaultBoxShadow(), backgroundColor: appStore.cardColor),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(data.icon, size: 35, color: appPrimaryColor),
                              10.height,
                              20.width,
                              Text(data.budgetType, textAlign: TextAlign.center, style: TextStyle(fontSize: 12.0)),
                            ],
                          ),
                        ).onTap(() {
                          if (index == 0) {
                            MBSendMoneyScreen().launch(context);
                          } else if (index == 2) {
                            MBSetAmountScreen().launch(context);
                          } else if (index == 5) {
                            MBBudgetScreen().launch(context);
                          } else if (index == 4) {
                            MBAccountAnalyticsScreen().launch(context);
                          } else if (index == 3) {
                            MBNewCardScreen().launch(context);
                          }
                          setState(() {});
                        });
                      },
                    ),
                  ).center(),
                  0.height,

                ],
              ).paddingOnly(right: 16, left: 16),

              145.height,
              Column(
                // verticalDirection: VerticalDirection.down,
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(child: Text("powered by JS Bank", style: TextStyle(color: Colors.grey, fontSize: 12.0, fontWeight: FontWeight.bold))),
                      // Image.asset("images/logo.png", height: 200, width: 200).cornerRadiusWithClipRRect(16),)
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
