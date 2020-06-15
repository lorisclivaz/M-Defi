import 'package:firebase_database/firebase_database.dart';

class Solution {

  //Themes variables
  String key;
  String id;
  String idQuestion;
  String text;
  String titel;


  Solution(this.key, this.id, this.idQuestion, this.text, this.titel);

  Solution.fromSnapshot(DataSnapshot snapshot){

    this.id = snapshot.value["Id"];
    this.idQuestion = snapshot.value["IdQuestion"];
    this.text = snapshot.value["Text"];
    this.titel = snapshot.value["Titel"];

  }



}