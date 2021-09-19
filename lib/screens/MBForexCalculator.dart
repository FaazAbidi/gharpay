import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gharpay/utils/AppColors.dart';
import 'package:gharpay/utils/MBWidgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:nb_utils/nb_utils.dart';

import '../backendApiSimulation.dart';
import 'MBTransferSuccessFullScreen.dart';

class MBForexCalculator extends StatefulWidget {
  Payee payee;

  MBForexCalculator({@required this.payee});

  @override
  _MBForexCalculatorState createState() => _MBForexCalculatorState();
}

class _MBForexCalculatorState extends State<MBForexCalculator> {
  String currencySelected = 'USD';
  String returnCurrency = 'PKR';
  double exchangeRate;
  String unitAmount = '1';

  TextEditingController amountController = TextEditingController();

  List<DropdownMenuItem<String>> currencies = [
    DropdownMenuItem(
      child: Text("USD", style: TextStyle(color: appPrimaryColor),),
      value: "USD",
    ),
    DropdownMenuItem(
      child: Text("CAD" ,style: TextStyle(color: appPrimaryColor)),
      value: "CAD",
    ),
    DropdownMenuItem(
      child: Text("INR",style: TextStyle(color: appPrimaryColor)),
      value: "INR",
    ),
    DropdownMenuItem(
      child: Text("AED",style: TextStyle(color: appPrimaryColor)),
      value: "AED",
    ),
    DropdownMenuItem(
      child: Text("AUD",style: TextStyle(color: appPrimaryColor)),
      value: "AUD",
    )
  ];

  Future<String> getCurrencyData() async {
    // print("here");
    var requestURL = Uri.parse(
        "https://free.currconv.com/api/v7/convert?q=${currencySelected}_$returnCurrency&compact=ultra&apiKey=216db588bc2bdefff0cb");
    http.Response response = await http.get(requestURL);
    print(requestURL);
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      // print(decodedData);
      exchangeRate = decodedData['${currencySelected}_$returnCurrency'];
    } else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }
    return exchangeRate.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 24.0, left: 24.0),
                child: Text("Transfering Money to \n ${widget.payee.name}",style:TextStyle(fontSize:26, color: Colors.black, fontWeight: FontWeight.w700)),
              ),
              16.height,
              Center(child: SvgPicture.asset("vectors/transaction.svg", height: 200, fit: BoxFit.cover).paddingOnly(top: 40)),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: textFieldWidget(
                  hintText: "Enter Transfer Amount",
                  textFieldType: TextFieldType.PHONE,
                  icon: Icon(Icons.monetization_on_outlined, color: appPrimaryColor)
                ),
              ),
              16.height,
              Center(child: Text("Choose your currency")),
              8.height,
              Center(
                child: Container(
                  width: context.width() * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                      boxShadow: defaultBoxShadow(spreadRadius: 2.0, blurRadius: 1.0),
                    color: Colors.white
                  ),
                  child: Center(
                    child: DropdownButton(
                      // icon: Icon(Icons.money_rounded),
                      // borderRadius: BorderRadius.circular(15),
                      hint:Text(
                        "Please choose a currency",
                        style: TextStyle(
                            color: appPrimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      items: currencies,
                      value: currencySelected,
                      onChanged: (value) {
                        setState(() {
                          currencySelected = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
              16.height,
              FutureBuilder<String>(
                future: getCurrencyData(),
                initialData: "fetching rate",
                builder: (context, snapshot) {
                    return Center(child: Column(
                      children: [
                        Text("1 ${currencySelected} ≈ ${snapshot.data} ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
                      ],
                    ));
                }
              ),
              26.height,
              Center(
                child: AppButton(
                  width: context.width() * 0.8,
                  color: appPrimaryColor,
                  textColor: Colors.white,
                  elevation: 5,
                  textStyle: TextStyle(color: Colors.white),
                  text: "Confirm Transaction",
                  onTap: () async {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MBTransferSuccessFullScreen()));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
