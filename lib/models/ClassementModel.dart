import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ClassementModel
{
  //Variable langue
  String key;
  String email;
  int coinQuiz;
  int score;
  int pointPositif;
  int pointNegatif;


  //Constructeur
  ClassementModel(this.key, this.coinQuiz, this.email, this.pointNegatif , this.pointPositif,this.score );


  //Constructeur pour la base de données
  ClassementModel.fromSnapshot(DataSnapshot snapshot)
  {
    this.coinQuiz = snapshot.value["CoinQuiz"];
    this.email = snapshot.value["Email"];
    this.pointNegatif = snapshot.value["PointNegatif"];
    this.pointPositif = snapshot.value["PointPositif"];
    this.score = snapshot.value["Score"];

  }


}