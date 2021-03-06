import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gharpay/backendApiSimulation.dart';
import 'package:gharpay/screens/MBDashBoardScreen.dart';
import 'package:gharpay/utils/MBConts.dart';
import 'package:gharpay/main.dart';
import 'package:gharpay/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class MBVerifyAccountScreen extends StatefulWidget {
  String phone;
  String email;

  MBVerifyAccountScreen({@required this.email, @required this.phone});

  @override
  MBVerifyAccountScreenState createState() => MBVerifyAccountScreenState();
}

class MBVerifyAccountScreenState extends State<MBVerifyAccountScreen> {
  int _counter = 60;
  Timer _timer;
  var onTapRecognizer;
  String currentText = "";
  bool loading = false;
  TextEditingController textEditingController = TextEditingController();

  // ignore: close_sinks
  StreamController<ErrorAnimationType> errorController;

  void _startTimer() {
    _counter = 60;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (_timer) {
        setState(() {
          if (_counter > 0) {
            _counter--;
          } else {
            _timer.cancel();
          }
        });
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
    init();
  }

  init() async {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        finish(context);
      };
    errorController = StreamController<ErrorAnimationType>();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: AppButton(
          text: loading ? "Authenticating" : MBBtnContinue,
          textColor: Colors.white,
          elevation: 12.0,
          onTap: () async {
            // finish(context);
            // MBDashBoardScreen().launch(context);

            try {
              setState(() {
                loading = true;
              });
              await NetworkProvider.login(
                  "${widget.email}", "1234");
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => MBDashBoardScreen()),
                  (Route<dynamic> route) => false);
            } catch (e) {
              setState(() {
                loading = true;
              });
              loading = false;
              print(e);
            }
          },
          color: appPrimaryColor,
          width: context.width(),
          shapeBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
        ).paddingAll(24),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(MBVerifyTitleText, style: boldTextStyle(size: 26)),
              24.height,
              Text(MBVerifySubTitleText, style: secondaryTextStyle(size: 16)),
              8.height,
              Text(widget.phone,
                  style: secondaryTextStyle(
                      size: 16,
                      color: appPrimaryColor,
                      decoration: TextDecoration.underline)),
              44.height,
              PinCodeTextField(
                appContext: context,
                pastedTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
                length: 4,
                showCursor: false,
                animationType: AnimationType.fade,
                errorTextSpace: 30,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(7),
                  fieldHeight: 50,
                  fieldWidth: 50,
                  activeFillColor: Colors.transparent,
                  inactiveFillColor: Colors.transparent,
                  inactiveColor: appPrimaryColor,
                  activeColor: appPrimaryColor,
                  selectedFillColor: Colors.transparent,
                  selectedColor: appPrimaryColor,
                ),
                animationDuration: Duration(milliseconds: 300),
                textStyle: TextStyle(fontSize: 20, height: 1.6),
                backgroundColor: Colors.transparent,
                enableActiveFill: true,
                errorAnimationController: errorController,
                controller: textEditingController,
                keyboardType: TextInputType.number,
                onCompleted: (v) {},
                onChanged: (value) {
                  setState(() {
                    currentText = value;
                  });
                },
                beforeTextPaste: (text) {
                  return true;
                },
              ),
              34.height,
              Text.rich(
                TextSpan(
                  text:
                      "This season will end in  $_counter seconds.\nDid't get code? ",
                  style: secondaryTextStyle(size: 16),
                  children: <TextSpan>[
                    TextSpan(
                        text: "Resend Code",
                        style: boldTextStyle(
                            color: appPrimaryColor,
                            size: 16,
                            decoration: TextDecoration.underline)),
                  ],
                ),
              ).onTap(() {
                _startTimer();
              }),
              SizedBox(height: context.height() * 0.2),
              if (loading)
                Center(
                  child: SpinKitDoubleBounce(
                    color: appPrimaryColor,
                    size: 50.0,
                  ),
                )
            ],
          ).paddingOnly(right: 16, left: 16, bottom: 44, top: 44),
        ),
      ),
    );
  }
}
