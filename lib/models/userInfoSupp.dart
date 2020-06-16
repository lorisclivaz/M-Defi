/*
 * Author : Loris Clivaz
 * Date creation : 04 juin 2020
 */

import 'package:firebase_database/firebase_database.dart';

/*
 * Classe modèle des informations supplémentaire de l'utilisateur
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */

class UserInfoSupp {

   //Variable profil
   String uid;
   String email;
   String annee;
   String ecole;
   String filiere;
   String nom;
   String prenom;
   String key;

   //Constructeur
   UserInfoSupp(this.key, this.uid, this.email, this.annee, this.ecole,
       this.filiere,
       this.nom, this.prenom);


   //Constructeur pour la base de données
   UserInfoSupp.fromSnapshot(DataSnapshot snapshot)
   {
      this.uid = snapshot.value["Uid"];
      this.email = snapshot.value["Email"];
      this.annee = snapshot.value["Annee"];
      this.ecole = snapshot.value["Ecole"];
      this.filiere = snapshot.value["Filiere"];
      this.nom = snapshot.value["Nom"];
      this.prenom = snapshot.value["Prenom"];
   }
}

