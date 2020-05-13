import 'dart:math';

import 'package:FirebaseChat/Models/User.dart';
import 'package:FirebaseChat/Screens/Chat/Contacts.dart';
import 'package:FirebaseChat/Services/database.dart';
import 'package:FirebaseChat/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddUserData extends StatelessWidget {
  final int ano = Random().nextInt(35) + 1;
  
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController textEditingController1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserInstance>(context);
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    Size pDimen = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profile Details",style: TextStyle(color: whiteText),),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: 32,
                      left: pDimen.width * 0.3,
                      right: pDimen.width * 0.3),
                  child: Image.asset("assets/" + ano.toString() + ".png",
                      width: pDimen.width * 0.4, height: pDimen.width * 0.4),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 16, right: 16, top: 8,bottom: 16),
                        child: TextFormField(
                          controller: textEditingController,
                         
                          decoration: InputDecoration(labelText: "First Name"),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 16, top: 8,bottom: 16),
                        child: TextFormField(
                          controller: textEditingController1,
                          
                          decoration: InputDecoration(labelText: "Last Name",),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: pDimen.width * 0.35, right: pDimen.width * 0.35,bottom: 16),
            width: pDimen.width * 0.3,
            child: RaisedButton(
              color: primary,
              textColor: whiteText,
              child: Text("Next"),
              onPressed: () async{
                bool sucess = await DatabaseService().setUserData(user.uid,user.providerId, ano,textEditingController.text, textEditingController1.text);
                if(sucess == true){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>Contacts()));
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
