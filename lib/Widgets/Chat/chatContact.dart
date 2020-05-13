import 'package:FirebaseChat/Models/User.dart';
import 'package:FirebaseChat/Screens/Chat/chat_page.dart';
import 'package:FirebaseChat/colors.dart';
import 'package:flutter/material.dart';

class ChatContact extends StatelessWidget {
  final int itag;
  final User user, friend;
  final String time, message;
  ChatContact({
    Key key,
    this.time,
    this.message,
    this.itag,
    this.user,
    this.friend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size pDimen = MediaQuery.of(context).size;
    print(friend.tojson());
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatPage(
                      user: user,
                      itag: itag,
                      friend: friend,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Hero(
                tag: itag,
                child: Image.asset("assets/${friend.userDp}.png"),
              ),
              width: pDimen.width * 0.125,
              height: pDimen.width * 0.125,
            ),
            Expanded(
              child: Container(
                height: pDimen.width * 0.125,
                margin: EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        friend.fullName,
                        textScaleFactor: 1.2,
                        style: TextStyle(
                            color: textColorBold, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      child: Text(
                        message,
                        overflow: TextOverflow.ellipsis,
                        textScaleFactor: 0.9,
                        style: TextStyle(color: textColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 4),
              child: Text(
                time,
                textScaleFactor: 0.8,
                style: TextStyle(color: textColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
