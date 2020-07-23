/*
 * Author : Loris Clivaz
 * Date creation : 10 juillet 2020
 */

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

/*
 * Classe de modèle classement
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */

class ClassementModel
{
  //Variable classement
  String key;
  String email;
  int coinQuiz;
  int score;
  int pointPositif;
  int pointNegatif;
  String nomQuiz;


  //Constructeur
  ClassementModel(this.key, this.coinQuiz, this.email, this.pointNegatif , this.pointPositif,this.score, this.nomQuiz);


  //Constructeur pour la base de données
  ClassementModel.fromSnapshot(DataSnapshot snapshot)
  {
    this.coinQuiz = snapshot.value["CoinQuiz"];
    this.email = snapshot.value["Email"];
    this.pointNegatif = snapshot.value["PointNegatif"];
    this.pointPositif = snapshot.value["PointPositif"];
    this.score = snapshot.value["Score"];
    this.score = snapshot.value["NomQuiz"];


  }


}