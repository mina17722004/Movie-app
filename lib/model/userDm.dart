import 'package:cloud_firestore/cloud_firestore.dart';

class UserDm {
  final String uid;
  final String email;
  final String name;


  UserDm({
    required this.uid,
    required this.email,
    required this.name,

  });

  factory UserDm.fromFirestore(Map<String, dynamic> data) {
    return UserDm(
      uid: data['uid'] ?? '',
      email: data['email'] ?? '',
      name: data['name'] ?? 'Anonymous',

    );
  }
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,

    };
  }

}