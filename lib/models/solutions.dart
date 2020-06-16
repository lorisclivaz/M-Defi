/*
 * Author : Loris Clivaz
 * Date creation : 04 juin 2020
 */

import 'package:firebase_database/firebase_database.dart';

/*
 * Classe de modèle solution questions
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */

class Solution {

  //Variables solution
  String key;
  String id;
  String idQuestion;
  String text;
  String titel;

  //Constructeur
  Solution(this.key, this.id, this.idQuestion, this.text, this.titel);

  //Constructeur pour la base de données
  Solution.fromSnapshot(DataSnapshot snapshot)
  {
    this.id = snapshot.value["Id"];
    this.idQuestion = snapshot.value["IdQuestion"];
    this.text = snapshot.value["Text"];
    this.titel = snapshot.value["Titel"];
  }
}