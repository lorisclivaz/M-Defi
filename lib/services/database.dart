
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

  Future<String> insertLangues() async{

    var themes = <String, dynamic>{
      'Id':'5003',
      'Name' : 'Allemand',
      'ImageUrl': 'A remplir',

    };

    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child("langues").push();


    reference.set(themes);
  }

  //Insertion des différentes questions dans la base de données
  Future<String> insertQuestion() async{

    var question = <String, dynamic>{
      'Id':'1569',
      'Name' : "Vrai ou faux : l'instruction sur l'image ci-dessous permet de définir une variable fcode de type sy-ucomm en créant une autre variable que ok_code pour éviter d'utiliser directement fcode.",
      'Image': '',
      'Level':'2',
      'IdQuiz':'158',
      'PageType':'1'

    };

    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child("question").push();


    reference.set(question);
  }

//Insertion des différentes questions dans la base de données
  Future<String> insertResponse() async{

    var response = <String, dynamic>{
      'Id':'2646',
      'Name' : 'Vrai',
      'Image': '',
      'Answer':'0',
      'IdQuestion':'871',

    };

    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child("response").push();


    reference.set(response);
  }

}