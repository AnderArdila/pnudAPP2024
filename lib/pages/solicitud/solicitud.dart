import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../api/SolicitudApi.dart';
import '../../constants.dart';
import '../../model/Persona.dart';
import '../../model/Solicitud.dart';
import '../../model/TipoServicio.dart';
import '../../widget/persona_widget.dart';
import '../../widget/stack_icon.dart';
import '../../widget/dialog.dart';

class SolicitudPage extends StatelessWidget {
  final Persona solicitante;

  final Persona solicitado;

  final Solicitud solicitud;

  final SolicitudApi solicitudApi = new SolicitudApi();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  SolicitudPage({Key key, this.solicitante, this.solicitado, this.solicitud})
      : super(key: key);

  Widget _buildFloatingActionButton(BuildContext context) {
    List<PopupMenuItem<String>> menuItems = new List<PopupMenuItem<String>>();
    if (solicitante != null) {
      //La esta viendo el solicitante
      if (solicitud.fechaVisto == null && solicitud.fechaResuelta == null) {
        menuItems.add(PopupMenuItem<String>(
          value: 'delete',
          child: new Text("Eliminar"),
        ));
      }
    } else {
      //La esta viendo el solicitado
      if (solicitud.fechaVisto == null) {
        menuItems.add(PopupMenuItem<String>(
          value: 'visto',
          child: new Text("Ver: Estamos verificando su solicitud."),
        ));
      }
      if (solicitud.fechaResuelta == null) {
        menuItems.add(PopupMenuItem<String>(
          value: 'resuelta',
          child: new Text("Resuelta: Ya resolvimos su solicitud."),
        ));
      }
    }
    if (menuItems.isEmpty) {
      return null;
    } else {
      return FloatingActionButton(
        child: PopupMenuButton<String>(
          onSelected: (item) async {
            switch (item) {
              case 'visto':
                {
                  SnackBar snackbar = new SnackBar(
                    content: Text("Actualizando solicitud..."),
                    duration: Duration(seconds: 2),
                  );
                  _scaffoldKey.currentState.showSnackBar(snackbar);
                  //
                  solicitud.textoVisto = "Estamos verificando su solicitud";
                  try {
                    await solicitudApi.putSolicitud(
                        solicitud.idSolicitud, solicitud);
                    showAlertDialog(
                        context: context,
                        title: "Solicitud",
                        message: "Se actualizo la solicitud.",
                        level: LEVEL_INFO,
                        onPressed: () {
                          Navigator.of(context).pop();
                        });
                  } on Exception catch (e) {
                    showAlertDialog(
                      context: context,
                      title: "Solicitud",
                      message: "Error inesperado $e",
                      level: LEVEL_ERROR,
                    );
                  }
                }
                break;
              case 'resuelta':
                {
                  SnackBar snackbar = new SnackBar(
                    content: Text("Actualizando solicitud..."),
                    duration: Duration(seconds: 2),
                  );
                  _scaffoldKey.currentState.showSnackBar(snackbar);
                  solicitud.textoResuelta = "Ya resolvimos su solicitud";
                  try {
                    await solicitudApi.putSolicitud(
                        solicitud.idSolicitud, solicitud);
                    showAlertDialog(
                        context: context,
                        title: "Solicitud",
                        message: "Se actualizo la solicitud.",
                        level: LEVEL_INFO,
                        onPressed: () {
                          Navigator.of(context).pop();
                        });
                  } on Exception catch (e) {
                    showAlertDialog(
                      context: context,
                      title: "Solicitud",
                      message: "Error inesperado $e",
                      level: LEVEL_ERROR,
                    );
                  }
                }
                break;
              case 'delete':
                {
                  SnackBar snackbar = new SnackBar(
                    content: Text("Eliminando solicitud..."),
                    duration: Duration(seconds: 2),
                  );
                  _scaffoldKey.currentState.showSnackBar(snackbar);
                  try {
                    await solicitudApi.deleteSolicitud(solicitud.idSolicitud);
                    showAlertDialog(
                        context: context,
                        title: "Solicitud",
                        message: "Se elimino la solicitud.",
                        level: LEVEL_INFO,
                        onPressed: () {
                          Navigator.of(context).pop();
                        });
                  } on Exception catch (e) {
                    showAlertDialog(
                      context: context,
                      title: "Solicitud",
                      message: "Error inesperado $e",
                      level: LEVEL_ERROR,
                    );
                  }
                }
                break;
            }
          },
          itemBuilder: (BuildContext context) {
            return menuItems;
          },
        ),
        onPressed: () {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = new DateFormat("d/M/y H:m:s");
    List<Widget> items = new List<Widget>();
    Persona persona =
        (solicitante != null ? solicitud.solicitado : solicitud.solicitante);
    Color color = COLOR_YELLOW_LIGHT;
    items.add(Padding(
      padding: EdgeInsets.all(10.0),
      child: Text(
        (solicitante != null ? "Solicitado a" : "Solicitado por"),
        textAlign: TextAlign.justify,
        softWrap: true,
        style: Theme.of(context).textTheme.headline,
      ),
    ));
    items.add(Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: new PersonaWidget(
        persona: persona,
        showEstrellas: false,
      ),
    ));
    items.add(Padding(
      padding: EdgeInsets.all(10.0),
      child: Text(
        "Servicios",
        textAlign: TextAlign.justify,
        softWrap: true,
        style: Theme.of(context).textTheme.headline,
      ),
    ));

    for (TipoServicio tipoServicio in this.solicitud.servicios) {
      items.add(Card(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          color: Theme.of(context).canvasColor,
          child: ListTile(
            dense: true,
            title: Text(tipoServicio.nombre),
          )));
    }

    items.add(Padding(
      padding: EdgeInsets.all(10.0),
      child: Text(
        "Estado",
        textAlign: TextAlign.justify,
        softWrap: true,
        style: Theme.of(context).textTheme.headline,
      ),
    ));
    if (solicitud.fechaResuelta != null) {
      color = COLOR_YELLOW_DARK;
      items.add(Card(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          color: Theme.of(context).canvasColor,
          child: ListTile(
            dense: true,
            leading: new StackIcon(
              bgIconData: FontAwesomeIcons.commentAlt,
              iconData: FontAwesomeIcons.check,
            ),
            title: Text(dateFormat.format(solicitud.fechaResuelta)),
            subtitle: solicitud.textoResuelta != null
                ? Text(solicitud.textoResuelta)
                : null,
          )));
    }
    if (solicitud.fechaVisto != null) {
      if (solicitud.fechaResuelta == null) {
        color = COLOR_YELLOW;
      }

      items.add(Card(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          color: Theme.of(context).canvasColor,
          child: ListTile(
            dense: true,
            leading: new StackIcon(
              bgIconData: FontAwesomeIcons.commentAlt,
              iconData: FontAwesomeIcons.eye,
            ),
            title: Text(dateFormat.format(solicitud.fechaVisto)),
            subtitle: solicitud.textoVisto != null
                ? Text(solicitud.textoVisto)
                : null,
          )));
    }
    items.add(Card(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        color: Theme.of(context).canvasColor,
        child: ListTile(
          dense: true,
          leading: new StackIcon(
            bgIconData: FontAwesomeIcons.commentAlt,
            iconData: FontAwesomeIcons.question,
          ),
          title: Text(dateFormat.format(solicitud.fechaEnvio)),
          subtitle:
              solicitud.textoEnvio != null ? Text(solicitud.textoEnvio) : null,
        )));

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: new Text('SOLICITUD'),
        centerTitle: true,
      ),
      body: ListView(
        children: items,
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }
}
