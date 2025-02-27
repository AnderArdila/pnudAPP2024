import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../constants.dart';
import '../model/Ubicacion.dart';
import 'exception/ApiException.dart';



class UbicacionApi{  

  final HttpClient _httpClient = HttpClient();  

  Future<List<Ubicacion>> getDepartamentos() async {    
    List<Ubicacion> retValue = new List<Ubicacion>();
    //
    String url = BASE_API_URL+"/ubicacion?pagination=false&UbicacionSearch[padre]=1";
    print("url: $url");
    //
    Uri uri = Uri.parse(Uri.encodeFull(url));
    //
    HttpClientRequest httpRequest = await _httpClient.getUrl(uri);
    httpRequest.headers.add("Content-Type", "application/json");
    //
    HttpClientResponse httpResponse = await httpRequest.close();        
    //
    if (httpResponse.statusCode < HttpStatus.badRequest ) {
      await httpResponse.transform(utf8.decoder).join()
              .then(json.decode)
              .then(
                (departamentos) =>
                  departamentos.forEach( (ubicacion) => retValue.add( Ubicacion.fromJson(ubicacion) ) )
              );
    }
    else{
      await httpResponse.transform(utf8.decoder).join()
        .then(json.decode)
        .then((exception) => ( throw new ApiException.fromJson(exception)));
    } 
    //
    return retValue;
  }

  Future<List<Ubicacion>> getMunicipios(String idUbicacionPadre) async {    
    List<Ubicacion> retValue = new List<Ubicacion>();
    //
    //String url = BASE_API_URL+"/municipio/{idUbicacionPadre}".replaceAll("{" + "idUbicacionPadre" + "}", idUbicacionPadre.toString());
    String url = BASE_API_URL+"/ubicacion?pagination=false&UbicacionSearch[id_ubicacion_padre]="+idUbicacionPadre;
    print("url: $url");
    //
    Uri uri = Uri.parse(Uri.encodeFull(url));    
    //
    HttpClientRequest httpRequest = await _httpClient.getUrl(uri);
    httpRequest.headers.add("Content-Type", "application/json");
    //
    HttpClientResponse httpResponse = await httpRequest.close();        
    //
    if (httpResponse.statusCode < HttpStatus.badRequest ) {
      await httpResponse.transform(utf8.decoder).join()
              .then(json.decode)
              .then(
                (municipios) =>
                  municipios.forEach( (ubicacion) => retValue.add( Ubicacion.fromJson(ubicacion) ) )
              );
    }
    else{
      await httpResponse.transform(utf8.decoder).join()
        .then(json.decode)
        .then((exception) => ( throw new ApiException.fromJson(exception)));
    } 
    //
    return retValue;
  }

}