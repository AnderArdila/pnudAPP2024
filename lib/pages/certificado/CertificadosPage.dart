import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../model/Persona.dart';
import '../../model/Certificado.dart';

import '../../api/CertificadoApi.dart';
import '../../widget/dialog.dart';
import 'CreateCertificadoPage.dart';

class CertificadosPage extends StatelessWidget {
  final Persona persona;

  CertificadosPage({this.persona});

  final CertificadoApi certificadoApi = new CertificadoApi();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final DateFormat dateFormat = new DateFormat('dd/MM/yyyy');
  final DateFormat dateTimeFormat = new DateFormat('dd/MM/yyyy HH:mm:ss');

  Widget _buildItem(BuildContext context, Certificado certificado) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: ListTile(
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Fecha inicial'),
                  Text(
                      certificado.fechaInicial != null
                          ? dateFormat.format(certificado.fechaInicial)
                          : '',
                      style: Theme.of(context).textTheme.caption)
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Fecha final"),
                  Text(
                      certificado.fechaFinal != null
                          ? dateFormat.format(certificado.fechaFinal)
                          : "",
                      style: Theme.of(context).textTheme.caption)
                ],
              ),
              Divider(),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Fecha revisión"),
                    Text(
                      certificado.fechaRevision != null
                          ? dateTimeFormat.format(certificado.fechaRevision)
                          : "Sin revisar",
                      style: Theme.of(context).textTheme.caption,
                    )
                  ])
            ],
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            certificado.valido
                ? Icon(Icons.check, color: Colors.green)
                : Icon(Icons.close, color: Colors.red)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text("CERTIFICADOS"),
        centerTitle: true,
      ),
      key: _scaffoldKey,
      body: new FutureBuilder(
        future: this.certificadoApi.getCertificados(persona),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasError) {
                showAlertDialog(
                  context: context,
                  title: "Certificados",
                  message: "Error inesperado ${snapshot.error}",
                  level: LEVEL_ERROR,
                );
                return Divider();
              } else {
                if (snapshot.data.length == 0) {
                  return Center(
                      child: Text("No se han anexado certificados, aun."));
                }
                return new ListView.builder(
                  // padding: EdgeInsets.all(5.0),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return this._buildItem(context, snapshot.data[index]);
                  },
                );
              }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(FontAwesomeIcons.certificate, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateCertificadoPage(persona: persona)),
          );
        },
      ),
    );
  }
}
