import 'package:flutter/material.dart';

import '../../bloc/PersonaBloc.dart';

import '../../model/Persona.dart';
import '../../provider/PersonaBlocProvider.dart';
import '../../widget/persona_widget.dart';
import 'persona.dart';

class PersonasPage extends StatefulWidget {
  final String titulo;

  final List<String> roles;

  final String orden;

  PersonasPage({this.titulo, this.roles, this.orden});

  @override
  _PersonasPageState createState() => new _PersonasPageState(
      personaBloc: new PersonaBloc(roles: this.roles, sort: this.orden));
}

class _PersonasPageState extends State<PersonasPage> {
  final PersonaBloc personaBloc;

  _PersonasPageState({this.personaBloc});

  Widget _buildItem(BuildContext context, Persona persona) {
    return PersonaWidget(
        persona: persona,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PersonaPage(persona: persona)),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(this.widget.titulo),
          centerTitle: true,
        ),
        body: PersonaBlocProvider(
          personaBloc: personaBloc,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    hintText: 'Buscar...',
                    suffixIcon: Icon(Icons.search),
                  ),
                  onSubmitted: (newValue) {
                    personaBloc.query.add(newValue);
                  },
                ),
                Divider(),
                StreamBuilder(
                    stream: personaBloc.personasCount,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Resultados: ${snapshot?.data}",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      );
                    }),
                Flexible(
                    child: StreamBuilder(
                  stream: personaBloc.personas,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
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
        ));
  }
}
