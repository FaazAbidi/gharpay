import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gharpay/screens/MBDashBoardScreen.dart';
import 'package:gharpay/screens/MBSignInScreen.dart';
import 'package:gharpay/screens/MBSignUpScreen.dart';
import 'package:gharpay/utils/MBImages.dart';
import 'package:gharpay/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

class MBWalkThroughScreen extends StatefulWidget {
  @override
  MBWalkThroughScreenState createState() => MBWalkThroughScreenState();
}

class MBWalkThroughScreenState extends State<MBWalkThroughScreen> with AfterLayoutMixin<MBWalkThroughScreen> {
  PageController pageController = PageController();

  List<Widget> pages = [];
  double currentPage = 0;

  final _kDuration = Duration(milliseconds: 300);
  final _kCurve = Curves.ease;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page;
      });
    });
    init();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    pages = [
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset("vectors/security.svg", height: 200, fit: BoxFit.cover).paddingOnly(top: 40),
          32.height,
          Text('Safe & Secure', style: boldTextStyle(size: 24)),
          16.height,
          Text(
            'Our new encrypted process and \n security procedures makes it more \n secure between you and your banks',
            textAlign: TextAlign.center,
            style: secondaryTextStyle(size: 16),
          ),
        ],
      ).paddingOnly(top: 60),
      Column(
        children: [
          SvgPicture.asset("vectors/remotePayments.svg", height: 200, fit: BoxFit.cover).paddingOnly(top: 40),
          32.height,
          Text('Card Payments', style: boldTextStyle(size: 24)),
          16.height,
          Text(
            'Send money to HFA accounts \n with easy credit/debit card transaction. \n Simple like never before',
            textAlign: TextAlign.center,
            style: secondaryTextStyle(size: 16),
          ),
        ],
      ).paddingOnly(top: 60),
      Column(
        children: [
          SvgPicture.asset("vectors/anywhere.svg", height: 200, fit: BoxFit.cover).paddingOnly(top: 40),
          32.height,
          Text('Anywhere Anytime', style: boldTextStyle(size: 24)),
          16.height,
          Text('Don\'t Worry about long distances. \n Your loved ones will always be near. \n Make payments from anywhere anytime.', textAlign: TextAlign.center, style: secondaryTextStyle(size: 16)),
        ],
      ).paddingOnly(top: 60),
      Column(
        children: [
          SvgPicture.asset("vectors/launch.svg", height: 200, fit: BoxFit.cover).paddingOnly(top: 40),
          32.height,
          Text('Launching Now', style: boldTextStyle(size: 24)),
          16.height,
          Text(
            'The wait is over. \n Sign up or login to experience \n future of easy and fast international \n payments.',
            textAlign: TextAlign.center,
            style: secondaryTextStyle(size: 16),
          ),
        ],
      ).paddingOnly(top: 60),
    ];
    setState(() {});
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
      child: Scaffold(
        body: Stack(
          children: [
            PageView(controller: pageController, children: pages.map((e) => e).toList()),
            Positioned(
              bottom: 32,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  AppButton(
                    shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    elevation: 12,
                    onTap: () {
                      pageController.nextPage(duration: _kDuration, curve: _kCurve);
                      if (currentPage == 3) {
                        finish(context);
                        MBSignUpScreen().launch(context);
                      }
                    },
                    width: context.width(),
                    child: Text(currentPage == 3 ? 'Let\'s create an account' : 'Next', style: boldTextStyle(color: Colors.white)),
                    color: appPrimaryColor,
                  ).paddingSymmetric(horizontal: 16),
                  8.height,
                  Text(currentPage == 3 ? 'Already have an account ? Sign In' : 'Skip', style: secondaryTextStyle()).paddingAll(8).onTap(() {
                    if (currentPage == 3) {
                      MBSignInScreen().launch(context);
                    } else {
                      finish(context);
                      MBSignInScreen().launch(context);
                    }
                  }),
                  16.height,
                  DotIndicator(pageController: pageController, pages: pages, indicatorColor: appPrimaryColor, unselectedIndicatorColor: grey),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
