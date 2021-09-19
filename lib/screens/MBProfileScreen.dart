import 'package:flutter/material.dart';
import 'package:gharpay/utils/MBImages.dart';
import 'package:gharpay/utils/MBWidgets.dart';
import 'package:gharpay/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter/cupertino.dart';

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
                  CircularPercentIndicator(
                    radius: 90,
                    lineWidth: 4.0,
                    percent: 0.6,
                    progressColor: appPrimaryColor,
                    center: Image.asset(mb_profile1,
                            height: 82, width: 82, fit: BoxFit.cover)
                        .cornerRadiusWithClipRRect(100),
                  ),
                  16.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Samuel', style: boldTextStyle(size: 18)),
                      6.height,
                      Text('FlatCher',
                          style:
                              boldTextStyle(size: 18, color: appPrimaryColor)),
                      6.height,
                      Text('Account Type : Overseas',
                          overflow: TextOverflow.visible,
                          maxLines: 1,
                          style: primaryTextStyle()),
                    ],
                  ).expand()
                ],
              ),
              16.height,
              Text('Name', style: boldTextStyle()),
              6.height,
              textFieldWidget(
                hintText: 'Enter Name',
                textFieldType: TextFieldType.NAME,
                focusNode: focusNodeName,
                nextFocusNode: focusNodeDob,
                controller: nameController,
              ),
              6.height,
              Text('Date of Birth', style: boldTextStyle()),
              6.height,
              textFieldWidget(
                hintText: 'Enter Date of birth',
                textFieldType: TextFieldType.OTHER,
                focusNode: focusNodeDob,
                nextFocusNode: focusNodePassword,
                controller: dobController,
                icon: Icon(
                  Icons.date_range,
                  size: 18,
                  color: appPrimaryColor,
                ).onTap(
                  () async {
                    await selectDate(context);
                    dobController.text = _date.day.toString();
                    dobController.text = _date.month.toString();
                    dobController.text = _date.year.toString();
                    value = dobController.text = _date.day.toString() +
                        "/" +
                        _date.month.toString() +
                        "/" +
                        _date.year.toString();
                    setState(() {});
                  },
                ),
              ),
              6.height,
              Text('Password', style: boldTextStyle()),
              6.height,
              textFieldWidget(
                hintText: 'Enter Password',
                textFieldType: TextFieldType.PASSWORD,
                focusNode: focusNodePassword,
                controller: passWordController,
              ),
              // Text('Mobile No.', style: boldTextStyle()),
              // 6.height,
              // textFieldWidget(
              //   hintText: 'Enter Password',
              //   textFieldType: TextFieldType.PHONE,
              //   focusNode: focusNodeMobile,
              //   controller: mobileController,
              // ),
              Text('Mobile No.', style: boldTextStyle()),
              6.height,
              textFieldWidget(
                hintText: 'Enter Mobile No.',
                textFieldType: TextFieldType.PHONE,
                focusNode: focusNodeMobile,
                controller: mobileController,
              ),
              32.height,
              AppButton(
                width: context.width(),
                color: appPrimaryColor,
                elevation: 12,
                onTap: () {},
                child:
                Text('Update Information', style: boldTextStyle(color: Colors.white)),
              ),
              32.height,
              AppButton(
                width: context.width(),
                color: appPrimaryColor,
                elevation: 12,
                onTap: () {},
                child:
                    Text('Sign Out', style: boldTextStyle(color: Colors.white)),
              )
            ],
          ).paddingOnly(left: 16, right: 16, bottom: 16),
        ),
      ),
    );
  }
}
