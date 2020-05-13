import 'package:FirebaseChat/colors.dart';
import 'package:flutter/material.dart';

class OTPField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onChanged;

  OTPField({Key key, this.controller, this.focusNode, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size pDimen = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.only(
            top: 8, left: pDimen.width * 0.0125, right: pDimen.width * 0.0125),
        width: pDimen.width * 0.1,
        height: pDimen.width * 0.1,
        child: TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            counterText: '',
            counterStyle: TextStyle(fontSize: 0),
          ),
          controller: controller,
          textAlign: TextAlign.center,
          focusNode: focusNode,
          maxLength: 1,
          onChanged: onChanged,
          cursorColor: primary,
          style: TextStyle(fontSize: 24),
        ));
  }
}
