
/*
 * Author : Loris Clivaz
 * Date creation : 04 juin 2020
 */
import 'package:firebase_database/firebase_database.dart';

/*
 * Classe de modèle réponse question
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */

class ReponseQuestion {

  //Variables réponse question
  String key;
  String answer;
  String id;
  String idQuestion;
  String image;
  String name;

  //Constructeur
  ReponseQuestion(this.key, this.answer, this.id, this.idQuestion, this.image, this.name);

  //Constructeur pour la base de données
  ReponseQuestion.fromSnapshot(DataSnapshot snapshot)
  {
    this.answer = snapshot.value["Answer"];
    this.id = snapshot.value["Id"];
    this.idQuestion = snapshot.value["IdQuestion"];
    this.image = snapshot.value["Image"];
    this.name = snapshot.value["Name"];
  }
}