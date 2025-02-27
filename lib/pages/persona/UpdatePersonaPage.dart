import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../model/Persona.dart';

class UpdatePersonaPage extends StatefulWidget {
  final Persona persona;

  UpdatePersonaPage({Key key, this.persona}) : super(key: key);

  @override
  State<UpdatePersonaPage> createState() => new _UpdatePersonaPageState();
}

class _UpdatePersonaPageState extends State<UpdatePersonaPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> _formInfoKey = new GlobalKey<FormState>();
  final GlobalKey<FormState> _formImgKey = new GlobalKey<FormState>();
  final GlobalKey<FormState> _formTelKey = new GlobalKey<FormState>();
  final GlobalKey<FormState> _formEmailKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: Text(this.widget.persona.perfil.nombre),
        centerTitle: true,
        actions: <Widget>[IconButton(icon: Icon(Icons.save), onPressed: () {})],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(5.0),
            child: Form(
              key: _formInfoKey,
              child: Column(
                children: <Widget>[
                  Divider(),
                  Text(
                    "Información basica",
                    style: Theme.of(context).textTheme.headline,
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Su nombre o razón social',
                          labelText: 'Nombre o razón social'),
                      maxLength: 150,
                      autocorrect: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Por favor ingrese un valor';
                        } else if (value.length < 3) {
                          return 'Por favor ingrese un valor de 3 o más caracteres';
                        } else {
                          return null;
                        }
                      },
                      initialValue: (this.widget.persona.nombre ?? ""),
                      onSaved: (String value) {
                        this.widget.persona.nombre = value;
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.all(5.0),
            child: Form(
              key: _formImgKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Divider(),
                  Text(
                    "Teléfonos",
                    style: Theme.of(context).textTheme.headline,
                  ),
                  Divider(),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: this.widget.persona.telefonos.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(FontAwesomeIcons.phone),
                        title: TextFormField(
                            decoration: InputDecoration(
                              hintText: '#########',
                            ),
                            autofocus: true,
                            keyboardType: TextInputType.phone,
                            maxLength: 15,
                            autocorrect: true,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Por favor ingrese un número de teléfono';
                              }
                              if (value.length < 7) {
                                return 'Por favor ingrese un número de teléfono valido';
                              }
                              try {
                                int.parse(value);
                              } on Exception catch (e) {
                                print(e);
                                return 'Por favor ingrese un número de teléfono valido';
                              }
                            },
                            initialValue: (this
                                        .widget
                                        .persona
                                        .telefonos
                                        .isNotEmpty &&
                                    this.widget.persona.telefonos[index] != null
                                ? this
                                    .widget
                                    .persona
                                    .telefonos[index]
                                    .numero
                                    .toString()
                                : ""),
                            onSaved: (String value) {
                              this.widget.persona.telefonos[index].numero =
                                  int.parse(value);
                            }),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
