import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tappable_polyline/flutter_map_tappable_polyline.dart';
import 'package:latlong/latlong.dart';
import 'package:intl/intl.dart';

import 'package:GestioneSuGas/model/Ruta.dart';
import 'package:GestioneSuGas/provider/DirectionProvider.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class RutaPage extends StatefulWidget {
  final Ruta ruta;

  RutaPage({@required this.ruta});

  @override
  _RutaPageState createState() => _RutaPageState();
}

class _RutaPageState extends State<RutaPage> {
  final MapController mapController = MapController();
  final oCcy = new NumberFormat("#,##0.00", "en_US");

  LatLng cameraPosition;
  LatLng desde;
  LatLng hasta;
  List<LatLng> paradas = List();

  List<Marker> marcadores = new List<Marker>();

  @override
  initState() {
    super.initState();

    desde = LatLng(
      widget.ruta.inicio.latitud,
      widget.ruta.inicio.longitud,
    );

    hasta = LatLng(
      widget.ruta.fin.latitud,
      widget.ruta.fin.longitud,
    );

    widget.ruta.points.forEach((p) {
      paradas.add(LatLng(p.latitud, p.longitud));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final directionProvider = new DirectionProvider();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.ruta.nombreR),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: directionProvider.cargarRuta(desde, hasta, paradas),
        builder: (context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return _cargarMapa(snapshot.data);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          showMaterialModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context, scrollController) => _modalInfo(),
          );
        },
        child: Icon(
          Icons.info_outline,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _modalInfo() {
    return Container(
      padding: EdgeInsets.all(15),
      height: 260,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${widget.ruta.nombreR}',
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Kilometraje'),
                  Text('${oCcy.format(widget.ruta.kilometraje)} km'),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Gasolina'),
                  Text('\$${oCcy.format(widget.ruta.gasolina)}'),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Peaje'),
                  Text('\$${oCcy.format(widget.ruta.peaje)}'),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Paradas'),
                  Text('\$${oCcy.format(widget.ruta.paradas)}'),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Conductor'),
                  Text('\$${oCcy.format(widget.ruta.conductor)}'),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Auxiliar'),
                  Text('\$${oCcy.format(widget.ruta.auxiliar)}'),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Desgaste'),
                  Text(
                    '\$${oCcy.format(widget.ruta.desgaste)}',
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                'Total: \$${oCcy.format(widget.ruta.total())}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cargarMapa(List<LatLng> data) {
    List<Marker> markers = List<Marker>();
    markers.add(
      Marker(
        width: 80.0,
        height: 80.0,
        point: desde,
        builder: (ctx) => Container(
          child: Icon(
            Icons.location_on,
            color: Colors.green,
          ),
        ),
      ),
    );

    paradas.forEach((element) {
      markers.add(
        Marker(
          point: element,
          builder: (ctx) => Container(
            child: Icon(
              Icons.location_on,
              color: Colors.orange,
            ),
          ),
        ),
      );
    });

    markers.add(
      Marker(
        width: 80.0,
        height: 80.0,
        point: hasta,
        builder: (ctx) => Container(
          child: Icon(
            Icons.location_on,
            color: Colors.red,
          ),
        ),
      ),
    );

    paradas.add(desde);
    paradas.add(hasta);

    return FlutterMap(
      options: MapOptions(
        bounds: _boundsFromLatLngList(paradas),
        boundsOptions: FitBoundsOptions(padding: EdgeInsets.all(20)),
        zoom: 13.0,
        plugins: [
          TappablePolylineMapPlugin(),
        ],
      ),
      layers: [
        TileLayerOptions(
          urlTemplate:
              'https://api.mapbox.com/styles/v1/mapbox/{id}/tiles/256/{z}/{x}/{y}?access_token={accessToken}',
          maxZoom: 18.0,
          additionalOptions: {
            'accessToken':
                'pk.eyJ1IjoianVhZGlnYSIsImEiOiJja2UxZ2t4dTQzMmZ5MnRudXN4b2FsZDJsIn0.yUPwhlcf-5SUW1MQ52jJWg',
            'id': 'streets-v11',
          },
        ),
        TappablePolylineLayerOptions(
          polylines: [
            TaggedPolyline(
              tag: "My Polyline",
              points: data,
              color: Colors.blueGrey,
              strokeWidth: 3.0,
            ),
          ],
          onTap: (TaggedPolyline polyline) => print(polyline.tag),
        ),
        MarkerLayerOptions(
          markers: markers,
        ),
        /* new MarkerLayerOptions(
          markers: [
            new Marker(
              width: 80.0,
              height: 80.0,
              point: new LatLng(51.5, -0.09),
              builder: (ctx) => new Container(
                child: new FlutterLogo(),
              ),
            ),
          ],
        ), */
      ],
    );
  }

  LatLngBounds _boundsFromLatLngList(List<LatLng> list) {
    assert(list.isNotEmpty);
    double x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1) y1 = latLng.longitude;
        if (latLng.longitude < y0) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(LatLng(x1, y1), LatLng(x0, y0));
  }
}
