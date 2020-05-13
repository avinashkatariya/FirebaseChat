import 'package:FirebaseChat/Models/User.dart';
import 'package:FirebaseChat/Models/last_message.dart';
import 'package:FirebaseChat/Screens/Auth/add_user_data.dart';
import 'package:FirebaseChat/Screens/Chat/Contacts.dart';
import 'package:FirebaseChat/Services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<User>(context);
    final user = Provider.of<UserInstance>(context);

    return userData == null
        ? AddUserData()
        : StreamProvider<List<LastMessages>>.value(
            value: DatabaseService().getContacts(user.uid),
            child: Contacts(user: userData,),
          );
  }
}
