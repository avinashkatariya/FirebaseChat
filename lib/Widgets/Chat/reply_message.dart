import 'package:FirebaseChat/colors.dart';
import 'package:flutter/material.dart';

class ReplyMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 8, left: 16, bottom: 8),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                height: 80,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(4),
                      
                      height: 40,
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(),
              flex: 1,
            ),
          ],
        ));
  }
}
