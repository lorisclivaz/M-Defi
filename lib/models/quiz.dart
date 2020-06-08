import 'package:firebase_database/firebase_database.dart';

class Quiz {

  //Themes variables
  String key;
  String id;
  String name;
  String idTheme;


  Quiz(this.key, this.id, this.name, this.idTheme);

  Quiz.fromSnapshot(DataSnapshot snapshot){

    this.id = snapshot.value["Id"];
    this.name = snapshot.value["Name"];
    this.idTheme = snapshot.value["IdTheme"];


  }



}