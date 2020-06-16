/*
 * Author : Loris Clivaz
 * Date creation : 04 juin 2020
 */

import 'package:flutter/material.dart';
import 'package:mdefi/models/user.dart';
import 'package:mdefi/screens/wrapper.dart';
import 'package:mdefi/services/auth.dart';
import 'package:provider/provider.dart';

/*
 * Classe qui va gérer le lancement de l'application
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //we return the wrapper
        home: Wrapper(),
      ),
    );
  }
}


