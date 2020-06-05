import 'package:firebase_database/firebase_database.dart';

class UserInfoSupp {

  //Authentification
   String uid;
   String email;
   String annee;
   String ecole;
   String filiere;
   String nom;
   String prenom;
   String key;

   UserInfoSupp(this.uid, this.email, this.annee, this.ecole, this.filiere,
       this.nom, this.prenom);



   UserInfoSupp.fromSnapshot(DataSnapshot snapshot){

      this.uid = snapshot.value["Uid"];
      this.email = snapshot.value["Email"];
      this.annee = snapshot.value["Annee"];
      this.ecole = snapshot.value["Ecole"];
      this.filiere = snapshot.value["Filiere"];
      this.nom = snapshot.value["Nom"];
      this.prenom = snapshot.value["Prenom"];

          }



}

