import 'package:FirebaseChat/Models/User.dart';

class LastMessages {
  final String message;
  final User friend;
  final DateTime recordedAt;

  LastMessages({
    this.message,
    this.friend,
    this.recordedAt,
  });
}
