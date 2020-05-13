import 'dart:async';
import 'dart:core';

import 'package:FirebaseChat/Models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterMobile {
  String _mobileNumber;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final StreamController _streamController =
      StreamController<Map<String, dynamic>>();

  final Map<String, dynamic> _map = {
    "status_code": -1,
  };

  RegisterMobile() {
    _streamController.sink.add(_map);
  }

  String _verificationId;

  Future<void> signOut() async {
    await _auth.signOut();
  }

  UserInstance _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? UserInstance(user.phoneNumber, uid: user.uid) : null;
  }

  Stream<Map<String, dynamic>> get stream => _streamController.stream;

  signInWithPhoneNumber(String smsCode) {
    print(_verificationId);
    print(smsCode);
    AuthCredential _authCredential = PhoneAuthProvider.getCredential(
        verificationId: _verificationId, smsCode: smsCode);
    _auth.signInWithCredential(_authCredential).then((AuthResult value) {
      print("Authenticating.....");
      if (value.user != null) {
        _streamController.sink.add({
          "status_code": 4,
          "user": _userFromFirebaseUser(value.user),
          "message": "Signup Successfull",
        });
      } else {
        _streamController.sink.add({
          "status_code": 3,
          "user": null,
          "message": "Invalid code/invalid authentication",
        });
      }
    }).catchError((error) {
      _streamController.sink.add({
        "status_code": 3,
        "user": null,
        "message": "Something has gone wrong, please try later",
      });
    });
  }

  signInWithMobile(String mobileNumber) {
    _mobileNumber = "+91" + mobileNumber;
    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      print(verificationId);
      print("Code is sent to Mobile Number:" + mobileNumber);
      _verificationId = verificationId;
      _streamController.sink.add({
        "status_code": 1,
        "user": null,
        "message": "Code is sent to Mobile Number:" + mobileNumber,
      });
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;

      print("Code reterival Timeout");
      _streamController.sink.add({
        "status_code": 2,
        "user": null,
        "message": "Code reterival Timeout",
      });
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      print("Error message: " + authException.message);
      _streamController.sink.add({
        "status_code": 3,
        "user": null,
        "message": "Error message: " + authException.message,
      });
    };

    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential authCredential) {
      _auth.signInWithCredential(authCredential).then((AuthResult value) {
        if (value.user != null) {
          Firestore.instance
              .collection("userData")
              .document(value.user.uid)
              .setData({"mobile": value.user.phoneNumber});

          _streamController.sink.add({
            "status_code": 4,
            "user": _userFromFirebaseUser(value.user),
            "message": "Signup Successfull",
          });
        } else {
          _streamController.sink.add({
            "status_code": 3,
            "user": null,
            "message": "Invalid code/invalid authentication",
          });
        }
      }).catchError((error) {
        _streamController.sink.add({
          "status_code": 3,
          "user": null,
          "message": "Something has gone wrong, please try later",
        });
      });
    };

    _auth.verifyPhoneNumber(
      phoneNumber: "+91" + mobileNumber,
      timeout: Duration(seconds: 5),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserInstance _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? UserInstance(user.phoneNumber, uid: user.uid) : null;
  }

  Stream<UserInstance> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
