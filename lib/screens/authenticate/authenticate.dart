/*
 * Author : Loris Clivaz
 * Date creation : 04 juin 2020
 */

import 'package:flutter/material.dart';
import 'package:mdefi/screens/authenticate/register.dart';
import 'package:mdefi/screens/authenticate/sign_in.dart';

/*
 * Classe qui va gérer l'authentification de l'utilisateur'
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */

class  Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}


class _AuthenticateState extends State<Authenticate> {

  //Variable pour voir ou non la page sign in
  bool showSingIn = true;

  //Gère le state de la page
  void toggleView(){
    setState(() => showSingIn = !showSingIn);
  }

  //Condition si vrai ou pas on affiche la page
  @override
  Widget build(BuildContext context) {

    if(showSingIn)
      {
        return SignIn(toggleView: toggleView);
      }else{
      return Register(toggleView: toggleView);
    }

  }
}
