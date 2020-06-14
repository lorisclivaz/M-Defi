import 'package:firebase_database/firebase_database.dart';

class Question {

  //Themes variables
  String key;
  String id;
  String idQuiz;
  String image;
  String level;
  String name;
  String pageType;


  Question(this.key, this.id, this.idQuiz, this.image, this.level, this.name, this.pageType);

  Question.fromSnapshot(DataSnapshot snapshot){

    this.id = snapshot.value["Id"];
    this.idQuiz = snapshot.value["IdQuiz"];
    this.image = snapshot.value["image"];
    this.level = snapshot.value["Level"];
    this.name = snapshot.value["Name"];
    this.name = snapshot.value["PageType"];



  }



}