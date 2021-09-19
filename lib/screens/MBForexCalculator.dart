import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:nb_utils/nb_utils.dart';

class MBForexCalculator extends StatefulWidget {
  @override
  _MBForexCalculatorState createState() => _MBForexCalculatorState();
}

class _MBForexCalculatorState extends State<MBForexCalculator> {
  String currencySelected = 'USD';
  String returnCurrency = 'PKR';
  double exchangeRate;
  String unitAmount = '1';

  List<DropdownMenuItem<String>> currencies = [
    DropdownMenuItem(
      child: Text("USD"),
      value: "USD",
    ),
    DropdownMenuItem(
      child: Text("CAD"),
      value: "CAD",
    ),
    DropdownMenuItem(
      child: Text("INR"),
      value: "INR",
    ),
    DropdownMenuItem(
      child: Text("AED"),
      value: "AED",
    ),
    DropdownMenuItem(
      child: Text("AUS"),
      value: "AUS",
    )
  ];

  Future getCurrencyData() async {
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
    return exchangeRate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    unitAmount = value;
                  });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter Amount",
                  prefixIcon: Icon(Icons.attach_money_rounded),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            DropdownButton(
              icon: Icon(Icons.money_rounded),
              items: currencies,
              value: currencySelected,
              onChanged: (value) {
                setState(() {
                  currencySelected = value;
                });
              },
            ),
            AppButton(
              elevation: 5,
              text: "here",
              onTap: () async {
                exchangeRate = await getCurrencyData();
                print(exchangeRate);
                print((exchangeRate * double.parse(unitAmount))
                    .toStringAsFixed(2));
              },
            )
          ],
        ),
      ),
    );
  }
}
