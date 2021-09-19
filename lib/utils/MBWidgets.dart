import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gharpay/models/MBModel.dart';
import 'package:gharpay/utils/MBImages.dart';
import 'package:gharpay/main.dart';
import 'package:gharpay/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

import '../backendApiSimulation.dart';
// import 'MBSignInScreen.dart';

Widget textFieldWidget({
  String hintText,
  TextEditingController controller,
  TextFieldType textFieldType,
  int length,
  Widget icon,
  FocusNode nextFocusNode,
  FocusNode focusNode,
}) {
  return AppTextField(
    suffix: icon,
    controller: controller,
    nextFocus: nextFocusNode,
    focus: focusNode,
    autoFocus: false,
    textFieldType: textFieldType,
    maxLength: length,
    cursorColor: appPrimaryColor,
    decoration: InputDecoration(
      filled: true,
      counterText: '',
      fillColor: gray.withOpacity(0.1),
      hintText: hintText,
      hintStyle: secondaryTextStyle(color: gray, size: 16),
      alignLabelWithHint: true,
      contentPadding: EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 8),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimaryColor.withOpacity(0.2)), borderRadius: BorderRadius.circular(8)),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(8)),
    ),
  );
}

Widget mastercardWidget({
  double width,
  String cardNum,
  String name,
  DateTime exp,
}) {
  return Container(
    width: width,
    color: appPrimaryColor,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.height,
        Text(
            User.instance.cards[0].company == Company.MasterCard
                ? "MasterCard"
                : "VisaCard",
            style: primaryTextStyle(color: Colors.white, size: 18)),
        16.height,
        Image.network(
          'https://image.shutterstock.com/image-vector/plastic-card-chip-electronic-device-260nw-777888688.jpg',
          height: 50,
          fit: BoxFit.cover,
        ),
        16.height,
        Text(cardNum, style: primaryTextStyle(color: Colors.white, size: 18)),
        18.height,
        Row(
          children: [
            Text(name, style: primaryTextStyle(color: Colors.white)),
            Column(
              children: [
                Text('Valid TO',
                    style: primaryTextStyle(color: Colors.white, size: 12)),
                Text('${exp.month}/${exp.year}',
                    style: primaryTextStyle(color: Colors.white, size: 14)),
              ],
            ).expand(),
            Image.asset(
                    User.instance.cards[0].company == Company.MasterCard
                        ? mb_master_logo
                        : mb_visaCard_logo,
                    height: 50,
                    fit: BoxFit.contain)
                .paddingRight(8)
          ],
        )
      ],
    ).paddingLeft(16),
  ).cornerRadiusWithClipRRect(20);
}

Widget visaCardWidget({
  double width,
  String cardNum,
  String name,
  DateTime exp,
}) {
  return Container(
    width: width,
    color: appPrimaryColor,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.height,
        Text('VISACard',
            style: primaryTextStyle(color: Colors.white, size: 18)),
        16.height,
        Image.network(
          'https://image.shutterstock.com/image-vector/plastic-card-chip-electronic-device-260nw-777888688.jpg',
          height: 50,
          fit: BoxFit.cover,
        ),
        16.height,
        Text(cardNum, style: primaryTextStyle(color: Colors.white, size: 18)),
        18.height,
        Row(
          children: [
            Text(name, style: primaryTextStyle(color: Colors.white)),
            Column(
              children: [
                Text('Valid TO',
                    style: primaryTextStyle(color: Colors.white, size: 12)),
                Text('${exp.month}/${exp.year}',
                    style: primaryTextStyle(color: Colors.white, size: 14)),
              ],
            ).expand(),
            Image.asset(mb_visaCard_logo, height: 50, fit: BoxFit.contain)
                .paddingRight(8)
          ],
        )
      ],
    ).paddingLeft(16),
  ).cornerRadiusWithClipRRect(20);
}

Widget editTextWidget({
  String hintText,
  IconData icon,
  Color color,
  TextInputType keyboardType,
  Color iconColor,
  FocusNode nextFocusNode,
  FocusNode focusNode,
}) {
  return TextFormField(
    keyboardType: keyboardType,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      hintText: hintText,
      suffixIcon: Icon(icon, color: iconColor, size: 22),
      hintStyle: TextStyle(color: gray),
      filled: true,
      fillColor: color,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(8)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8)),
    ),
  );
}

class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget({
    Key key,
    @required this.isMe,
    @required this.data,
  }) : super(key: key);

  final bool isMe;
  final BHMessageModel data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          isMe.validate() ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          margin: isMe.validate()
              ? EdgeInsets.only(
                  top: 3.0,
                  bottom: 3.0,
                  right: 0,
                  left: (500 * 0.25).toDouble())
              : EdgeInsets.only(
                  top: 4.0,
                  bottom: 4.0,
                  left: 0,
                  right: (500 * 0.25).toDouble(),
                ),
          decoration: BoxDecoration(
            color: !isMe ? appPrimaryColor.withOpacity(0.85) : white,
            boxShadow: defaultBoxShadow(),
            borderRadius: isMe.validate()
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))
                : BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10)),
            border: Border.all(
                color:
                    isMe ? Theme.of(context).dividerColor : Colors.transparent),
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                  child: Text(data.msg,
                      style: primaryTextStyle(
                          color: !isMe ? white : textPrimaryColor))),
              Text(data.time,
                  style: secondaryTextStyle(
                      color: !isMe ? white : textSecondaryColor, size: 12))
            ],
          ),
        ),
      ],
    );
  }
}

Widget budgetCardWidget(
    {String bugTitle,
    String amount,
    String percentage,
    String amount1,
    Color color,
    double width}) {
  return Container(
    decoration: boxDecorationWithRoundedCorners(
        boxShadow: defaultBoxShadow(), backgroundColor: appStore.cardColor),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.height,
        Text(bugTitle, style: primaryTextStyle()),
        8.height,
        Row(
          children: [
            Text(amount.toString(), style: boldTextStyle(size: 22)),
            16.width,
            Text(percentage.toString(), style: secondaryTextStyle()).expand(),
            Text(amount1.toString(), style: secondaryTextStyle())
                .paddingOnly(right: 16),
          ],
        ),
        16.height,
        Container(
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(16)),
          width: width,
          height: 8.0,
          alignment: Alignment.topLeft,
          child: Container(color: color, width: 170.0, height: 50.0)
              .cornerRadiusWithClipRRect(15),
        ),
        16.height,
      ],
    ).paddingOnly(left: 16),
  );
}

Widget settingRowWidget({String name, IconData icon, IconData icon1}) {
  return Row(
    children: [
      Icon(icon, color: appPrimaryColor),
      8.width,
      Text(name, style: primaryTextStyle()).expand(),
      Icon(icon1, color: Colors.grey, size: 18).paddingOnly(right: 8),
    ],
  );
}

getField(String heading, String value) {
  return value != null
      ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(heading, style: boldTextStyle(size: 18)).paddingOnly(left: 16),
            Text(value, style: TextStyle(fontSize: 13)).paddingOnly(left: 16),
            10.height,
            Divider(),
          ],
        )
      : Container();
}
