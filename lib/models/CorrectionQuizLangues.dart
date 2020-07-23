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
class CorrectionQuizLanguesModel
{
  //Variable correction
  String key;
  int nombrePage;
  String name1;
  String name2;
  String reponse;
  String reponseUser;


  //Constructeur
  CorrectionQuizLanguesModel(this.key,  this.name1, this.name2,this.nombrePage, this.reponse, this.reponseUser);


  //Constructeur pour la base de données
  CorrectionQuizLanguesModel.fromSnapshot(DataSnapshot snapshot)
  {
    this.name1 = snapshot.value["Name1"];
    this.name2 = snapshot.value["Name2"];
    this.nombrePage = snapshot.value["NombrePage"];
    this.reponse = snapshot.value["Reponse"];
    this.reponseUser = snapshot.value["ReponseUser"];


  }
}