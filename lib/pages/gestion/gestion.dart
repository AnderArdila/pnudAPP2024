import 'package:flutter/material.dart';

import '../../api/GestionApi.dart';
import '../../model/Gestion.dart';
import '../../model/Persona.dart';
import '../../model/TipoGasGestionado.dart';
import '../../widget/persona_widget.dart';
import '../../widget/dialog.dart';

class GestionPage extends StatelessWidget {
  final Persona persona;

  final Gestion gestion;

  final GestionApi gestionApi = new GestionApi();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  GestionPage({Key key, this.persona, this.gestion}) : super(key: key);

  Widget _buildFloatingActionButton(BuildContext context) {
    List<PopupMenuItem<String>> menuItems = new List<PopupMenuItem<String>>();
    if (gestion.personaQueEntrega == persona) {
      //La esta viendo la persona que entrega
    } else {
      //La esta viendo la persona que gestiona
      Duration duration = gestion.horaFecha.difference(new DateTime.now());
      if (duration.abs().inHours < 1) {
        menuItems.add(PopupMenuItem<String>(
          value: 'delete',
          child: new Text("Eliminar"),
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
              case 'delete':
                {
                  try {
                    await gestionApi.deleteGestion(gestion.idGestion);
                    showAlertDialog(
                        context: context,
                        title: "Gestión",
                        message: "Se ha eliminado la gestión.",
                        level: LEVEL_INFO,
                        onPressed: () {
                          Navigator.of(context).pop();
                        });
                  } on Exception catch (e) {
                    showAlertDialog(
                      context: context,
                      title: "Gestión",
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
    List<Widget> items = new List<Widget>();
    Persona persona = (this.persona != gestion.personaQueEntrega
        ? gestion.personaQueGestiona
        : gestion.personaQueEntrega);
    items.add(Padding(
      padding: EdgeInsets.all(10.0),
      child: Text(
        (this.persona != gestion.personaQueEntrega
            ? "Gestionado por"
            : "Entregado por"),
        textAlign: TextAlign.justify,
        softWrap: true,
        style:
            Theme.of(context).textTheme.headline.copyWith(color: Colors.white),
      ),
    ));
    items.add(Container(
      margin: EdgeInsets.all(10.0),
      child: new PersonaWidget(
        persona: persona,
        showDocument: true,
        showEstrellas: false,
      ),
    ));
    items.add(Padding(
      padding: EdgeInsets.all(10.0),
      child: Text(
        "Gases gestionados",
        textAlign: TextAlign.justify,
        softWrap: true,
        style:
            Theme.of(context).textTheme.headline.copyWith(color: Colors.white),
      ),
    ));
    for (TipoGasGestionado tipoGasGestionado in gestion.tiposGasGestionados) {
      items.add(Card(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        color: Theme.of(context).canvasColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Divider(),
            Text(tipoGasGestionado.tipoGas.idTipoGas),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Recuperado apto para regenerar",
                    softWrap: true,
                  ),
                  Text("${tipoGasGestionado.regenerado}")
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Recuperado no apto para regenerar",
                    softWrap: true,
                  ),
                  Text("${tipoGasGestionado.noRegenerado}")
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Regenerado reutilizado",
                    softWrap: true,
                  ),
                  Text("${tipoGasGestionado.reuso}")
                ],
              ),
            ),
            Divider(),
          ],
        ),
      ));
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('GESTION'),
        centerTitle: true,
      ),
      body: ListView(
        children: items,
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }
}
