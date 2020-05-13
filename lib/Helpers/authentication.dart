import 'dart:async';

import 'package:FirebaseChat/Screens/Auth/Register.dart';
import 'package:FirebaseChat/Screens/Auth/VerifyOTP.dart';
import 'package:FirebaseChat/Services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Authentication extends StatefulWidget {
  Authentication({Key key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  Widget child;
  RegisterMobile registerMobile = RegisterMobile();
  StreamSubscription registerStreamSubscription;
  Stream registerStream;

  @override
  void initState() {
    child = Scaffold(body: Center(child: CircularProgressIndicator(),));
    registerStream = registerMobile.stream;
    registerStreamSubscription = registerStream.listen((val) {
      if(val["status_code"] > 0){
        setState(() {
          child = VerifyOTP(onPressed: registerMobile.signInWithPhoneNumber,);
        });
      }
      else{
        setState(() {
          child = Register(onPressed: registerMobile.signInWithMobile,);
        });
      }
    });
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }

  @override
  void dispose() {
    registerStreamSubscription.cancel();
    super.dispose();
  }
}
