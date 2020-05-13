import 'package:FirebaseChat/colors.dart';
import "package:flutter/material.dart";

class RecivedMessage extends StatefulWidget{
  final msg, time;
  RecivedMessage({this.msg, this.time});
  @override
  State<StatefulWidget> createState() {
    return _RecivedMessageState();
  }
}

class _RecivedMessageState extends State<RecivedMessage> {

  GlobalKey msgkey =GlobalKey();
  GlobalKey msgkey0 = GlobalKey();
  double _width0=0;
  String str =
      "Hello There. I registered a Complaint about my AC yesterday when you are going to fix it";
  String msg,time;
  double _margintop = 4;
  double _marginright=0;
  @override
  void initState() {
    msg = widget.msg;
    time = widget.time;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
        final keycontext = msgkey.currentContext;
        if(keycontext!=null){
          RenderBox box = keycontext.findRenderObject();
          setState(() {
            _margintop = box.size.height - 42;
          });
        }

        final keycontext0 = msgkey0.currentContext;
        if(keycontext0!=null){
          RenderBox box0 = keycontext0.findRenderObject();
          setState(() {
            _width0 = msg.length > 40 ? box0.size.width+35 :box0.size.width+40;
            
          });
          
        }

    });

  }
  //String str =
    //  "Hello. sorry for inconvenience. We will try to resolve your issue within next 5 hours";
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Text(""),
        ),
        Expanded(
          flex: 8,
          child: Wrap(
            key: msgkey,
            alignment: WrapAlignment.end,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 16, left: 16, right: 16),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[500],
                        offset: Offset(0.0, 1.5),
                        blurRadius: 1.5,
                      ),
                    ],
                    color: primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    )),
                child:Stack(children: <Widget>[
                   Column(
                  children: <Widget>[
                    Container(
                      key: msgkey0,
                      margin: EdgeInsets.only(right: _marginright),
                      child:Text(
                      msg,
                      style: TextStyle(color: whiteText, fontSize: 14),
                    ),
                    )
                    
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                Container(
                      width: _width0,
                      margin: EdgeInsets.only(top: _margintop,left: 8,right: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            time,
                            style:
                                TextStyle(color: Colors.white54, fontSize: 10),
                          )
                        ],
                      ),
                    )
                ],)
              ),
            ],
          ),
        ),
      ],
    );
  }
}
