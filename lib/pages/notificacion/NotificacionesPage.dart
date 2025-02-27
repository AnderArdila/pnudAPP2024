import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../api/GestionApi.dart';
import '../../api/NoticiaApi.dart';
import '../../api/PreguntaApi.dart';
import '../../api/RetoApi.dart';
import '../../api/SolicitudApi.dart';

import '../gestion/gestion.dart';
import '../noticia.dart';
import '../pregunta/PreguntaPage.dart';
import '../reto.dart';
import '../solicitud/solicitud.dart';

import '../../model/Persona.dart';
import '../../model/Notificacion.dart';

import '../../app_bloc_provider.dart';

class NotificacionesPage extends StatelessWidget {
  final GestionApi gestionApi = new GestionApi();
  final NoticiaApi noticiaApi = new NoticiaApi();
  final PreguntaApi preguntaApi = new PreguntaApi();
  final RetoApi retoApi = new RetoApi();
  final SolicitudApi solicitudApi = new SolicitudApi();

  @override
  Widget build(BuildContext context) {
    final notificacionesBloc = AppBlocProvider.mensajesBlocOf(context);
    final securityBloc = AppBlocProvider.securityBlocOf(context);
    return new Scaffold(
        appBar: new AppBar(
          title: Text("NOTIFICACIONES"),
          centerTitle: true,
        ),
        body: StreamBuilder<Persona>(
          stream: securityBloc.persona,
          initialData: null,
          builder:
              (BuildContext pBuildContex, AsyncSnapshot<Persona> pSnapshot) {
            return StreamBuilder<List<Notificacion>>(
                stream: notificacionesBloc.messages,
                builder: (BuildContext nBuildContext, AsyncSnapshot nSnapshot) {
                  if (nSnapshot.data != null) {
                    return ListView.builder(
                        itemCount: nSnapshot.data.length,
                        itemBuilder:
                            (BuildContext listBuildContext, int index) {
                          Icon icon;
                          switch (nSnapshot.data[index].tipo) {
                            case "Gestion":
                              {
                                icon = Icon(
                                  FontAwesomeIcons.clipboardCheck,
                                  size: 50.0,
                                );
                              }
                              break;
                            case "Noticia":
                              {
                                icon = Icon(FontAwesomeIcons.newspaper,
                                    size: 50.0, color: Colors.black);
                              }
                              break;
                            case "Pregunta":
                              {
                                icon = Icon(FontAwesomeIcons.questionCircle,
                                    size: 50.0, color: Colors.blue);
                              }
                              break;
                            case "Reto":
                              {
                                icon = Icon(FontAwesomeIcons.trophy,
                                    size: 50.0, color: Colors.red);
                              }
                              break;
                            case "Solicitud":
                              {
                                icon = Icon(FontAwesomeIcons.commentAlt,
                                    size: 50.0);
                              }
                              break;
                            default:
                              {
                                icon = Icon(FontAwesomeIcons.bell,
                                    size: 50.0, color: Colors.blueAccent);
                              }
                              break;
                          }
                          return Card(
                              margin: EdgeInsets.all(5.0),
                              child: ListTile(
                                leading: icon,
                                title: Text(nSnapshot.data[index].titulo),
                                subtitle:
                                    Text(nSnapshot.data[index].descripcion),
                                onTap: () async {
                                  switch (nSnapshot.data[index].tipo) {
                                    case "Gestion":
                                      {
                                        var gestion = await this
                                            .gestionApi
                                            .getGestion(nSnapshot
                                                .data[index].referencia);
                                        await Navigator.push(
                                          nBuildContext,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  new GestionPage(
                                                    gestion: gestion,
                                                    persona: pSnapshot.data,
                                                  )),
                                        );
                                      }
                                      break;
                                    case "Noticia":
                                      {
                                        var noticia = await this
                                            .noticiaApi
                                            .getNoticia(nSnapshot
                                                .data[index].referencia);
                                        await Navigator.push(
                                          nBuildContext,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  new NoticiaPage(
                                                    noticia: noticia,
                                                  )),
                                        );
                                      }
                                      break;
                                    case "Pregunta":
                                      {
                                        var pregunta = await this
                                            .preguntaApi
                                            .getPregunta(nSnapshot
                                                .data[index].referencia);
                                        await Navigator.push(
                                          nBuildContext,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  new PreguntaPage(
                                                    pregunta: pregunta,
                                                    persona: pSnapshot.data,
                                                  )),
                                        );
                                      }
                                      break;
                                    case "Reto":
                                      {
                                        var reto = await this.retoApi.getReto(
                                            nSnapshot.data[index].referencia);
                                        await Navigator.push(
                                          nBuildContext,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  new RetoPage(
                                                    reto: reto,
                                                  )),
                                        );
                                      }
                                      break;
                                    case "Solicitud":
                                      {
                                        var solicitud = await this
                                            .solicitudApi
                                            .getSolicitud(nSnapshot
                                                .data[index].referencia);
                                        await Navigator.push(
                                          nBuildContext,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  new SolicitudPage(
                                                    solicitud: solicitud,
                                                    solicitado: pSnapshot.data
                                                                .perfil.rol ==
                                                            "GESTOR"
                                                        ? pSnapshot.data
                                                        : null,
                                                    solicitante: pSnapshot.data
                                                                .perfil.rol ==
                                                            "GESTOR"
                                                        ? null
                                                        : pSnapshot.data,
                                                  )),
                                        );
                                      }
                                      break;
                                    default:
                                      {}
                                      break;
                                  }
                                  //Elimina el mensaje de notificación
                                  notificacionesBloc
                                      .removeMessage(nSnapshot.data[index]);
                                },
                              ));
                        });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                });
          },
        ));
  }
}
