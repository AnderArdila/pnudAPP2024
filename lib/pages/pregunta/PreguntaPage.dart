import 'package:flutter/material.dart';

import '../../model/Persona.dart';

import '../../model/Pregunta.dart';
import 'UpdatePreguntaPage.dart';

class PreguntaPage extends StatelessWidget {
  final Persona persona;
  final Pregunta pregunta;

  PreguntaPage({this.persona, this.pregunta});

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget _buildItem(BuildContext context, Pregunta pregunta, [int nivel = 0]) {
    List<Widget> children = new List<Widget>();
    if (nivel != 0 || pregunta.persona.idPersona != persona.idPersona) {
      children.add(Text(
        pregunta.persona.nombre + ":",
        style: Theme.of(context).textTheme.caption.copyWith(fontSize: 10.0),
        textAlign: TextAlign.left,
      ));
    }

    children.add(Container(
      margin: EdgeInsets.all(2.0),
      padding: EdgeInsets.all(5.0),
      decoration: new BoxDecoration(
          border:
              new Border.all(color: nivel == 0 ? Colors.blue : Colors.green)),
      child: Text(
        pregunta.texto,
        softWrap: true,
        style: nivel == 0
            ? Theme.of(context).textTheme.subhead
            : Theme.of(context).textTheme.body1,
        textAlign: TextAlign.justify,
      ),
    ));

    for (Pregunta respuesta in pregunta.respuestas) {
      children.add(_buildItem(context, respuesta, nivel + 1));
    }

    if (nivel == 0 && persona.experto) {
      children.add(Padding(
          padding: EdgeInsets.only(top: 5.0),
          child: RaisedButton(
            child: Text("Responder"),
            onPressed: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new UpdatePreguntaPage(
                      pregunta: pregunta, persona: persona),
                ),
              );
            },
          )));
    }

    return Card(
        elevation: 5.0 * nivel,
        margin: EdgeInsets.only(
            left: 3.0 + (5.0 * nivel), top: 5.0, right: 3.0, bottom: 3.0),
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: children,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("PREGUNTE A UN EXPERTO"),
          centerTitle: true,
        ),
        key: _scaffoldKey,
        body: this._buildItem(context, this.pregunta));
  }
}
