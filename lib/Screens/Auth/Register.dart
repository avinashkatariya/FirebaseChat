import 'dart:async';
import 'package:FirebaseChat/Services/auth.dart';
import 'package:FirebaseChat/colors.dart';
import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';

class Register extends StatefulWidget {
  final Function onPressed;
  Register({Key key, this.onPressed}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String phoneNumber;
  String phoneIsoCode = "IN";

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      phoneNumber = number;
      phoneIsoCode = isoCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size pDimen = MediaQuery.of(context).size;

    return Container(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: pDimen.height * 0.05,
                  left: pDimen.width * 0.4,
                  right: pDimen.width * 0.4),
              child: Image.asset("assets/logo.png",
                  width: pDimen.width * 0.2, height: pDimen.width * 0.2),
            ),
            Container(
              margin: EdgeInsets.only(top: 16, left: 16),
              child: Text(
                "Enter your phone number",
                textScaleFactor: 1.4,
                style: TextStyle(color: textColorBold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8, left: 16, right: 16),
              child: Text(
                "In order to use Firebase Chat chat verify your mobile number",
                textScaleFactor: 1.2,
                style: TextStyle(color: textColor),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8, left: 16, right: 16),
              child: InternationalPhoneInput(
                onPhoneNumberChange: onPhoneNumberChange,
                initialPhoneNumber: phoneNumber,
                initialSelection: phoneIsoCode,
                labelText: "Phone Number",
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Container(
              width: pDimen.width * 0.4,
              margin: EdgeInsets.only(
                  left: pDimen.width * 0.3,
                  right: pDimen.width * 0.3,
                  bottom: pDimen.height * 0.1),
              child: RaisedButton(
                textColor: whiteText,
                color: primary,
                child: Text(
                  "NEXT",
                ),
                onPressed: () {
                  widget.onPressed(phoneNumber);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
