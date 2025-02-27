import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../model/Persona.dart';
import '../model/Reto.dart';

class RetoPage extends StatelessWidget {
  final Reto reto;
  final DateFormat dateFormat = new DateFormat("d/M/y");

  RetoPage({Key key, @required this.reto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> contentList = <Widget>[
      Text(
        reto.titulo,
        textAlign: TextAlign.center,
        softWrap: true,
        style: Theme.of(context)
            .textTheme
            .headline
            .copyWith(color: !reto.activo ? Colors.black : Colors.grey),
      ),
      Divider(),
      _secondParagraph(
          'Fecha inicial: ', dateFormat.format(reto.fechaInicio), context),
      _secondParagraph(
          'Fecha final: ', dateFormat.format(reto.fechaFin), context),
      _secondParagraph(
          'Número de ganadores: ', '${reto.numeroGanadores}', context),
      Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.all(5.0),
        color: reto.activo ? Colors.white : COLOR_BLACK,
        child: Text(
          "Objetivo",
          style: Theme.of(context)
              .textTheme
              .title
              .copyWith(color: !reto.activo ? Colors.black : Colors.grey),
        ),
      ),
      Text(
        reto.objetivo,
        textAlign: TextAlign.justify,
        softWrap: true,
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.all(5.0),
        color: reto.activo ? Colors.white : COLOR_BLACK,
        child: Text(
          "Responsable",
          style: Theme.of(context)
              .textTheme
              .title
              .copyWith(color: !reto.activo ? Colors.black : Colors.grey),
        ),
      ),
      ListTile(
        leading: ((reto.responsable.imagen != null)
            ? FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                placeholder: 'assets/img/loading.gif',
                image: BASE_IMG_PERSONA_URL + reto.responsable.imagen,
              )
            : ImageIcon(
                AssetImage('assets/${reto.responsable.perfil.idPerfil}.png'
                    .toLowerCase()),
                color: reto.activo ? Colors.black : Colors.grey,
                size: 50.0,
              )),
        title: Text(
          reto.responsable.nombre,
          style: Theme.of(context)
              .textTheme
              .title
              .copyWith(color: reto.activo ? Colors.black : Colors.grey),
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.all(5.0),
        color: reto.activo ? Colors.white : COLOR_BLACK,
        child: Text(
          "Condiciones",
          style: Theme.of(context)
              .textTheme
              .title
              .copyWith(color: !reto.activo ? Colors.black : Colors.grey),
        ),
      ),
      Text(
        reto.condiciones,
        textAlign: TextAlign.justify,
        softWrap: true,
      ),
    ];
    if (!reto.activo) {
      contentList.add(Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.all(5.0),
        color: reto.activo ? Colors.black : Colors.grey,
        child: Text(
          "Ganadores",
          style: Theme.of(context)
              .textTheme
              .title
              .copyWith(color: !reto.activo ? Colors.black : Colors.grey),
        ),
      ));
      for (Persona persona in reto.ganadores) {
        contentList.add(Text(persona.nombre));
        contentList.add(Container(
          margin: EdgeInsets.only(bottom: 15.0),
        ));
      }
    }

    return new Scaffold(
      appBar: new AppBar(
        title: Text('RETO'),
        centerTitle: true,
      ),
      body: Card(
        margin: EdgeInsets.all(10.0),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: new ListView(
            children: contentList,
          ),
        ),
      ),
    );
  }

  Row _secondParagraph(String subtitle, String text, BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            subtitle,
            style: Theme.of(context).textTheme.subtitle,
          ),
          Text(text),
        ]);
  }
}
