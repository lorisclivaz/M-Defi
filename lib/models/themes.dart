import 'package:firebase_database/firebase_database.dart';

class Themes {

  //Themes variables
  String key;
  String id;
  String name;
  String imageUrl;


  Themes(this.key, this.name, this.imageUrl, this.id);

  Themes.fromSnapshot(DataSnapshot snapshot){

    this.id = snapshot.value["Id"];
    this.name = snapshot.value["Name"];
    this.imageUrl = snapshot.value["imageUrl"];


  }



}
