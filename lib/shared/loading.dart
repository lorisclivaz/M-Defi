/*
 * Author : Loris Clivaz
 * Date creation : 09 juin 2020
 */

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/*
 * Classe qui va gérer une page de chargement tant que les données ne sont pas chargé
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */

//Design de la page
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[100],
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.blue,
          size: 150.0,
          duration: Duration(seconds: 5),
        ),
      ),
    );
  }
}
