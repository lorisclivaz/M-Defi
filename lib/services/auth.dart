/*
 * Author : Loris Clivaz
 * Date creation : 04 juin 2020
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mdefi/models/user.dart';

/*
 * Classe qui va gérer l'accès aux données de l'utilisateur
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */

class AuthService {

  //Variable de la base de données
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Constructeur
  User _userFromFirebaseUser(FirebaseUser user)
  {
    return user != null ? User(uid: user.uid, email: user.email) : null;
  }

  //L'utilisateur actuel sur l'application
  Stream<User> get user{
    return _auth.onAuthStateChanged
    .map(_userFromFirebaseUser);
  }


  //Méthode qui récupère l'email de l'utilisateur
  Future<String> getCurrentEmail() async {
    return (await _auth.currentUser()).email;
  }


  //Méthode qui récupère l'uid de l'utilisateur
  Future<String> getCurrentUID() async {
    return (await _auth.currentUser()).uid;
  }

  //Méthode qui récupère le token de l'utilisateur
  Future<String> getToken() async {
    return (await _auth.currentUser()).getIdToken().toString();
  }

  //Méthode permettant de se connecter en tant qu'anonyme
  Future signInAnon() async{
    try{
     AuthResult result =  await _auth.signInAnonymously();
     FirebaseUser user = result.user;
     return _userFromFirebaseUser(user);
    }catch(e)
    {
      print(e.toString());
      return null;
    }
  }


  //Méthode permettant de modifier le mot de passe
  @override
  Future<void> resetPassword(String email) async {
    await _auth..sendPasswordResetEmail(email: email);
  }


  //Méthode permettant de se connecter avec l'adresse email ainsi que le mot de passe
  Future signInWithEmailAndpassword(String email, String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //Méthode permettant d'enregistrer l'email ainsi que le mot de passe
  Future registerWithEmailAndpassword(String email, String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //Méthode permettant de se déconnecter de l'application
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}