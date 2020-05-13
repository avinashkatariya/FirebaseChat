import 'package:FirebaseChat/Helpers/authentication.dart';
import 'package:FirebaseChat/Helpers/home.dart';
import 'package:FirebaseChat/Models/User.dart';
import 'package:FirebaseChat/Screens/Chat/Contacts.dart';
import 'package:FirebaseChat/Services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserInstance>(context);
    //final DatabaseService _databaseService = DatabaseService();
    {
      return user == null
          ? Authentication()
          : StreamProvider<User>.value(
              value: DatabaseService().getUserData(user.uid),
              child: Home());
    }
  }
}
