import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:GestioneSuGas/main.dart';
import 'package:GestioneSuGas/model/Ruta.dart';

import '../constants.dart';
import 'exception/ApiException.dart';

class RutaApi {
  final HttpClient _httpClient = HttpClient();

  Future<List<Ruta>> getRutas() async {
    List<Ruta> retValue = new List<Ruta>();
    //
    String url = BASE_API_URL + "/rutapi?sort=-fecha_publicacion";
    print("url: $url");
    //
    Uri uri = Uri.parse(Uri.encodeFull(url));
    //
    HttpClientRequest httpRequest = await _httpClient.getUrl(uri);
    httpRequest.headers.add("Content-Type", "application/json");
    httpRequest.headers.add("Authorization", appToken);
    //
    HttpClientResponse httpResponse = await httpRequest.close();
    //
    if (httpResponse.statusCode < HttpStatus.badRequest) {
      await httpResponse.transform(utf8.decoder).join().then(json.decode).then(
          (rutas) =>
              rutas.forEach((ruta) => retValue.add(Ruta.fromJson(ruta))));
    } else {
      await httpResponse
          .transform(utf8.decoder)
          .join()
          .then(json.decode)
          .then((exception) => (throw new ApiException.fromJson(exception)));
    }
    //
    return retValue;
  }

  Future<Ruta> getRuta(num idRuta) async {
    Ruta retValue = new Ruta();
    //
    String url = BASE_API_URL + "/puntapi/view/?id_rutas=$idRuta";
    print("url: $url");
    //
    Uri uri = Uri.parse(Uri.encodeFull(url));
    //
    HttpClientRequest httpRequest = await _httpClient.getUrl(uri);
    httpRequest.headers.add("Content-Type", "application/json");
    httpRequest.headers.add("Authorization", appToken);
    //
    HttpClientResponse httpResponse = await httpRequest.close();
    //
    if (httpResponse.statusCode < HttpStatus.badRequest) {
      await httpResponse
          .transform(utf8.decoder)
          .join()
          .then(json.decode)
          .then((ruta) {
        retValue = Ruta.fromInicioFin(ruta[0], ruta[1], ruta[2]);
      });
    } else {
      await httpResponse
          .transform(utf8.decoder)
          .join()
          .then(json.decode)
          .then((exception) => (throw new ApiException.fromJson(exception)));
    }
    //
    return retValue;
  }
}
