import 'package:flutter/material.dart';
import '../../bloc/PersonaBloc.dart';
import '../../model/Persona.dart';
import '../../provider/PersonaBlocProvider.dart';
import '../../widget/persona_widget.dart';
import 'create_solicitud_2.dart';
import 'solicitudes.dart';

class CreateSolicitudPage1 extends StatefulWidget {
  final Persona solicitante;

  CreateSolicitudPage1({Key key, this.solicitante}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _CreateSolicitudPage1State();
}

class _CreateSolicitudPage1State extends State<CreateSolicitudPage1> {
  final PersonaBloc personaBloc = new PersonaBloc(roles: ["GESTOR"]);

  Widget _buildItem(BuildContext context, Persona item) {
    return new PersonaWidget(
      persona: item,
      showEstrellas: false,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CreateSolicitudPage2(
                  solicitado: item, solicitante: widget.solicitante)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SOLICITAR SERVICIO'),
        centerTitle: true,
      ),
      body: PersonaBlocProvider(
        personaBloc: personaBloc,
        child: Container(
          padding: EdgeInsets.all(10.0),
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
              StreamBuilder(
                  stream: personaBloc.personasCount,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
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
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.list, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    new SolicitudesPage(solicitante: widget.solicitante)),
          );
        },
      ),
    );
  }
}
