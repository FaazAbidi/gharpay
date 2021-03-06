import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gharpay/models/MBModel.dart';
import 'package:gharpay/screens/MBAccountAnalyticsScreen.dart';
import 'package:gharpay/screens/MBBudgetScreen.dart';
import 'package:gharpay/screens/MBForexCalculator.dart';
import 'package:gharpay/screens/MBNewCardScreen.dart';
import 'package:gharpay/screens/MBSendMoneyScreen.dart';
import 'package:gharpay/screens/MBSetAmountScreen.dart';
import 'package:gharpay/screens/MBForexCalculator.dart';
import 'package:gharpay/utils/MBConts.dart';
import 'package:gharpay/utils/MBDataProvider.dart';
import 'package:gharpay/utils/MBImages.dart';
import 'package:gharpay/main.dart';
import 'package:gharpay/utils/AppColors.dart';
import 'package:gharpay/utils/MBWidgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
  bool HRAselected = User.instance.userType==UserType.receiver ? true : false;

  TextEditingController hraController = TextEditingController();
  // List<BudgetDetails> completeList = getCompleteList();

  TextEditingController dateController = TextEditingController();
  int i = 0;

  @override
  void initState() {
    User.instance.lastTransaction = User.instance.transactions.last;
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
                            Text(MBHelloText,
                                style: TextStyle(
                                    fontSize: 17, color: Colors.black45)),
                            Text.rich(
                              TextSpan(
                                text: User.instance.name
                                    .split(new RegExp('\\s+'))[0],
                                style: TextStyle(fontSize: 25),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: User.instance.name
                                          .split(new RegExp('\\s+'))[1],
                                      style: TextStyle(
                                          fontSize: 23,
                                          color: appPrimaryColor,
                                          fontWeight: FontWeight.w600))
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    16.height,
                    ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Image.asset(User.instance.image,
                            width: 100, height: 100)),
                  ],
                ),
              ),
              User.instance.userType==UserType.receiver ? Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(MBOverViewText,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                          Text(MBInSightText,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: gray.withOpacity(0.5),
                                  fontWeight: FontWeight.w500)),
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
                            backgroundColor:
                            i == index ? appPrimaryColor : appStore.cardColor,
                            boxShadow: defaultBoxShadow(),
                          ),
                          alignment: Alignment.center,
                          width: context.width() * 0.55,
                          margin: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                  index == 0
                                      ? Icons.public
                                      : Icons.account_balance_wallet,
                                  size: 50,
                                  color: i == index ? white : Colors.black),
                              15.width,
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      index == 0 ? "HRA Balance" : "Wallet Balance",
                                      style: TextStyle(
                                          color:
                                          i == index ? white : Colors.black)),
                                  6.height,
                                  Text(
                                      index == 0
                                          ? User.instance.hraWalletBalance
                                          .toString() +
                                          " Rs"
                                          : User.instance.jsWalletBalance
                                          .toString() +
                                          " Rs",
                                      style: boldTextStyle(
                                          size: 16,
                                          color:
                                          i == index ? white : Colors.black)),
                                ],
                              ),
                            ],
                          ),
                        ).onTap(() {
                          i = index;
                          setState(() {
                            if (i == 0) {
                              HRAselected = true;
                              print("true");
                            } else {
                              HRAselected = false;
                              print("false");
                            }
                          });
                        });
                      },
                    ),
                  ),
                ],
              ): Container(),
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
                      HRAselected
                          ? operationsList1.length
                          : operationsList2.length,
                      (index) {
                        BudgetDetails data;
                        if (HRAselected == true) {
                          data = operationsList1[index];
                        } else {
                          data = operationsList2[index];
                        }
                        // BudgetDetails data = operationsList1[index];
                        return Container(
                          width: HRAselected
                              ? context.width() * 1
                              : context.width() * 0.28,
                          margin: EdgeInsets.all(1),
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          decoration: boxDecorationWithRoundedCorners(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              boxShadow: defaultBoxShadow(),
                              backgroundColor: appStore.cardColor),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(data.icon, size: 35, color: appPrimaryColor),
                              10.height,
                              20.width,
                              Text(data.budgetType,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12.0)),
                            ],
                          ),
                        ).onTap(() {
                          if (index == 0 && HRAselected) {
                            // MBSendMoneyScreen().launch(context);
                            bool loadingHRAtoWallet = false;
                            print(loadingHRAtoWallet);
                            Alert(
                                context: context,
                                title: "Transfer from HRA to Wallet",
                                content: Column(
                                  children: <Widget>[
                                    textFieldWidget(
                                      hintText: 'HRA Amount',
                                      controller: hraController,
                                      textFieldType: TextFieldType.PHONE,
                                    ),
                                    10.height,
                                    Offstage(
                                      offstage: !loadingHRAtoWallet,
                                      child: Center(
                                        child: SpinKitDoubleBounce(
                                          color: appPrimaryColor,
                                          size: 50.0,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                buttons: [
                                  DialogButton(
                                    radius: BorderRadius.circular(15),
                                    color: appPrimaryColor,
                                    onPressed: () async {
                                      setState(() {
                                        loadingHRAtoWallet = true;
                                      });
                                      await NetworkProvider.transferHRAtoWallet(
                                          hraController.text);
                                      loadingHRAtoWallet = false;
                                      hraController.clear();
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Confirm Transfer",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  )
                                ]).show();
                          } else if (index == 0 && User.instance.userType == UserType.sender) {
                            MBSendMoneyScreen().launch(context);
                          }else if (index == 0 &&
                              User.instance.userType == UserType.sender) {
                            MBForexCalculator().launch(context);
                          } else if (index == 2) {
                            MBSetAmountScreen().launch(context);
                          } else if (index == 5) {
                            MBBudgetScreen().launch(context);
                          } else if (index == 4) {
                            MBAccountAnalyticsScreen().launch(context);
                          } else if (index == 3) {
                            MBNewCardScreen().launch(context);
                          } else if (index == 1) {
                            MBForexCalculator().launch(context);
                          }
                          setState(() {});
                        });
                      },
                    ),
                  ).center(),
                  10.height,
                ],
              ).paddingOnly(right: 16, left: 16),
              // SizedBox(
              //   height: context.height() * 0.2,
              // ),
              Container(
                decoration: boxDecorationWithRoundedCorners(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  backgroundColor: appPrimaryColor,
                  boxShadow: defaultBoxShadow(),
                ),

                // alignment: Alignment.center,
                width: context.width() * 0.9,
                margin: EdgeInsets.all(8),

                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    20.width,
                    Column(

                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                            Icons.credit_card_outlined,
                            size: 50,
                            color: white),
                        Text("Latest Transaction",
                            style: boldTextStyle(size: 20, color: white)),
                        10.height,
                        // Row(
                        //   children: [
                        //     Text("Sender: ", style: boldTextStyle(size: 15, color: white)),
                        //     // Spacer(),
                        //     Text(User.instance.lastTransaction.senderName, style: TextStyle(
                        //         color: white,
                        //         fontWeight: FontWeight.normal),),
                        //
                        //   ],
                        // ),
                        Text.rich(
                          TextSpan(
                            text: "Sender: ",
                            style: boldTextStyle(size: 15, color: white),
                            children: <TextSpan>[
                              TextSpan(
                                  text: User.instance.lastTransaction.senderName,

                                  style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.normal),)
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            text: "Receiver: ",
                            style: boldTextStyle(size: 15, color: white),
                            children: <TextSpan>[
                              TextSpan(
                                  text: User.instance.lastTransaction.receiverName,
                                  style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.normal))
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            text: "Receiver Currency: ",
                            style: boldTextStyle(size: 15, color: white),
                            children: <TextSpan>[
                              TextSpan(
                                  text: User.instance.lastTransaction.receiverCurrency,
                                  style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.normal))
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            text: "Sender Currency: ",
                            style: boldTextStyle(size: 15, color: white),
                            children: <TextSpan>[
                              TextSpan(
                                  text: User.instance.lastTransaction.senderCurrency,
                                  style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.normal))
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            text: "Exchange Rate: ",
                            style: boldTextStyle(size: 15, color: white),
                            children: <TextSpan>[
                              TextSpan(
                                  text: User.instance.lastTransaction.exchangeRate.toString(),
                                  style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.normal))
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            text: "Sent Amount: ",
                            style: boldTextStyle(size: 15, color: white),
                            children: <TextSpan>[
                              TextSpan(
                                  text: User.instance.lastTransaction.sentAmount.toString(),
                                  style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.normal))
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            text: "Date: ",
                            style: boldTextStyle(size: 15, color: white),
                            children: <TextSpan>[
                              TextSpan(
                                  text: User.instance.lastTransaction.time.toString(),
                                  style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.normal))
                            ],
                          ),
                        ),
                      ],
                    ),
                    // 10.width,
                    // Icon(
                    //     Icons.credit_card_outlined,
                    //     size: 50,
                    //     color: white),
                    10.width,
                  ],
                ).paddingOnly(left: 2, right: 5, bottom: 15, top: 15),
              ).paddingAll(5),
              Text("powered by JS Bank",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400)),
              15.height,
            ],
          ),
        ),
      ),
    );
  }
}
