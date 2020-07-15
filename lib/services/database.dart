/*
 * Author : Loris Clivaz
 * Date creation : 04 juin 2020
 */



import 'package:firebase_database/firebase_database.dart';
import 'package:mdefi/models/questions.dart';
import 'package:mdefi/models/solutions.dart';

/*
 * Classe qui va gérer les requêtes à la base de données
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */

class Database {

  final getQuestion = FirebaseDatabase.instance.reference().child("question");
  List<Question> listQuestion = List();

  final getSolutions = FirebaseDatabase.instance.reference().child("solutions");
  List<Solution> listSolutions = List();

  //Méthode permettant de créer l'utilisateur dans la base de données
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

  //Méthode permettant de modifier l'utilisateur dans la base de données
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

  //Méthode permettant d'insérer un thème dans la base de données
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

  //Méthode permettant d'insérer un quiz dans la base de données
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

  //Méthode permettant d'insérer une langue dans la base de données
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

  //Méthode permettant d'insérer une question dans la base de données
  Future<String> insertQuestion() async{

    var question = <String, dynamic>{
      'Id':'888',
      'Name' : "Que permet la création d'Includes ?",
      'Image': '',
      'Level':'0',
      'IdQuiz':'158',
      'PageType':'2'

    };

    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child("question").push();


    reference.set(question);
  }

  //Méthode permettant d'insérer une réponse dans la base de données
  Future<String> insertResponse() async{

    var response = <String, dynamic>{
      'Id':'2705',
      'Name' : "Lancer des codes de transaction",
      'Image': '',
      'Answer':'0',
      'IdQuestion':'888',

    };

    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child("response").push();


    reference.set(response);
  }

  //Méthode permettant d'insérer une solution dans la base de donnnées
  Future<String> insertSolutions() async{

    var response = <String, dynamic>{
      'Id':'539',
      'Titel' : "SAP NetWeaver",
      'Text': "Les 4 couches d'intégration de SAP NetWeaver sont composées de l'intégration des personnes (People Integration), l'intégration des informations (Information Integration), l'intégration des processus (Process Integration) et plateforme applicative (Application Platform).",
      'IdQuestion':'866',

    };

    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child("solutions").push();


    reference.set(response);
  }

  //Méthode permettant de récupérer les questions de la db
  Future<List<Question>> getQuestionFromDB() async
  {
    //Récupération des questions
    getQuestion.once().then((DataSnapshot snap) {
      var data = snap.value;
      listQuestion.clear();
      data.forEach((key, value) {
        Question questions = new Question(
            key,
            value['Id'],
            value['IdQuiz'],
            value['Image'],
            value['Level'],
            value['Name'],
            value['PageType']);

        listQuestion.add(questions);

      });
    });
    return listQuestion;
  }

  //Methode permettant de récupérer les solutions de la db
  Future<List<Solution>> getSolutionsFromDB() async
  {
    //Récupération des questions
    getSolutions.once().then((DataSnapshot snap) {
      var data = snap.value;
      listSolutions.clear();
      data.forEach((key, value) {
        Solution solution = new Solution(
            key, value['Id'], value['IdQuestion'], value['Text'],
            value['Titel']);

        listSolutions.add(solution);

      });
    });
    return listSolutions;
  }

  //Méthode permettant d'insérer une réponse dans la base de données
  Future<String> insertQuestionLangue() async{

    var response = <String, dynamic>{
      'Id':'6',
      'langue':'0',
      'Name1' : "Lucky Luke is a",
      'Name2': 'lonesome cowboy!',
      'RuleId':'50',
      'Level':'1',
      'Indice':'not rich',
      'PageType':'1'

    };

    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child("question_langues").push();


    reference.set(response);
  }

  //Méthode permettant d'insérer une réponse dans la base de données
  Future<String> insertResponseLangue() async{

    var response = <String, dynamic>{
      'Id':'5639',
      'questionId':'6',
      'Answer' : "poor",
      'IsGoodAnswer':'1'

    };

    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child("response_langues").push();


    reference.set(response);
  }

  //Méthode permettant d'insérer une correction dans la base de données
  Future<String> insertCorrectionQuestion(String nomQuiz, int nombrePage, String question, String reponse, int userAnswer) async{

    var response = <String, dynamic>{
      'NomQuiz':nomQuiz,
      'NombrePage':nombrePage,
      'Question' : question,
      'Reponse':reponse,
      'ReponseUser': userAnswer

    };

    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child("CorrectionQuiz").push();


    reference.set(response);
  }

  //Méthode permettant d'insérer une correction dans la base de données
  Future<String> DeleteCorrectionQuiz() async{



    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child("CorrectionQuiz");


    reference.remove();
  }

  //Méthode permettant d'insérer une correction dans la base de données
  Future<String> insertCorrectionQuestionLangues(int nombrePage, String name1, String name2, String reponse, String userAnswer) async{

    var response = <String, dynamic>{
      'NombrePage':nombrePage,
      'Name1' : name1,
      'Name2' : name2,
      'Reponse':reponse,
      'ReponseUser': userAnswer

    };

    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child("CorrectionQuizLangues").push();


    reference.set(response);
  }

  //Méthode permettant d'insérer une correction dans la base de données
  Future<String> DeleteCorrectionQuizLangues() async{



    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child("CorrectionQuizLangues");


    reference.remove();
  }


  //Méthode permettant d'insérer les données pour le classement des utilisateurs
  Future<String> insertClassementUsersThemes(String email, int coinQuiz,int score, int pointNegatif, int pointPositif) async{

    var response = <String, dynamic>{
      'Email':email,
      'CoinQuiz' : coinQuiz,
      'Score' : score,
      'PointNegatif':pointNegatif,
      'PointPositif': pointPositif

    };

    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child("ClassementUsersThemes").push();


    reference.set(response);
  }

  //Méthode permettant d'insérer les données pour le classement langues des utilisateurs
  Future<String> insertClassementUsersLangues(String email, int coinQuiz,int score, int pointNegatif, int pointPositif) async{

    var response = <String, dynamic>{
      'Email':email,
      'CoinQuiz' : coinQuiz,
      'Score' : score,
      'PointNegatif':pointNegatif,
      'PointPositif': pointPositif

    };

    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child("ClassementUsersLangues").push();


    reference.set(response);
  }


  //Méthode permettant de modifier les données de classement
  void updateClassementThemes(String key,String email, int coinQuiz,int score, int pointNegatif, int pointPositif){

    final DBRef = FirebaseDatabase.instance.reference().child('ClassementUsersThemes');

    DBRef.child(key).update({
      'Email':email,
      'CoinQuiz' : coinQuiz,
      'Score' : score,
      'PointNegatif':pointNegatif,
      'PointPositif': pointPositif
    });

    print("Update successfull");

  }


  //Méthode permettant de modifier les données de classement
  void updateClassementLangues(String key,String email, int coinQuiz,int score, int pointNegatif, int pointPositif){

    final DBRef = FirebaseDatabase.instance.reference().child('ClassementUsersLangues');

    DBRef.child(key).update({
      'Email':email,
      'CoinQuiz' : coinQuiz,
      'Score' : score,
      'PointNegatif':pointNegatif,
      'PointPositif': pointPositif
    });

    print("Update successfull");

  }


}