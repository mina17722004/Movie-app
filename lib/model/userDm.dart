import 'dart:convert';

class userDm{
  static late userDm currentUser;
 late String id;
  late String name;
  late String email;
  late List<String>? favouritesEventId;

  userDm({required this.name,required this.id,required this.email,this.favouritesEventId});
  userDm.fromJson(Map<Object,Object?>json){
    name = json["name"] as String;
   id = json["id"] as String;
    email =  json["email"] as String;
    List<dynamic>? events= json["favouritesEventId"] as List<dynamic>?;
    favouritesEventId = events?.map((event)=>event.toString()).toList();
  }
  Map <String,dynamic>tojson(){
    return{"id":id,
      "name":name,
      "email":email
      ,"favouritesEventId":favouritesEventId};
  }
  bool isFavouriteEvent(String eventId){
    return favouritesEventId?.contains(eventId)?? false;
  }

}
