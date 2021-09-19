import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gharpay/backendApiSimulation.dart';
import 'package:gharpay/models/MBModel.dart';
import 'package:gharpay/screens/MBForexCalculator.dart';
import 'package:gharpay/utils/MBDataProvider.dart';
import 'package:gharpay/utils/AppColors.dart';
import 'package:gharpay/utils/MBWidgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../utils/AppColors.dart';
import '../utils/AppColors.dart';
import '../utils/AppColors.dart';

class MBSendMoneyScreen extends StatefulWidget {
  @override
  MBSendMoneyScreenState createState() => MBSendMoneyScreenState();
}

class MBSendMoneyScreenState extends State<MBSendMoneyScreen> {

  int i = 0;
  int j = 1;
  int K = 3;

  TextEditingController phoneController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController nameController = TextEditingController();

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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Alert(
              context: context,
              title: "Add a new payee",
              content: Column(
                children: <Widget>[
                  textFieldWidget(
                    hintText: 'Phone',
                    controller: phoneController,
                    textFieldType: TextFieldType.PHONE,
                  ),
                  10.height,
                  textFieldWidget(
                    hintText: 'CNIC',
                    controller: cnicController,
                    textFieldType: TextFieldType.PHONE,
                  ),
                  10.height,
                  textFieldWidget(
                    hintText: 'Name',
                    controller: nameController,
                    textFieldType: TextFieldType.NAME,
                  ),
                ],
              ),
              buttons: [
                DialogButton(
                  color: appPrimaryColor,
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Add payee",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ]).show();
        },
        backgroundColor: appPrimaryColor,
        child: Icon(Icons.add)
        ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0,60,30,30),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select a Payee',
              style: TextStyle(fontSize: 20),
            ),
            20.height,
            Column(
              children: List.generate(userDatabase.last.payees.length, (index) => SinglePayeeCard(userDatabase.last.payees[index])),
            )
          ],
            )
        )),
      );
  }
}


class EnterAmountScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}



class SinglePayeeCard extends StatelessWidget {
  Payee payee;
  SinglePayeeCard(this.payee);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: boxDecorationWithRoundedCorners(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          backgroundColor: appStore.cardColor,
          boxShadow: defaultBoxShadow(spreadRadius: 2, blurRadius: 1.0),
        ),
        height: 120,
        width: double.infinity,
        child: InkWell(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => MBForexCalculator(payee: this.payee,)));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Image.asset(payee.image),
                ),
                flex: 3,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        payee.name,
                        style: TextStyle(fontSize: 18, color: appPrimaryColor),
                      ),
                      5.height,
                      Row(
                        children: [
                          Icon(Icons.phone,color: Colors.blueGrey,size: 12,),
                          2.width,
                          Text(
                            payee.mobileNo,
                            style: TextStyle(fontSize: 12, color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                flex: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
