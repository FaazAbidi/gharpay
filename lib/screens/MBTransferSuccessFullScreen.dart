import 'package:flutter/material.dart';
import 'package:gharpay/screens/MBDashBoardScreen.dart';
import 'package:gharpay/utils/MBConts.dart';
import 'package:gharpay/utils/MBImages.dart';
import 'package:gharpay/main.dart';
import 'package:gharpay/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

class MBTransferSuccessFullScreen extends StatefulWidget {
  @override
  MBTransferSuccessFullScreenState createState() => MBTransferSuccessFullScreenState();
}

class MBTransferSuccessFullScreenState extends State<MBTransferSuccessFullScreen> {
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
      backgroundColor: appPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.asset(mb_successfully1, width: 220, height: 220, color: white),
                24.height,
                Text(MBTextTransferSuccessfulTitle, style: boldTextStyle(size: 26, color: white), textAlign: TextAlign.center),
                24.height,
                Text(MBTextTransferSuccessfulSubTitle, style: primaryTextStyle(size: 16, color: white), textAlign: TextAlign.center),
              ],
            ),
            44.height,
            Column(
              children: [
                AppButton(
                  child: Text(MBBtnViewDetail, style: boldTextStyle(color: appPrimaryColor, size: 14)),
                  onTap: () {},
                  color: white,
                  width: context.width(),
                  shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
                8.height,
                AppButton(
                  child: Text(MBBtnContinue, style: boldTextStyle(color: appPrimaryColor, size: 14)),
                  onTap: () {
                    MBDashBoardScreen().launch(context);
                  },
                  color: white,
                  width: context.width(),
                  shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
              ],
            ),
          ],
        ).paddingAll(32),
      ),
    );
  }
}
