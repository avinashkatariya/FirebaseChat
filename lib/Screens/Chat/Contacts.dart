import 'package:FirebaseChat/Helpers/time_helper.dart';
import 'package:FirebaseChat/Models/User.dart';
import 'package:FirebaseChat/Models/last_message.dart';
import 'package:FirebaseChat/Screens/Auth/add_new_contact.dart';
import 'package:FirebaseChat/Services/auth.dart';
import 'package:FirebaseChat/Widgets/Chat/chatContact.dart';
import 'package:FirebaseChat/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class Contacts extends StatelessWidget {
  final User user;
  Contacts({Key key, this.user}) : super(key: key);

  final AuthService _authService = AuthService();

  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ??
          PermissionStatus.undetermined;
    } else {
      return permission;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<LastMessages> lastMessages = Provider.of<List<LastMessages>>(context);

    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);

    Size pDimen = MediaQuery.of(context).size;

    if (lastMessages == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    print(lastMessages.length);
    return Container(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.message),
          onPressed: () async {
            final PermissionStatus permissionStatus = await _getPermission();
            if (permissionStatus == PermissionStatus.granted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => AddNewContact(user:user),
                ),
              );
            } else {
              //If permissions have been denied show standard cupertino alert dialog
              showDialog(
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                        title: Text('Permissions error'),
                        content: Text('Please enable contacts access '
                            'permission in system settings'),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: Text('OK'),
                            onPressed: () => Navigator.of(context).pop(),
                          )
                        ],
                      ));
            }
          },
          backgroundColor: primary,
        ),
        appBar: AppBar(
          actions: [
            IconButton(
              color: whiteText,
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                _authService.signOut();
              },
            )
          ],
          leading: Container(
            margin: EdgeInsets.only(top: 8, left: 16, bottom: 8),
            child: Image.asset(
              "assets/logo_light.png",
              width: 24,
              height: 24,
            ),
          ),
          title: Text("Firebase Chat", style: TextStyle(color: whiteText)),
        ),
        body: lastMessages.length == 0
            ? Center(
                child: Text("No chat Found"),
              )
            : ListView.builder(
                itemCount: lastMessages.length * 2,
                itemBuilder: (BuildContext context, int index) {
                  int i = (index + 1) ~/ 2;
                  return index % 2 == 0
                      ? ChatContact(
                          user: user,
                          itag: i,
                          friend: lastMessages[i].friend,
                          message: lastMessages[i].message,
                          time: TimeHelper()
                              .getMessageTime(lastMessages[i].recordedAt),
                        )
                      : Container(
                          margin: EdgeInsets.only(
                              left: pDimen.width * 0.1 + 40, right: 16),
                          child: Divider(
                            color: textColor,
                          ),
                        );
                },
              ),
      ),
    );
  }
}
