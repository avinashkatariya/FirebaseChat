import 'package:FirebaseChat/Models/User.dart';

class MessageModel {
  final String messageId;
  final DateTime recordedAt;
  final String message;
  final User sender, reciver;
  final bool isSeen;

  MessageModel({
    this.messageId,
    this.recordedAt,
    this.message,
    this.sender,
    this.reciver,
    this.isSeen,
  });
}
