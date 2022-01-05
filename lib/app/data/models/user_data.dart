class UserData {
  UserData({required this.firstName, required this.lastName});

  final String firstName;
  final String lastName;

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }

  List<String> toList() {
    return [firstName, lastName];
  }
}

class UserToken {
  UserToken(this.token);

  final String token;

  factory UserToken.fromBase64(String token) => UserToken(token);
}
