class UserInstance {
  final String uid;
  final String providerId;
  UserInstance(this.providerId, {this.uid});
}

class User {
  final String firstName, id;
  final String mobileNumber;
  final String lastName, userDp;

  User({
    this.userDp,
    this.firstName,
    this.lastName,
    this.id,
    this.mobileNumber,
  });

  String get fullName => firstName + " " + lastName;

  Map<String, dynamic> tojson() {
    return {
      "id": id,
      "first_name": firstName,
      "last_name": lastName,
      "userDp": userDp,
    };
  }
}
