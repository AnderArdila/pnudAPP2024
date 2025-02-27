import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location/location.dart';
import 'package:latlong/latlong.dart';
import 'dart:math';

import 'logros.dart';
import 'mapa_body.dart';
import 'menu.dart';
import '../app_bloc_provider.dart';
import '../bloc/MensajesBloc.dart';
import '../widget/dialog.dart';

class MapaPage extends StatefulWidget {
  final List<String> idPerfiles = ["CA", "CR", "RIOR"];
  @override
  State<StatefulWidget> createState() => _MapaPageState(idPerfiles: idPerfiles);
}

class _MapaPageState extends State<MapaPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final GlobalKey<MapaBodyState> _mapaBodyKey = new GlobalKey<MapaBodyState>();

  List<String> idPerfiles = new List<String>();

  final Location _location = new Location();

  _MapaPageState({List<String> idPerfiles}) {
    for (String idPerfil in idPerfiles) {
      this.idPerfiles.add(idPerfil);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MensajesBloc mensajesBloc = AppBlocProvider.mensajesBlocOf(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('GESTIONE SU GAS REFRIGERANTE'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).pushNamed('/gestores');
            },
          )
        ],
      ),
      drawer: Menu(),
      body: Stack(
        children: <Widget>[
          MapaBody(key: _mapaBodyKey),
          Positioned(right: 0.0, top: 10.0, child: new LogrosPage()),
          StreamBuilder(
              stream: mensajesBloc.messagesCount,
              builder: (BuildContext buildContext, AsyncSnapshot snapshot) {
                //if((snapshot.data ?? 0) == 0 ){
                //  return Container(width: 0, height: 0,);
                //}
                return Positioned(
                  left: 10.0,
                  top: 10.0,
                  child: Container(
                    child: GestureDetector(
                      onTap: () => Navigator.of(buildContext)
                          .pushNamed('/notificaciones'),
                      child: Badge(
                        badgeContent: Text(
                          '${snapshot.data ?? 0}',
                          style: TextStyle(
                            color: Colors.blueAccent,
                          ),
                        ),
                        badgeColor: Colors.white,
                        child: Icon(Icons.notifications_none,
                            size: 30.0, color: Colors.blueAccent),
                      ),
                    ),
                    /* child: BadgeIconButton(
                      itemCount: snapshot.data ?? 0,
                      badgeColor: Colors.white,
                      badgeTextColor: Colors.blueAccent,
                      icon: Icon(Icons.notifications_none,
                          size: 30.0, color: Colors.blueAccent),
                      onPressed: () {
                        Navigator.of(buildContext).pushNamed('/notificaciones');
                      },
                    ), */
                  ),
                );
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black38,
          child: Icon(Icons.my_location, color: Colors.white),
          onPressed: () async {
            String message;
            try {
              if (await _location.hasPermission() != null) {
                LocationData location = await _location.getLocation();
                LatLng cameraPosition =
                    LatLng(location.latitude, location.longitude);
                _mapaBodyKey.currentState
                    .panTo(cameraPosition: cameraPosition, zoom: 13.0);
              } else {
                message =
                    'Debes autorizar el uso de la ubicación para usar esta funcionalidad';
              }
            } catch (pe) {
              message =
                  "Debes autorizar el uso de la ubicación para usar esta funcionalidad";
              print("error ${pe}");
            }
            if (message != null) {
              showAlertDialog(
                  context: context,
                  title: "Ubicación",
                  message: message,
                  level: LEVEL_ERROR);
            }
          }),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: 3,
        onTap: (index) {
          switch (index) {
            case 0:
              {
                Navigator.of(context).pushNamed('/verdes');
              }
              break;
            case 1:
              {
                Navigator.of(context).pushNamed('/retos');
              }
              break;
            case 2:
              {
                Navigator.of(context).pushNamed('/noticias');
              }
              break;
            case 3:
              {
                Navigator.of(context).pushNamed('/calculadora');
              }
              break;
          }
        },
        items: <BottomNavigationBarItem>[
          _createBottomNavBarItem(FontAwesomeIcons.envira, 'VERDES'),
          BottomNavigationBarItem(
              icon: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  child: Image(
                      image: AssetImage('assets/support.png'), width: 30)),
              title: Padding(
                  padding: EdgeInsets.only(top: 3),
                  child: Text('RETOS', style: TextStyle(color: Colors.white)))),
          BottomNavigationBarItem(
              icon: Transform.rotate(
                  angle: pi / 5,
                  child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.notifications_none,
                          color: Theme.of(context).primaryColor, size: 30))),
              title: Padding(
                  padding: EdgeInsets.only(top: 3),
                  child:
                      Text('NOTICIAS', style: TextStyle(color: Colors.white)))),
          _createBottomNavBarItem(Icons.star, 'ESTRELLAS')
        ],
      ),
    );
  }

  BottomNavigationBarItem _createBottomNavBarItem(IconData icon, String text) {
    return BottomNavigationBarItem(
        icon: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            child: Icon(icon, color: Theme.of(context).primaryColor, size: 30)),
        title: Padding(
          padding: EdgeInsets.only(top: 3),
          child: Text(text, style: TextStyle(color: Colors.white)),
        ));
  }
}
