class User {
  final String id;
  final String firstName;
  final String lastName;
  final String username;
  final String password;
  final String authLevel;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.username,
      required this.password,
      required this.authLevel});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      username: json['username'],
      password: json['password'],
      authLevel: json['authLevel'],
    );
  }

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'username': username,
        'authLevel': authLevel
      };
}
