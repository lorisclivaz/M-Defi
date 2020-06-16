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

class Themes {

  //Variables theme
  String key;
  String id;
  String name;
  String imageUrl;

  //Constrcuteur
  Themes(this.key, this.name, this.imageUrl, this.id);

  //Constructeur pour la base de données
  Themes.fromSnapshot(DataSnapshot snapshot)
  {
    this.id = snapshot.value["Id"];
    this.name = snapshot.value["Name"];
    this.imageUrl = snapshot.value["imageUrl"];
  }
}
