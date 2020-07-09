/*
 * Author : Loris Clivaz
 * Date creation : 08 juillet 2020
 */

import 'package:firebase_database/firebase_database.dart';

/*
 * Classe de modèle réponse
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */
class ReponseLangue {

  //Variable questions
  String key;
  String answer;
  String id;
  String isGoodAnswer;
  String questionId;


  //Constructeur
  ReponseLangue(this.key, this.answer, this.id, this.isGoodAnswer, this.questionId);

  //Constructeur pour la base de données
  ReponseLangue.fromSnapshot(DataSnapshot snapshot)
  {
    this.answer = snapshot.value["Answer"];
    this.id = snapshot.value["Id"];
    this.isGoodAnswer = snapshot.value["IsGoodAnswer"];
    this.questionId = snapshot.value["questionId"];
    }
}