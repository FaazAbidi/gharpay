import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:gharpay/screens/MBHelpAndSupportScreen.dart';
import 'package:gharpay/utils/MBImages.dart';
import 'package:gharpay/utils/MBWidgets.dart';
import 'package:gharpay/main.dart';
import 'package:gharpay/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

class MBSettingScreen extends StatefulWidget {
  @override
  MBSettingScreenState createState() => MBSettingScreenState();
}

class MBSettingScreenState extends State<MBSettingScreen> {
  bool isCheck = true;
  bool isCheck1 = true;

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
              25.height,
              Text('App Settings', style: boldTextStyle(size: 26)),
              8.height,
              Container(
                height: 150,
                child: Stack(
                  children: [
                    Container(
                      //height: 100,
                      width: context.width(),
                      color: appPrimaryColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          8.height,
                          Text('Now enjoy exciting features at',
                              style: primaryTextStyle(color: Colors.white)),
                          4.height,
                          Text('JSBank Wallet App',
                              style: boldTextStyle(color: Colors.white)),
                          16.height,
                          Text('Download Now',
                              style: boldTextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.underline))
                        ],
                      ).paddingOnly(left: 16),
                    ).cornerRadiusWithClipRRect(20).paddingOnly(top: 36),
                  ],
                ),
              ),
              25.height,
              Row(
                children: [
                  Icon(Icons.notification_important_sharp,
                      color: appPrimaryColor),
                  8.width,
                  Text('Get Notification', style: primaryTextStyle()).expand(),
                  Switch(
                    activeColor: appPrimaryColor,
                    activeTrackColor: appSecondaryBackgroundColor,
                    inactiveTrackColor: Colors.grey,
                    value: isCheck,
                    onChanged: (val) {
                      isCheck = val;
                      setState(() {});
                    },
                  )
                ],
              ),
              25.height,
              settingRowWidget(
                  name: 'Privacy and Security',
                  icon: Icons.security,
                  icon1: Icons.arrow_forward_ios),
              25.height,
              settingRowWidget(
                  name: 'Account Settings',
                  icon: Icons.settings_sharp,
                  icon1: Icons.arrow_forward_ios),
              25.height,
              settingRowWidget(
                  name: 'Forex Updates',
                  icon: Icons.rate_review,
                  icon1: Icons.arrow_forward_ios),
              25.height,
              settingRowWidget(
                  name: 'Date & Usage',
                  icon: Icons.data_usage,
                  icon1: Icons.arrow_forward_ios),
              25.height,
              settingRowWidget(
                      name: 'Help & Support',
                      icon: Icons.help,
                      icon1: Icons.arrow_forward_ios)
                  .onTap(() {
                MBHelpAndSupportScreen(name: 'Help & Support').launch(context);
              }),
              25.height,
              settingRowWidget(
                  name: 'About Us',
                  icon: Icons.developer_mode_outlined,
                  icon1: Icons.arrow_forward_ios),
              25.height,
              AppButton(
                shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                width: context.width(),
                color: appPrimaryColor,
                elevation: 12,
                onTap: () {},
                child: Text(
                  'Deactivate My Account',
                  style: boldTextStyle(color: Colors.white),
                ),
              )
            ],
          ).paddingAll(16),
        ),
      ),
    );
  }
}
