import 'package:FirebaseChat/Helpers/time_helper.dart';
import 'package:FirebaseChat/Models/User.dart';
import 'package:FirebaseChat/Models/chatModel.dart';
import 'package:FirebaseChat/Services/database.dart';
import 'package:FirebaseChat/Widgets/Chat/datebreaker.dart';
import 'package:FirebaseChat/Widgets/Chat/recived_message.dart';
import 'package:FirebaseChat/Widgets/Chat/send_message.dart';
import 'package:FirebaseChat/colors.dart';
import 'package:flutter/material.dart';


class ChatPage extends StatefulWidget {
  final int itag;
  final User user;
  final User friend;
  ChatPage({Key key, this.itag, this.user, this.friend})
      : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  DatabaseService _databaseService;
  Color color;
  TextEditingController textEditingController;

  @override
  void initState() {
    color = whiteText;
    textEditingController = TextEditingController();
    _databaseService = DatabaseService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(
            margin: EdgeInsets.only(top: 8, bottom: 8, left: 8),
            child: Hero(
                tag: widget.itag,
                child: Image.asset("assets/${widget.friend.userDp}.png")),
          ),
          title: Text(
            widget.friend.fullName,
            style: TextStyle(color: whiteText),
          ),
        ),
        body: Column(
          
          children: [
            Expanded(
              child: Container(
                color: color,
                child:StreamBuilder(
                stream:
                    DatabaseService().getMessages(widget.user, widget.friend),
                initialData: null,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  print(snapshot);
                  if (snapshot.data == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<MessageModel> messages = snapshot.data;
                  return Container(
                    child: ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (BuildContext context, int index) {
                        return widget.user.id == messages[index].sender.id
                            ? SendMessage(
                                msg: messages[index].message,
                                time: TimeHelper().getMessageTimeOnly(
                                    messages[index].recordedAt),
                              )
                            : RecivedMessage(
                                msg: messages[index].message,
                                time: TimeHelper().getMessageTimeOnly(
                                    messages[index].recordedAt),
                              );
                      },
                    ),
                  );
                },
              ),),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 4, top: 16, left: 16, right: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: TextFormField(
                        controller: textEditingController,
                        cursorColor: primary,
                        decoration: InputDecoration(
                          hintText: "Type a message",
                          prefix: Icon(
                            Icons.send,
                            color: Colors.transparent,
                            size: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              width: 1,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      textEditingController.text="";
                      await _databaseService.sendMessage(widget.user, widget.friend,textEditingController.text);
                      setState(() {
                       color=whiteText; 
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 8),
                      child: Icon(
                        Icons.send,
                        color: whiteText,
                      ),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
