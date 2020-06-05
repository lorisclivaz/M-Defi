
import 'package:firebase_database/firebase_database.dart';

class Database {

   Future<String> createUser(String nom, String prenom, String filiere, String ecole, String annee, String email, String uid) async {


    var user = <String, dynamic>{
      'Nom':nom,
      'Prenom' : prenom,
      'Filiere': filiere,
      'Ecole': ecole,
      'Annee': annee,
      'Email': email,
      'Uid': uid

    };

    DatabaseReference reference = FirebaseDatabase.instance
    .reference()
    .child("users").push();


    reference.set(user);



  }

  //Insertion des différents themes dans la base de données
  Future<String> insertTheme() async{

     var themes = <String, dynamic>{
       'Id':'2007',
       'Name' : 'Informatique',
       'ImageUrl': 'A remplir',

     };

     DatabaseReference reference = FirebaseDatabase.instance
         .reference()
         .child("themes").push();


     reference.set(themes);
}





}