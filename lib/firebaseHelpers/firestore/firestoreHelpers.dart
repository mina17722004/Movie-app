import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:mm/model/userDm.dart';


Future<void>createUserInFirestore(UserDm userDm){
 CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
return usersCollection.doc(userDm.uid).set(userDm.toJson());
}


Future<UserDm?> getUserFromFirestore(String uid) async {
 var userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

 if (userDoc.exists) {
  print(" User found in Firestore: ${userDoc.data()}");

  return UserDm.fromFirestore(userDoc.data()!);
 } else {
  print("User does NOT exist in Firestore.");
  return null;
 }
}




Future<void> checkFirestoreUser(String uid) async {
 var userRef = FirebaseFirestore.instance.collection('users').doc(uid);
 var docSnapshot = await userRef.get();

 if (!docSnapshot.exists) {
  print("User does not exist in Firestore. Creating new entry...");
  await userRef.set({
   "uid": uid,
   "email": FirebaseAuth.instance.currentUser?.email ?? "Unknown",
   "name": FirebaseAuth.instance.currentUser?.displayName ?? "Anonymous",
   "createdAt": FieldValue.serverTimestamp(),
  });
 } else {
  print("✅ User found in Firestore: ${docSnapshot.data()}");
 }
}
Future<void> saveUserToFirestore(User? user) async {
 if (user == null) return;

 var userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
 var docSnapshot = await userRef.get();

 if (!docSnapshot.exists) {
  print(" User does not exist in Firestore. Creating new entry...");
  await userRef.set({
   "uid": user.uid,
   "email": user.email ?? "Unknown",
   "name": user.displayName ?? "Anonymous",
   "createdAt": FieldValue.serverTimestamp(),
  }).then((_) {
   print(" User successfully saved to Firestore!");
  }).catchError((e) {
   print(" Firestore Save Error: $e");
  });
 } else {
  print(" User found in Firestore: ${docSnapshot.data()}");
 }
}

