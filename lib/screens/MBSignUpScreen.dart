import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gharpay/screens/MBPhoneRegistrationScreen.dart';
import 'package:gharpay/screens/MBSignInScreen.dart';
import 'package:gharpay/utils/MBConts.dart';
import 'package:gharpay/utils/MBImages.dart';
import 'package:gharpay/utils/MBWidgets.dart';
import 'package:gharpay/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

enum accountType {
  sender,
  receiver,
}

class MBSignUpScreen extends StatefulWidget {
  @override
  MBSignUpScreenState createState() => MBSignUpScreenState();
}

class MBSignUpScreenState extends State<MBSignUpScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  // TextEditingController cninController = TextEditingController();

  FocusNode focusNodeFullName = FocusNode();
  FocusNode focusNodeEmail = FocusNode();
  FocusNode focusNodePhoneNum = FocusNode();

  bool rememberMe = false;
  accountType accType;
  bool isReceiver = false;
  bool isSender = true;


  @override
  void dispose() {
    super.dispose();
    focusNodeFullName.dispose();
    focusNodeEmail.dispose();
    focusNodePhoneNum.dispose();
  }

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

  List<Color> buttonColorsUpdated() {
    print(isReceiver);
    print(isSender);
    if (isReceiver || isSender) {
      return [appPrimaryColor, Colors.white];
    } else if (!isReceiver && !isSender){
      return [Colors.white, appPrimaryColor];
    }

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset("images/logo.png", height: 120, width: 120).cornerRadiusWithClipRRect(16),
                Text(MBSignUpTitle, style: boldTextStyle(size: 26)),
                24.height,
                Text(MBSignUpSubTitle, style: secondaryTextStyle(size: 14), textAlign: TextAlign.center),
                44.height,
                textFieldWidget(
                  hintText: 'Full Name',
                  controller: fullNameController,
                  textFieldType: TextFieldType.NAME,
                  focusNode: focusNodeFullName,
                  nextFocusNode: focusNodeEmail,
                ),
                8.height,
                textFieldWidget(
                  hintText: 'Email Address',
                  controller: emailController,
                  textFieldType: TextFieldType.EMAIL,
                  focusNode: focusNodeEmail,
                  nextFocusNode: focusNodePhoneNum,
                ),
                16.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("I want to",
                      style: TextStyle(
                        fontSize: 16
                      ),
                    ),
                  ],
                ),
                16.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppButton(
                      textStyle: TextStyle(color: isSender ? Colors.white : appPrimaryColor),
                      textColor: isSender ? Colors.white : appPrimaryColor,
                      text: "send money",
                      onTap: () {
                        setState(() {
                          isSender = true;
                          isReceiver = false;
                        });
                      },
                      color: isSender ? appPrimaryColor: Colors.white,
                      width: context.width()/2.4,
                      shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                    8.width,
                    AppButton(
                      textStyle: TextStyle(color: isReceiver ? Colors.white : appPrimaryColor),
                      textColor: isReceiver ? Colors.white : appPrimaryColor,
                      text: "receive money",
                      onTap: () {
                        setState(() {
                          isSender = false;
                          isReceiver = true;
                        });
                      },
                      color: isReceiver ? appPrimaryColor : Colors.white,
                      width: context.width()/2.4,
                      shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                  ],
                ),
                16.height,
                Offstage(
                  offstage: isSender,
                  child: Column(
                    children: [
                      textFieldWidget(
                        hintText: 'CNIC',
                        controller: cnicController,
                        textFieldType: TextFieldType.EMAIL,
                        focusNode: focusNodeEmail,
                        nextFocusNode: focusNodePhoneNum,
                      ),
                      8.height,
                      textFieldWidget(
                        hintText: 'CNIC Issuance Date',
                        // controller: emailController,
                        textFieldType: TextFieldType.EMAIL,
                        focusNode: focusNodeEmail,
                        nextFocusNode: focusNodePhoneNum,
                      ),
                    ],
                  ),

                ),
                Theme(
                  data: Theme.of(context).copyWith(unselectedWidgetColor: Colors.grey),
                  child: CheckboxListTile(
                    activeColor: appPrimaryColor,
                    title: Text(MBCheckBoxText, style: secondaryTextStyle(size: 14)),
                    dense: true,
                    contentPadding: EdgeInsets.all(0),
                    value: rememberMe,
                    onChanged: (newValue) {
                      setState(() {
                        rememberMe = newValue;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
                16.height,
                AppButton(
                  textStyle: TextStyle(color: Colors.white),
                  textColor: Colors.white,
                  text: "Register",
                  onTap: () {
                    // finish(context);
                    // MBPhoneRegistrationScreen().launch(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MBPhoneRegistrationScreen()),
                    );
                  },
                  color: appPrimaryColor,
                  width: context.width(),
                  shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
                24.height,
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text.rich(
                    TextSpan(
                      text: MBAccountText,
                      style: primaryTextStyle(size: 14),
                      children: <TextSpan>[TextSpan(text: MBTextSignIn, style: secondaryTextStyle(size: 14))],
                    ),
                  ).onTap(() {
                    MBSignInScreen().launch(context);
                  }),
                ),
              ],
            ).paddingOnly(left: 16, right: 16, top: 40, bottom: 16),
          ),
        ),
      ),
    );
  }
}
