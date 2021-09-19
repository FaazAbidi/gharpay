import 'package:flutter/material.dart';
import 'package:gharpay/utils/MBImages.dart';
import 'package:gharpay/utils/MBWidgets.dart';
import 'package:gharpay/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:gharpay/utils/MBWidgets.dart';

import '../backendApiSimulation.dart';
import 'MBSignInScreen.dart';

class MBProfileScreen extends StatefulWidget {
  @override
  MBProfileScreenState createState() => MBProfileScreenState();
}

class MBProfileScreenState extends State<MBProfileScreen> {
  String value = '';
  DateTime _date;

  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  FocusNode focusNodeName = FocusNode();
  FocusNode focusNodeDob = FocusNode();
  FocusNode focusNodePassword = FocusNode();
  FocusNode focusNodeMobile = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime _datePicker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1947),
        lastDate: DateTime(2030));
    if (_datePicker != null && _datePicker != _date) {
      _date = _datePicker;
    }
  }

  @override
  void dispose() {
    super.dispose();
    focusNodeName.dispose();
    focusNodeDob.dispose();
    focusNodePassword.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              28.height,
              Text('Profile', style: boldTextStyle(size: 26))
                  .paddingOnly(left: 16),
              16.height,
              Row(
                children: [
                  Container(
                      width: 120, child: Image.asset(User.instance.image)),
                  16.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(User.instance.name, style: boldTextStyle(size: 18)),
                      Text(
                          'Account Type : ${User.instance.userType == UserType.sender ? "Sender" : "Receiver"}',
                          overflow: TextOverflow.visible,
                          maxLines: 1,
                          style: primaryTextStyle()),
                    ],
                  ).expand()
                ],
              ),
              6.height,
              getField("Phone Number", User.instance.phone),
              6.height,
              getField("Email", User.instance.email),
              6.height,
              getField("Cnic", User.instance.cnic),
              // Text('Mobile No.', style: boldTextStyle()),
              // 6.height,
              // textFieldWidget(
              //   hintText: 'Enter Password',
              //   textFieldType: TextFieldType.PHONE,
              //   focusNode: focusNodeMobile,
              //   controller: mobileController,
              // ),
              32.height,
              AppButton(
                width: context.width(),
                color: appPrimaryColor,
                elevation: 10,
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MBSignInScreen()),
                      (Route<dynamic> route) => false);
                },
                child:
                    Text('Logout', style: boldTextStyle(color: Colors.white)),
              )
            ],
          ).paddingOnly(left: 16, right: 16, bottom: 16),
        ),
      ),
    );
  }
}
