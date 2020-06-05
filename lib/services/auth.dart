import 'package:firebase_auth/firebase_auth.dart';
import 'package:mdefi/models/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on Firebase user
  User _userFromFirebaseUser(FirebaseUser user)
  {

    return user != null ? User(uid: user.uid, email: user.email) : null;
  }

  //auth change user stream (current user in the application)
  Stream<User> get user{
    return _auth.onAuthStateChanged
    .map(_userFromFirebaseUser);
  }

  //Get email
//Get UID
  Future<String> getCurrentEmail() async {
    return (await _auth.currentUser()).email;

  }


  //Get UID
  Future<String> getCurrentUID() async {
    return (await _auth.currentUser()).uid;
  }


  //sign in anonymous
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


  //Reset password
  @override
  Future<void> resetPassword(String email) async {
    await _auth..sendPasswordResetEmail(email: email);
  }


  //sign in with email and password
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

  //register with email and password
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

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}