/*
 * Author : Loris Clivaz
 * Date creation : 18 juin 2020
 */

import 'package:flutter/material.dart';
import 'package:mdefi/models/reponse.dart';

/*
 * Classe qui va gérer la dropDown list pour l'optionTwo classe
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */

class dropDown extends StatefulWidget {

 final List<ReponseQuestion> list;

  const dropDown(this.list);


  @override
  _dropDownState createState() => _dropDownState();

  String getAnswer()
  {
    return _dropDownState.getAnswer();
  }

}

class _dropDownState extends State<dropDown> {

  List<ReponseQuestion> reponse;
  ReponseQuestion selected ;


  static String answer = '';

  @override
  Widget build(BuildContext context) {

    reponse = widget.list;

    return Container(

        padding:
        EdgeInsets.symmetric(horizontal: 50, vertical: 5),
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
              DropdownButton<ReponseQuestion>(

                      items: reponse.map<DropdownMenuItem<ReponseQuestion>>((ReponseQuestion value) {
                    return DropdownMenuItem<ReponseQuestion>(
                    value: getValue(value),
                    child: new SizedBox(
                        width: 250.0,
                        child: new Text(value.name),
                    ),
                    );
                    }).toList(),

                  focusColor: Colors.white30,


                value: selected,


                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 42,
                  underline: SizedBox(),
                  onChanged: (ReponseQuestion newValue) {
                    if(mounted)
                    {
                      setState(() {
                        selected = newValue;
                        answer = newValue.answer;

                        print(selected);
                        getSelected(selected);
                      });
                    }
                  },

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
  ReponseQuestion getValue(ReponseQuestion value)
  {
    if(value != null)
    {
      return value;
    }else{
      value = new ReponseQuestion('', '', '', '', '', 'Choisissez une réponse');
    }
    return value;

  }
  
  static String getAnswer(){
    return answer;
  }

}
