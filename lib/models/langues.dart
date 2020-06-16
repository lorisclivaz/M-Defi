/*
 * Author : Loris Clivaz
 * Date creation : 04 juin 2020
 */

import 'package:firebase_database/firebase_database.dart';

/*
 * Classe de modèle langue
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */
class Langue {

  //Variable langue
  String key;
  String id;
  String name;
  String imageUrl;

  //Constructeur
  Langue(this.key, this.name, this.imageUrl, this.id);


  //Constructeur pour la base de données
  Langue.fromSnapshot(DataSnapshot snapshot)
  {
    this.id = snapshot.value["Id"];
    this.name = snapshot.value["Name"];
    this.imageUrl = snapshot.value["imageUrl"];
  }
}
