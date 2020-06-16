/*
 * Author : Loris Clivaz
 * Date creation : 04 juin 2020
 */

import 'package:firebase_database/firebase_database.dart';

/*
 * Classe de modèle quiz
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */

class Quiz {

  //Variable Quiz
  String key;
  String id;
  String name;
  String idTheme;

  //Constructeur
  Quiz(this.key, this.id, this.name, this.idTheme);

  //Constructeur pour la base de donéées
  Quiz.fromSnapshot(DataSnapshot snapshot)
  {
    this.id = snapshot.value["Id"];
    this.name = snapshot.value["Name"];
    this.idTheme = snapshot.value["IdTheme"];
  }



}