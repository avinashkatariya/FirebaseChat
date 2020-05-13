import 'package:FirebaseChat/Helpers/jsonhelper.dart';
import 'package:FirebaseChat/Models/User.dart';
import 'package:FirebaseChat/Screens/Chat/chat_page.dart';
import 'package:FirebaseChat/colors.dart';
import 'package:flutter/material.dart';

class AddContactTile0 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size pDimen = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Icon(
              Icons.add_circle,
              size: pDimen.width * 0.125,
              color: primary,
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
                      "Add new contact",
                      textScaleFactor: 1.2,
                      style: TextStyle(
                          color: textColorBold, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddContactTile extends StatelessWidget {
  final User user, me;
  final int itag;
  AddContactTile({Key key, this.user, this.me, this.itag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size pDimen = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        print(user.tojson());
        print(me.tojson());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ChatPage(
              friend: user,
              user: me,
              itag: itag,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Hero(
                  tag: itag, child: Image.asset("assets/${user.userDp}.png")),
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
                        user.fullName,
                        textScaleFactor: 1.2,
                        style: TextStyle(
                            color: textColorBold, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      child: Text(
                        user.mobileNumber,
                        overflow: TextOverflow.ellipsis,
                        textScaleFactor: 0.9,
                        style: TextStyle(color: textColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
