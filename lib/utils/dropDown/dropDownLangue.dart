/*
 * Author : Loris Clivaz
 * Date creation : 09 juillet 2020
 */

import 'package:flutter/material.dart';
import 'package:mdefi/models/questionLangue.dart';
import 'package:mdefi/models/reponse.dart';
import 'package:mdefi/models/reponseLangues.dart';

/*
 * Classe qui va gérer la dropDown list pour l'optionTwo classe
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */

class dropDownLangue extends StatefulWidget {

  final List<ReponseLangue> list;

  const dropDownLangue(this.list);


  @override
  _dropDownLangueState createState() => _dropDownLangueState();

  String getAnswer()
  {
    return _dropDownLangueState.getAnswer();
  }

}

class _dropDownLangueState extends State<dropDownLangue> {

  List<ReponseLangue> reponse;
  ReponseLangue selected  = null;


  static String answer = '';

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("Dispose dropdown state");
  }
  @override
  Widget build(BuildContext context) {

    reponse = widget.list;

    return Container(
        width: MediaQuery.of(context).size.width*0.66,
        height: MediaQuery.of(context).size.height*0.05,
        decoration: BoxDecoration(
            color: Colors.white30,
            borderRadius: BorderRadius.circular(10)),
        child: new Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.white30,
          ),
          // dropdown below..
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              DropdownButton<ReponseLangue>(

                focusColor: Colors.white30,
                value: selected,
                isDense: true,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 20,
                underline: SizedBox(),
                onChanged: (ReponseLangue newValue) {
                  if(mounted)
                  {
                    setState(() {
                      selected = newValue;
                      answer = newValue.isGoodAnswer;
                    });
                  }
                },items: reponse.map<DropdownMenuItem<ReponseLangue>>((ReponseLangue value) {
                return DropdownMenuItem<ReponseLangue>(
                  value: value,
                  child: new SizedBox(
                    width: 250.0,
                    child: new Text(value.answer),
                  ),
                );
              }).toList(),

              )
            ],
          ),
        )
    );
  }

  ReponseQuestion getSelected(ReponseQuestion selected)
  {
    if(selected != null)
    {
      return selected;
    }else{
      selected = null;
    }
    return selected;

  }


  static String getAnswer(){
    return answer;
  }

}
