import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:mm/model/userDm.dart';


Future<void>createUserInFirestore(userDm userDm){
 //{"id": "1","name":"mina","email":"mina1@gmail.com","favouritesEventIds":["1"]}
 CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
return usersCollection.doc(userDm.id).set(userDm.tojson());
 //usersCollection.add(userDm.tojson()); auto generated id
}
Future<userDm>getUserFromFirestore(String id) async {
 CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

 // FirebaseFirestore.instance.collection: get collection if we have it,
 // and create collection if we dont have it
 DocumentReference userDoc = usersCollection.doc(id);
 //usersCollection.doc:create document if we dont have it and
 //get it if we have it
 DocumentSnapshot userSnapshot = await  userDoc.get();
 Map<Object,Object?> json =userSnapshot.data() as Map<Object,Object?> ;
 return userDm.fromJson(json);
}
