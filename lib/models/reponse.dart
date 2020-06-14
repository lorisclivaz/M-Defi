import 'package:firebase_database/firebase_database.dart';

class ReponseQuestion {

  //Themes variables
  String key;
  String answer;
  String id;
  String idQuestion;
  String image;
  String name;


  ReponseQuestion(this.key, this.answer, this.id, this.idQuestion, this.image, this.name);

  ReponseQuestion.fromSnapshot(DataSnapshot snapshot){

    this.answer = snapshot.value["Answer"];
    this.id = snapshot.value["Id"];
    this.idQuestion = snapshot.value["IdQuestion"];
    this.image = snapshot.value["Image"];
    this.name = snapshot.value["Name"];



  }



}