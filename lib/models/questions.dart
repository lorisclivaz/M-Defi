/*
 * Author : Loris Clivaz
 * Date creation : 04 juin 2020
 */

import 'package:firebase_database/firebase_database.dart';

/*
 * Classe de modèle question
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */
class Question {

  //Variable questions
  String key;
  String id;
  String idQuiz;
  String image;
  String level;
  String name;
  String pageType;

  //Constructeur
  Question(this.key, this.id, this.idQuiz, this.image, this.level, this.name, this.pageType);

  //Constructeur pour la base de données
  Question.fromSnapshot(DataSnapshot snapshot)
  {
    this.id = snapshot.value["Id"];
    this.idQuiz = snapshot.value["IdQuiz"];
    this.image = snapshot.value["image"];
    this.level = snapshot.value["Level"];
    this.name = snapshot.value["Name"];
    this.name = snapshot.value["PageType"];
  }
}