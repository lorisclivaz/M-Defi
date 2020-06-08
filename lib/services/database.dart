
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

  void updateUser(String key,String nom, String prenom, String ecole, String filiere, String annee){

    final DBRef = FirebaseDatabase.instance.reference().child('users');


    DBRef.child(key).update({
      'Nom':nom,
      'Prenom':prenom,
      'Ecole':ecole,
      'Filiere':filiere,
      'Annee':annee
    });

    print("Update successfull");

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

//Insertion des différents themes dans la base de données
  Future<String> insertQuiz() async{

    var themes = <String, dynamic>{
      'Id':'203',
      'Name' : 'Droit (semestre 2)',
      'IdTheme': '2000',

    };

    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child("quiz").push();


    reference.set(themes);
  }



}