import 'package:flutter/material.dart';

class DateBreaker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(top:4,bottom:4,left: 16,right: 16),
          margin: EdgeInsets.only(top:16,),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            boxShadow: [
              BoxShadow(
                color: Colors.grey[500],
                offset: Offset(0.0, 1.5),
                blurRadius: 1.5,
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(16))
          ),
          child: Text("Today"),
        ),
      ],
    );
  }
}
