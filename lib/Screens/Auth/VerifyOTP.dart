import 'package:FirebaseChat/Widgets/Auth/otp_field.dart';
import 'package:FirebaseChat/colors.dart';
import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';

class VerifyOTP extends StatefulWidget {
  final Function onPressed;
  VerifyOTP({Key key, this.onPressed}) : super(key: key);

  @override
  _VerifyOTPState createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  TextEditingController otp0 = TextEditingController();
  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();
  TextEditingController otp5 = TextEditingController();

  FocusNode focusNode0 = FocusNode();
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();
  FocusNode focusNode5 = FocusNode();

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
                "Enter One Time Passcode",
                textScaleFactor: 1.4,
                style: TextStyle(color: textColorBold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8, left: 16, right: 16),
              child: Text(
                "We have sent otp to your mobile number +916350407457",
                textScaleFactor: 1.2,
                style: TextStyle(color: textColor),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: 16, left: pDimen.width * 0.125, right: pDimen.width * 0.125),
              child: Row(
                children: [
                  OTPField(
                    controller: otp0,
                    focusNode: focusNode0,
                    onChanged: (String val) {
                      if (val.length == 1) {
                        FocusScope.of(context).requestFocus(focusNode1);
                      }
                    },
                  ),
                  OTPField(
                    controller: otp1,
                    focusNode: focusNode1,
                    onChanged: (String val) {
                      if (val.length == 0) {
                        FocusScope.of(context).requestFocus(focusNode0);
                      } else {
                        FocusScope.of(context).requestFocus(focusNode2);
                      }
                    },
                  ),
                  OTPField(
                    controller: otp2,
                    focusNode: focusNode2,
                    onChanged: (String val) {
                      if (val.length == 0) {
                        FocusScope.of(context).requestFocus(focusNode1);
                      } else {
                        FocusScope.of(context).requestFocus(focusNode3);
                      }
                    },
                  ),
                  OTPField(
                    controller: otp3,
                    focusNode: focusNode3,
                    onChanged: (String val) {
                      if (val.length == 0) {
                        FocusScope.of(context).requestFocus(focusNode2);
                      } else {
                        FocusScope.of(context).requestFocus(focusNode4);
                      }
                    },
                  ),
                  OTPField(
                    controller: otp4,
                    focusNode: focusNode4,
                    onChanged: (String val) {
                      if (val.length == 0) {
                        FocusScope.of(context).requestFocus(focusNode3);
                      } else {
                        FocusScope.of(context).requestFocus(focusNode5);
                      }
                    },
                  ),
                  OTPField(
                    controller: otp5,
                    focusNode: focusNode5,
                    onChanged: (String val) {
                      if (val.length == 0) {
                        FocusScope.of(context).requestFocus(focusNode4);
                      }
                    },
                  ),
                ],
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
                  widget.onPressed(otp0.text.toString()+otp1.text.toString()+otp2.text.toString()+otp3.text.toString()+otp4.text.toString()+otp5.text.toString());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
