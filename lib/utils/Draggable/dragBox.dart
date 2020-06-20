/*
 * Author : Loris Clivaz
 * Date creation : 14 juin 2020
 */

import 'package:flutter/material.dart';

/*
 * Classe qui va gérer le drag and drop de l'application pour les quiz vrai ou faux
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */

class DragBox extends StatefulWidget {

  //Variable drag and drop
  final Offset initPos;
  final String label;
  final Color itemColor;

  //Constructeur
  DragBox(this.initPos, this.label, this.itemColor);

  @override
  _DragBoxState createState() => _DragBoxState();
}

class _DragBoxState extends State<DragBox> {

  //Variable de position
  Offset position = Offset(0.0, 0.0);

  //Méthode d'initialisation des valeurs de position
  @override
  void initState()
  {
    super.initState();
    position = widget.initPos;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("Dispose draggable state");
  }

  //Design du drag and drop
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Draggable(
        data: widget.label,
        child: Container(
          width: 120.0,
          height: 50.0,
          color:  widget.itemColor,
          child: Center(
            child: Text(
              widget.label,
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
                fontSize: 20.0
              ),
            ),
          ),
        ),
        onDraggableCanceled: (velocity, offset){
          setState(() {
            position = offset;
          });
        },
        feedback: Container(
          width: 120.0,
          height: 60.0,
          color: widget.itemColor.withOpacity(0.5),
          child: Center(
            child: Text(
              widget.label,
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
                fontSize: 18.0
              ),
            ),
          ),
        ),
      ),
    );
  }
}
