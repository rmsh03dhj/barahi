import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int userID;
  final String firstName;
  final String lastName;
  final String email;

  User({this.userID, this.firstName, this.lastName, this.email});

  User copyWith({userID, firstName, lastName, email}) {
    return User(
        userID: userID ?? this.userID,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email);
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
