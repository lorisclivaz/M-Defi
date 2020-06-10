import 'package:firebase_database/firebase_database.dart';

class Langue {

  //Themes variables
  String key;
  String id;
  String name;
  String imageUrl;


  Langue(this.key, this.name, this.imageUrl, this.id);

  Langue.fromSnapshot(DataSnapshot snapshot){
    this.id = snapshot.value["Id"];
    this.name = snapshot.value["Name"];
    this.imageUrl = snapshot.value["imageUrl"];
  }
}
