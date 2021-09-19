import 'package:flutter/material.dart';
import 'package:gharpay/screens/MBTransferSuccessFullScreen.dart';
import 'package:gharpay/utils/MBConts.dart';
import 'package:gharpay/utils/MBImages.dart';
import 'package:gharpay/utils/MBWidgets.dart';
import 'package:gharpay/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

import 'MBPhoneRegistrationScreen.dart';
import 'MBVerifyAccountScreen.dart';

class MBSignInScreen extends StatefulWidget {
  @override
  MBSignInScreenState createState() => MBSignInScreenState();
}

class MBSignInScreenState extends State<MBSignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  FocusNode focusNodeEmail = FocusNode();
  FocusNode focusNodePassWord = FocusNode();
  bool isSender = true;
  bool isReceiver = false;

  @override
  void dispose() {
    super.dispose();
    focusNodeEmail.dispose();
    phoneController.dispose();
  }

  @override
  void initState() {
    super.initState();
    emailController.text = "abc@jsbank.com";
    phoneController.text = "+9233548195";
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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(MBTextSignInTittle, style: boldTextStyle(size: 26)),
                24.height,
                Text(MBSignInSubTitle, style: secondaryTextStyle(size: 14)),
                44.height,
                textFieldWidget(
                  hintText: 'Email',
                  controller: emailController,
                  textFieldType: TextFieldType.EMAIL,
                  focusNode: focusNodeEmail,
                  nextFocusNode: focusNodePassWord,
                ),
                8.height,
                textFieldWidget(
                  hintText: 'Phone',
                  controller: phoneController,
                  textFieldType: TextFieldType.PHONE,
                  focusNode: focusNodePassWord,
                ),
                16.height,
                AppButton(
                  textStyle: TextStyle(color: Colors.white),
                  textColor: Colors.white,
                  text: "Sign in",
                  onTap: () {
                    MBVerifyAccountScreen(
                      email: emailController.text,
                      phone: phoneController.text,
                    ).launch(context);
                  },
                  color: appPrimaryColor,
                  width: context.width(),
                  shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
                20.height,
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text.rich(
                    TextSpan(
                      text: MBTextAccountTitle,
                      style: primaryTextStyle(size: 14),
                      children: <TextSpan>[TextSpan(text: MBTextSignUp, style: secondaryTextStyle(size: 14))],
                    ),
                  ).onTap(() {
                    finish(context);
                  }),
                ),
              ],
            ).paddingOnly(top: 44, left: 16, right: 16, bottom: 16),
          ),
        ),
      ),
    );
  }
}
