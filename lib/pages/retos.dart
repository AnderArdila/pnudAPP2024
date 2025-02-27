import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../api/RetoApi.dart';
import '../model/Reto.dart';
import 'reto.dart';

class RetosPage extends StatelessWidget {
  final RetoApi retoApi = new RetoApi();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget _buildActiveItem(BuildContext context, Reto reto) {
    Duration _duration = reto.fechaFin.difference(new DateTime.now());
    return Container(
        decoration: BoxDecoration(color: Colors.grey[200]),
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(reto.titulo,
                      style: Theme.of(context).textTheme.headline),
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.query_builder),
                    Text(' ${_duration.inDays} dias')
                  ],
                ),
              ],
            ),
            Divider(
              color: Colors.black,
            ),
            Text(
              reto.objetivo,
              textAlign: TextAlign.justify,
              softWrap: true,
            ),
            SizedBox(height: 15),
            FlatButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              shape: StadiumBorder(),
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new RetoPage(reto: reto),
                  ),
                );
              },
              child: Text("VER TÉRMINOS Y CONDICIONES"),
            ),
          ],
        ));
  }

  Widget _buildInActiveItem(BuildContext context, Reto reto) {
    final DateFormat dateFormat = new DateFormat("d/M/y");
    return new Card(
        margin: EdgeInsets.all(5.0),
        child: new Container(
          padding: EdgeInsets.all(10.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                reto.titulo,
                textAlign: TextAlign.center,
                softWrap: true,
                style: Theme.of(context).textTheme.headline,
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(dateFormat.format(reto.fechaInicio)),
                  Text(" - "),
                  Text(dateFormat.format(reto.fechaFin)),
                ],
              ),
              Divider(),
              Text(
                reto.objetivo,
                textAlign: TextAlign.justify,
                softWrap: true,
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    elevation: 10.0,
                    child: Text("Ver ganadores"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => new RetoPage(reto: reto),
                        ),
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget _buildTabView(BuildContext context, bool activos) {
    return FutureBuilder(
      future: this.retoApi.getRetos(activos),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            if (snapshot.hasError) {
              _showError(context, '${snapshot.error}');
              return Text('');
            } else {
              if (snapshot.data.length == 0) {
                _showError(
                    context,
                    "No hay retos " +
                        (activos ? "activos" : "inactivos") +
                        " en este momento... intenta de nuevo más tarde");
                return Text('');
              }
              return new ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return activos
                      ? _buildActiveItem(context, snapshot.data[index])
                      : _buildInActiveItem(context, snapshot.data[index]);
                },
              );
            }
        }
      },
    );
  }

  void _showError(BuildContext context, String message) {
    Future.delayed(
        Duration.zero,
        () => showDialog(
            context: context,
            builder: (BuildContext dialogBuildContext) {
              return new AlertDialog(
                title: Text("Retos"),
                content: Text(
                  message,
                  // style: TextStyle(color: Theme.of(context).errorColor),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Entendido"),
                    onPressed: () {
                      Navigator.of(dialogBuildContext).pop();
                    },
                  ),
                ],
              );
            }));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("RETOS"),
          centerTitle: true,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.whatshot, color: Colors.black87)),
              Tab(
                  icon: Icon(FontAwesomeIcons.fireExtinguisher,
                      color: Colors.black87))
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            _buildTabView(context, true),
            _buildTabView(context, false),
          ],
        ),
      ),
    );
  }
}
