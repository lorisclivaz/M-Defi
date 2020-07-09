/*
 * Author : Loris Clivaz
 * Date creation : 08 juillet 2020
 */

import 'package:firebase_database/firebase_database.dart';

/*
 * Classe de modèle question
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */
class QuestionLangue {

  //Variable questions
  String key;
  String id;
  String indice;
  String level;
  String name1;
  String name2;
  String pageType;
  String RuleId;
  String Langue;

  //Constructeur
  QuestionLangue(this.key, this.id, this.indice, this.level, this.name1, this.name2, this.pageType ,this.RuleId, this.Langue);

  //Constructeur pour la base de données
  QuestionLangue.fromSnapshot(DataSnapshot snapshot)
  {
    this.id = snapshot.value["Id"];
    this.indice = snapshot.value["Indice"];
    this.level = snapshot.value["Level"];
    this.name1 = snapshot.value["Name1"];
    this.name2 = snapshot.value["Name2"];
    this.pageType = snapshot.value["PageType"];
    this.RuleId = snapshot.value["RuleId"];
    this.Langue = snapshot.value["Langue"];

  }
}