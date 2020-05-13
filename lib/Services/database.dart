import 'package:FirebaseChat/Helpers/jsonhelper.dart';
import 'package:FirebaseChat/Models/User.dart';
import 'package:FirebaseChat/Models/chatModel.dart';
import 'package:FirebaseChat/Models/last_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  CollectionReference userDataCollection =
      Firestore.instance.collection("userData");

  String getChatDocumentId(String a, String b) {
    return a.compareTo(b) > 0 ? a + "_" + b : b + "_" + a;
  }

  String getFetchChatDocumentId(String a, String b) {
    return a.compareTo(b) > 0
        ? "  " + a + " _  " + b + " "
        : "  " + b + " _  " + a + " ";
  }

  Future<MessageModel> sendMessage(
      User user, User friend, String message) async {
    String cid = getChatDocumentId(user.id, friend.id);
    Timestamp timestamp = Timestamp.now();
    DocumentReference dref =
        await Firestore.instance.collection("/messages/$cid/messages").add({
      "sender": user.tojson(),
      "reciver": friend.tojson(),
      "message": message,
      "recordedAt": timestamp,
      "isSeen": false,
    });

    await Firestore.instance
        .collection("/lastMessage/${user.id}/lastMessage")
        .document(friend.id)
        .setData({
      "friend": friend.tojson(),
      "message": {
        "message": message,
        "recordedAt": timestamp,
        "isSeen": false,
      }
    });
    await Firestore.instance
        .collection("/lastMessage/${friend.id}/lastMessage")
        .document(user.id)
        .setData({
      "friend": user.tojson(),
      "message": {
        "message": message,
        "recordedAt": timestamp,
        "isSeen": false,
      }
    });

    if (dref != null) {
      return MessageModel(
        message: message,
        sender: user,
        recordedAt: DateTime.parse(timestamp.toDate().toString()),
        reciver: friend,
        isSeen: false,
      );
    }
  }

  List<LastMessages> _mapLastMessageData2Model(QuerySnapshot querySnapshot) {
    return querySnapshot.documents.map((data) {
      return LastMessages(
        friend: JsonHelper().userFromJSON(data['friend']),
        message: data["message"]["message"],
        recordedAt:
            DateTime.parse(data["message"]["recordedAt"].toDate().toString()),
      );
    }).toList();
  }

  List<MessageModel> _mapMessageData2Model(QuerySnapshot querySnapshot) {
    return querySnapshot.documents.map((data) {
      print(data['sender']);

      return MessageModel(
        isSeen: data['isSeen'],
        reciver: JsonHelper().userFromJSON(data['reciver']),
        sender: JsonHelper().userFromJSON(data['sender']),
        message: data["message"],
        recordedAt: DateTime.parse(data["recordedAt"].toDate().toString()),
      );
    }).toList();
  }

  Stream<List<LastMessages>> getContacts(String uid) {
    return Firestore.instance
        .collection("lastMessage/$uid/lastMessage/")
        .getDocuments()
        .asStream()
        .map(_mapLastMessageData2Model);
  }

  User _mapUserData2Model(DocumentSnapshot data) {
    try {
      print(data.documentID);
      if (data.exists == false) {
        return null;
      }
      return User(
        firstName: data["first_name"],
        lastName: data["last_name"],
        userDp: data["ano"].toString(),
        id: data.documentID,
      );
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Stream<User> getUserData(String uid) {
    return userDataCollection
        .document(uid)
        .get()
        .asStream()
        .map(_mapUserData2Model);
  }

  Future<bool> setUserData(
    String uid,
    String mobileNumber,
    int ano,
    String firstName,
    String lastName,
  ) async {
    bool rval = false;
    await userDataCollection.document(uid).setData({
      "mobile_number": mobileNumber,
      "ano": ano,
      "first_name": firstName,
      "last_name": lastName,
    }).then((value) {
      rval = true;
    }).catchError(() {
      rval = false;
    });
    return rval;
  }

  Stream<List<MessageModel>> getMessages(user, friend) {
    String messagestore = getChatDocumentId(user.id, friend.id);
    print(messagestore);
    return Firestore.instance
        .collection("messages/$messagestore/messages/")
        .orderBy("recordedAt", descending: true)
        .getDocuments()
        .asStream()
        .map(_mapMessageData2Model);
  }

  User _mapUserData2Model2(DocumentSnapshot data) {
    return User(
      mobileNumber: data['mobile_number'],
      firstName: data["first_name"],
      lastName: data["last_name"],
      userDp: data["ano"].toString(),
      id: data.documentID,
    );
  }

  Future<List<User>> getValidContacts(List<String> mobileNumbers) async {
    List<User> contacts = [];

    for (String number in mobileNumbers) {
      QuerySnapshot querySnapshot = await userDataCollection
          .where("mobile_number", isEqualTo: number)
          .getDocuments();
      for (DocumentSnapshot data in querySnapshot.documents) {
        contacts.add(_mapUserData2Model2(data));
      }
    }
    return contacts;
  }

  //dsvhbfkvdjacvuhvf_4qrfCklUi4XNnyTsGqgSF5E0jKK2
}

//    4qrfCklUi4XNnyTsGqgSF5E0jKK2  _    4qrfCklUi4XNnyTsGqgSF5E0jKK2
