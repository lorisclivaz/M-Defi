/*
 * Author : Loris Clivaz
 * Date creation : 12 juillet 2020
 */

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

/*
 * Classe de modèle correction
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */
class CorrectionQuizModel
{
  //Variable correction
  String key;
  String nomQuiz;
  int nombrePage;
  String question;
  String reponse;
  int reponseUser;


  //Constructeur
  CorrectionQuizModel(this.key, this.nomQuiz, this.nombrePage, this.question, this.reponse, this.reponseUser);


  //Constructeur pour la base de données
  CorrectionQuizModel.fromSnapshot(DataSnapshot snapshot)
  {
    this.nomQuiz = snapshot.value["NomQuiz"];
    this.nombrePage = snapshot.value["NombrePage"];
    this.question = snapshot.value["Question"];
    this.reponse = snapshot.value["Reponse"];
    this.reponseUser = snapshot.value["ReponseUser"];

  }


}

