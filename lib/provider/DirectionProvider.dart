import 'dart:async';
import 'package:latlong/latlong.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class DirectionProvider {
  String _apiKey =
      'pk.eyJ1IjoianVhZGlnYSIsImEiOiJja2UxZ2t4dTQzMmZ5MnRudXN4b2FsZDJsIn0.yUPwhlcf-5SUW1MQ52jJWg';
  String _url = 'https://api.mapbox.com/optimized-trips/v1/mapbox/driving';

  Future<List<LatLng>> cargarRuta(
      LatLng desde, LatLng hasta, List<LatLng> paradas) async {
    String from = '${desde.longitude},${desde.latitude}';
    String to = '${hasta.longitude},${hasta.latitude}';

    String uri = '$_url/$from;';

    paradas.forEach((p) {
      uri += '${p.longitude},${p.latitude};';
    });

    uri +=
        '$to?source=first&destination=last&roundtrip=false&steps=true&access_token=$_apiKey';

    List<LatLng> result = List<LatLng>();

    // print('Mapbox URL: $uri');
    final response = await http.get(uri);
    if (response?.statusCode == 200) {
      var parsedJson = json.decode(response.body);
      if (parsedJson["code"]?.toLowerCase() == "ok" &&
          parsedJson["trips"] != null &&
          parsedJson["trips"].isNotEmpty) {
        final data = parsedJson["trips"][0]["legs"];
        result = _procesarRespuest(data);
      } else {}
    }

    return result;
  }

  _procesarRespuest(List legs) {
    List<LatLng> result = List<LatLng>();
    legs.forEach((leg) {
      leg['steps'].forEach((element) {
        element['intersections'].forEach((e) {
          LatLng p = new LatLng(
              (e['location'][1]).toDouble(), (e['location'][0]).toDouble());
          result.add(p);
        });
      });
    });
    return result;
  }
}
