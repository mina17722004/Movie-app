import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mm/theme/app_assets.dart';

class UserDm {
  final String uid;
  final String email;
  final String name;
  final String iconUrl;


  UserDm({
    required this.uid,
    required this.email,
    required this.name,
    required this.iconUrl,

  });

  factory UserDm.fromFirestore(Map<String, dynamic> data) {
    return UserDm(
      uid: data['uid'] ?? '',
      email: data['email'] ?? '',
      name: data['name'] ?? 'Anonymous',
      iconUrl: data['iconUrl']??AppAssets.gamerOne

    );
  }
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'iconUrl':iconUrl,
    };

  }

}