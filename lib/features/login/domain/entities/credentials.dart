// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Credentials {
  final String name;
  final String password;

  Credentials({required this.name, required this.password});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'password': password,
    };
  }

  factory Credentials.fromMap(Map<String, dynamic> map) {
    return Credentials(
      name: map['name'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Credentials.fromJson(String source) =>
      Credentials.fromMap(json.decode(source) as Map<String, dynamic>);
}
