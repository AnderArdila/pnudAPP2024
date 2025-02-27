import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../model/Persona.dart';

class RegistroIdentificacion extends StatefulWidget {
  final Persona persona;

  final GlobalKey<FormState> formKey;

  RegistroIdentificacion({Key key, this.persona, this.formKey})
      : super(key: key);

  @override
  _RegistroIdentificacionState createState() =>
      new _RegistroIdentificacionState(
          persona: this.persona, formKey: this.formKey);
}

class _RegistroIdentificacionState extends State<RegistroIdentificacion> {
  final GlobalKey<FormState> formKey;

  Persona persona;

  _RegistroIdentificacionState({this.persona, this.formKey});

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        shrinkWrap: true,
        reverse: true,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.grey),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(
                    FontAwesomeIcons.idCard,
                    color: Colors.white,
                  ),
                  labelText: 'Número identificación (CC ó NIT)',
                  labelStyle: TextStyle(color: Colors.white)),
              autofocus: true,
              autocorrect: true,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Por favor ingrese un valor';
                }
                if (value.length < 5) {
                  return 'Por favor ingrese número de mas de 5 digitos';
                }
                if (value.length > 15) {
                  return 'Limite de digitos es 10';
                }
                try {
                  int.parse(value);
                } on Exception catch (e) {
                  print(e);
                  return 'Por favor ingrese número valido';
                }
              },
              initialValue: (this.persona.identificacion != null
                  ? "${this.persona.identificacion}"
                  : ""),
              onSaved: (String value) {
                this.persona.identificacion = int.parse(value);
              },
            ),
          ),
          SizedBox(height: 10.0),
          Container(
              decoration: BoxDecoration(color: Colors.grey),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(FontAwesomeIcons.solidUserCircle,
                        color: Colors.white),
                    labelText: 'Nombre o razón social',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  autocorrect: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Por favor ingrese un valor';
                    } else if (value.length < 3) {
                      return 'Por favor ingrese un valor de 3 o más caracteres';
                    }
                  },
                  initialValue: (this.persona.nombre ?? ""),
                  onSaved: (String value) {
                    this.persona.nombre = value;
                  })),
        ].reversed.toList(),
      ),
    );
  }
}
