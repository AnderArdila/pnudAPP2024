import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import '../api/PersonaApi.dart';
import '../model/Persona.dart';
import './persona/persona.dart';

class MapaBody extends StatefulWidget {
  final PersonaApi personaApi = new PersonaApi();
  final MapController mapController = MapController();

  MapaBody({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      MapaBodyState(personaApi: personaApi, mapController: mapController);
}

class MapaBodyState extends State<MapaBody> {
  final PersonaApi personaApi;
  final MapController mapController;

  MapaBodyState({this.personaApi, this.mapController});

  LatLng cameraPosition;

  double zoom;

  List<Marker> marcadores = new List<Marker>();

  @override
  initState() {
    super.initState();
    //4.6316967
    this.cameraPosition = new LatLng(8.0913361, -74.07112440);
    this.zoom = 6.0;
    this.personaApi.getPersonas(
        roles: ["GESTOR"]).then((personas) => this._buildMarkers(personas));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void panTo({LatLng cameraPosition, double zoom}) {
    LatLng newCenter =
        (cameraPosition != null ? cameraPosition : this.cameraPosition);
    double newZoom = (zoom != null ? zoom : this.zoom);
    this.mapController.move(newCenter, newZoom);
  }

  void _buildMarkers(List<Persona> personas) {
    List<Marker> newMarcadores = new List<Marker>();
    print(personas[0]);
    for (Persona persona in personas) {
      newMarcadores.add(new Marker(
          width: 80.0,
          height: 80.0,
          //anchor: AnchorPos.top,
          point: LatLng(persona.latitud, persona.longitud),
          builder: (BuildContext context) {
            return InkWell(
              child: Image.asset(
                  'assets/${persona.perfil.idPerfil}_map.png'.toLowerCase()),
              onTap: () {
                if (this.mapController.zoom < 13.0) {
                  this.setState(() {
                    this.panTo(
                        cameraPosition:
                            LatLng(persona.latitud, persona.longitud),
                        zoom: this.mapController.zoom + 3);
                  });
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PersonaPage(persona: persona)),
                  );
                }
              },
            );
          }));
    }
    setState(() {
      this.marcadores = newMarcadores;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<LayerOptions> layerOptions = List<LayerOptions>();
    layerOptions.add(TileLayerOptions(
      urlTemplate:
          'https://api.mapbox.com/styles/v1/mapbox/{id}/tiles/256/{z}/{x}/{y}?access_token={accessToken}',
      maxZoom: 18.0,
      additionalOptions: {
        'accessToken':
            'pk.eyJ1IjoianVhZGlnYSIsImEiOiJja2UxZ2t4dTQzMmZ5MnRudXN4b2FsZDJsIn0.yUPwhlcf-5SUW1MQ52jJWg',
        'id': 'streets-v11',
      },
    ));
    if (this.marcadores != null && this.marcadores.isNotEmpty) {
      layerOptions.add(
        new MarkerLayerOptions(
          markers: this.marcadores,
        ),
      );
    }
    return new FlutterMap(
      mapController: this.mapController,
      options: MapOptions(
        center: cameraPosition,
        zoom: this.zoom,
        /* onPositionChanged: (MapPosition position) {
            this.cameraPosition = position.center;
            this.zoom = position.zoom;
          } */
      ),
      layers: layerOptions,
    );
  }
}
