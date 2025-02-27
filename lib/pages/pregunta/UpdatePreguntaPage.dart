import 'package:flutter/material.dart';

import '../../model/Persona.dart';
import '../../model/Pregunta.dart';
import '../../api/PreguntaApi.dart';
import '../../constants.dart';
import '../../widget/dialog.dart';

class UpdatePreguntaPage extends StatefulWidget {
  final Persona persona;

  final Pregunta pregunta;

  UpdatePreguntaPage({Key key, this.persona, this.pregunta}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _UpdatePreguntaPageState();
}

class _UpdatePreguntaPageState extends State<UpdatePreguntaPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final PreguntaApi _preguntaApi = new PreguntaApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RESPONDER PREGUNTA"),
        centerTitle: true,
      ),
      key: _scaffoldKey,
      body: Form(
        key: this._formKey,
        child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(20.0),
            children: <Widget>[
              Text(
                widget.pregunta.persona.nombre,
                softWrap: true,
                style: Theme.of(context).textTheme.caption,
                textAlign: TextAlign.left,
              ),
              Text(
                widget.pregunta.texto,
                softWrap: true,
                style: Theme.of(context).textTheme.display1,
                textAlign: TextAlign.center,
              ),
              Divider(),
              TextFormField(
                decoration: InputDecoration(labelText: 'Respuesta'),
                keyboardType: TextInputType.multiline,
                autovalidate: true,
                maxLength: 1000,
                maxLines: null,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Por favor ingrese una respuesta';
                  }
                },
                onSaved: (String value) {
                  widget.pregunta.respuesta = value;
                },
              ),
              Divider(),
              RaisedButton(
                child: Text(
                  'Enviar respuesta',
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(fontSize: 20.0, color: COLOR_YELLOW),
                ),
                color: Theme.of(context).accentColor,
                elevation: 10.0,
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    try {
                      await this._preguntaApi.putPregunta(
                          widget.pregunta.idPregunta, widget.pregunta);
                      showAlertDialog(
                          context: context,
                          title: "Respuesta",
                          message: "Gracias por su respuesta.",
                          level: LEVEL_INFO,
                          onPressed: () {
                            Navigator.of(context).pop();
                          });
                    } on Exception catch (e) {
                      showAlertDialog(
                        context: context,
                        title: "Respuesta",
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
