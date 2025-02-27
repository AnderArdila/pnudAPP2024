import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../bloc/PersonaBloc.dart';
import '../../model/Persona.dart';
import '../../provider/PersonaBlocProvider.dart';
import '../../widget/persona_widget.dart';
import 'create_gestion_2.dart';
import 'gestiones.dart';

class CreateGestionPage1 extends StatefulWidget {
  final Persona personaQueGestiona;

  CreateGestionPage1({Key key, this.personaQueGestiona}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _CreateGestionPage1State();
}

class _CreateGestionPage1State extends State<CreateGestionPage1> {
  final PersonaBloc personaBloc = new PersonaBloc(
      roles: ["USUARIO", "TECNICO", "GESTOR"], sort: "-id_perfil");

  //Persona persona;

  Widget _buildItem(BuildContext context, Persona item) {
    return new PersonaWidget(
      persona: item,
      showDocument: true,
      showEstrellas: false,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CreateGestionPage2(
                  personaQueEntrega: item,
                  personaQueGestiona: widget.personaQueGestiona)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REGISTRAR GESTIÓN'),
        centerTitle: true,
      ),
      body: new PersonaBlocProvider(
        personaBloc: personaBloc,
        child: new Container(
          padding: EdgeInsets.all(10.0),
          child: new Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "1. Seleccione al técnico, empresa de mantenimiento o usuario final.",
                  textAlign: TextAlign.justify,
                  softWrap: true,
                  style: Theme.of(context).textTheme.headline,
                ),
              ),
              Card(
                  child: new ListTile(
                title: TextField(
                  decoration: null,
                  onSubmitted: (newValue) {
                    personaBloc.query.add(newValue);
                  },
                ),
                trailing: Icon(FontAwesomeIcons.search),
              )),
              Divider(),
              StreamBuilder(
                  stream: personaBloc.personasCount,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text("Resultados: ${snapshot?.data}"),
                      ),
                    );
                  }),
              Flexible(
                  child: StreamBuilder(
                stream: personaBloc.personas,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      {
                        return Center(
                          child: Text("..."),
                        );
                      }
                      break;
                    case ConnectionState.waiting:
                      {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    default:
                      {
                        if (snapshot.hasError) {
                          return Center(
                            child: new Text(
                              'Error: ${snapshot.error}',
                              style: Theme.of(context).textTheme.headline,
                            ),
                          );
                        } else {
                          return new ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return this
                                  ._buildItem(context, snapshot.data[index]);
                            },
                          );
                        }
                      }
                  }
                },
              ))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.list),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    new GestionesPage(persona: widget.personaQueGestiona)),
          );
        },
      ),
    );
  }
}
