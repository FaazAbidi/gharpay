import 'package:flutter/material.dart';
import 'package:gharpay/screens/MBCardScreen.dart';
import 'package:gharpay/screens/MBHomeScreen.dart';
import 'package:gharpay/screens/MBProfileScreen.dart';
import 'package:gharpay/screens/MBSettingScreen.dart';
import 'package:gharpay/utils/MBColors.dart';
import 'package:gharpay/utils/MBConts.dart';
import 'package:gharpay/main.dart';
import 'package:gharpay/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

class MBDashBoardScreen extends StatefulWidget {
  @override
  MBDashBoardScreenState createState() => MBDashBoardScreenState();
}

class MBDashBoardScreenState extends State<MBDashBoardScreen> {
  int _selectedIndex = 0;

  var _pages = <Widget>[
    MBHomeScreen(),
    MBCardScreen(),
    MBSettingScreen(),
    MBProfileScreen(),
  ];

  Widget _bottomTab() {
    return Container(
      margin: EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          backgroundColor: appStore.cardColor,
          onTap: _onItemTapped,
          showSelectedLabels: false,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(color: Colors.black),
          showUnselectedLabels: false,
          fixedColor: appPrimaryColor,
          unselectedLabelStyle: TextStyle(color: MBBottomTabUnselectedColor),
          unselectedItemColor: MBBottomTabUnselectedColor,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: AnimatedContainer(
                duration: Duration(milliseconds: 800),
                margin: EdgeInsets.only(left: 12),
                padding: EdgeInsets.all(8),
                child: Icon(Icons.home, color: appPrimaryColor),
              ),
              label: MBTab1Text,
              activeIcon: AnimatedContainer(
                decoration: boxDecorationWithRoundedCorners(backgroundColor: Colors.white),
                duration: Duration(milliseconds: 800),
                margin: EdgeInsets.only(left: 12),
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Icon(Icons.home, color: Colors.black, size: 20),
                    Text(MBTab1Text, style: boldTextStyle(color: Colors.black, size: 11)).center().expand(),
                  ],
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: AnimatedContainer(
                duration: Duration(milliseconds: 800),
                margin: EdgeInsets.only(left: 12),
                padding: EdgeInsets.all(8),
                child: Icon(Icons.credit_card_outlined, color: appPrimaryColor),
              ),
              label: MBTab2Text,
              activeIcon: AnimatedContainer(
                decoration: boxDecorationWithRoundedCorners(backgroundColor: Colors.white),
                duration: Duration(milliseconds: 800),
                margin: EdgeInsets.only(left: 12),
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Icon(Icons.credit_card_outlined, color: Colors.black, size: 20),
                    Text(MBTab2Text, style: boldTextStyle(color: Colors.black, size: 11)).center().expand(),
                  ],
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: AnimatedContainer(
                duration: Duration(milliseconds: 800),
                margin: EdgeInsets.only(left: 12),
                padding: EdgeInsets.all(8),
                child: Icon(Icons.settings, color: appPrimaryColor),
              ),
              label: MBTab3Text,
              activeIcon: AnimatedContainer(
                decoration: boxDecorationWithRoundedCorners(backgroundColor: Colors.white),
                duration: Duration(milliseconds: 800),
                margin: EdgeInsets.only(left: 12),
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Icon(Icons.settings, color: Colors.black, size: 20),
                    Text(MBTab3Text, style: boldTextStyle(color: Colors.black, size: 11)).center().expand(),
                  ],
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: appPrimaryColor),
              label: MBTab2Text,
              activeIcon: AnimatedContainer(
                decoration: boxDecorationWithRoundedCorners(backgroundColor: Colors.white),
                duration: Duration(milliseconds: 800),
                margin: EdgeInsets.only(right: 12),
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Icon(Icons.person, color: Colors.black, size: 20),
                    Text(MBTab4Text, style: boldTextStyle(color: Colors.black, size: 11)).center().expand(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomTab(),
      body: Center(child: _pages.elementAt(_selectedIndex)),
    );
  }
}
