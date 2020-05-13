import 'package:FirebaseChat/Models/User.dart';

class JsonHelper {
  User userFromJSON(Map<String, dynamic> json) {
    return User(
      id:json["id"],
      lastName: json["last_name"],
      firstName: json["first_name"],
      userDp: json["userDp"]
    );
  }
}
