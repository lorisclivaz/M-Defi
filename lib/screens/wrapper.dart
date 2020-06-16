/*
 * Author : Loris Clivaz
 * Date creation : 04 juin 2020
 */

import 'package:flutter/material.dart';
import 'package:mdefi/models/user.dart';
import 'package:mdefi/screens/authenticate/authenticate.dart';
import 'package:mdefi/screens/home/homeApp.dart';
import 'package:provider/provider.dart';

/*
 * Classe qui va gérer la navigation sur le user est authentifier ou pas
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //Variable de l'utilisateur
    final user = Provider.of<User>(context);

    //Condition qui retourne la page si l'utilisateur se connecte ou pas
    if(user == null)
      {
        return Authenticate();
      }else
        {
          return HomeApp();
        }
  }
}

