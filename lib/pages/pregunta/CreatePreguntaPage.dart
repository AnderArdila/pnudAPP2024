import 'package:flutter/material.dart';
import 'dart:async';

import '../../model/Persona.dart';
import '../../model/Pregunta.dart';
import '../../api/PreguntaApi.dart';
import '../../constants.dart';
import '../../widget/dialog.dart';

class CreatePreguntaPage extends StatefulWidget {
  final Persona persona;

  CreatePreguntaPage({Key key, this.persona}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _CreatePreguntaPageState(
      pregunta: new Pregunta(persona: this.persona));
}

class _CreatePreguntaPageState extends State<CreatePreguntaPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final PreguntaApi _preguntaApi = new PreguntaApi();

  Pregunta pregunta;

  _CreatePreguntaPageState({this.pregunta});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CREAR PREGUNTA"),
        centerTitle: true,
      ),
      key: _scaffoldKey,
      body: Form(
        key: this._formKey,
        child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(20.0),
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Pregunta'),
                autovalidate: true,
                maxLength: 1000,
                maxLines: null,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Por favor ingrese una pregunta';
                  }
                  return null;
                },
                onSaved: (String value) {
                  this.pregunta.texto = value;
                },
              ),
              Divider(),
              RaisedButton(
                child: Text(
                  'Enviar pregunta',
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).primaryColor,
                shape: StadiumBorder(),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    try {
                      await this._preguntaApi.postPregunta(this.pregunta);
                      showAlertDialog(
                          context: context,
                          title: "Pregunta",
                          message:
                              "Su pregunta fue enviada correctamente, pronto un experto dara respuesta.",
                          level: LEVEL_INFO,
                          onPressed: () {
                            Navigator.of(context).pop();
                          });
                    } on Exception catch (e) {
                      showAlertDialog(
                        context: context,
                        title: "Pregunta",
                        message: "Error inesperado $e",
                        level: LEVEL_ERROR,
                      );
                    }
                  }
                },
              ),
            ]),
      ),
    );
  }
}
