import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../constants.dart';
import '../main.dart';
import '../model/Solicitud.dart';
import 'exception/ApiException.dart';

class SolicitudApi{

  final HttpClient _httpClient = HttpClient();  

  Future<List<Solicitud>> getSolicitudes({num idPersonaDe, num idPersonaPara}) async {
    List<Solicitud> retValue = new List<Solicitud>();
    //    
    String url = BASE_API_URL+"/solicitud?pagination=false";
    if( idPersonaDe != null ){
      url += "&SolicitudSearch[id_persona_de]=$idPersonaDe";      
    }
    if( idPersonaPara != null ){
      url += "&SolicitudSearch[id_persona_para]=$idPersonaPara";
    }
    print("url: $url");
    //
    Uri uri = Uri.parse(Uri.encodeFull(url));
    //
    HttpClientRequest httpRequest = await _httpClient.getUrl(uri);    
    httpRequest.headers.add("Authorization", appToken);
    httpRequest.headers.add("Content-Type", "application/json");
    //
    HttpClientResponse httpResponse = await httpRequest.close();        
    //
    if (httpResponse.statusCode < HttpStatus.badRequest ) {
      await httpResponse.transform(utf8.decoder).join()
        .then(json.decode)
        .then(
          (solicitudes) =>
            solicitudes.forEach( (solicitud) => retValue.add( Solicitud.fromJson(solicitud) ) )
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

  Future<Solicitud> getSolicitud(num idSolicitud) async {    
    Solicitud retValue;
    //
    String url = BASE_API_URL+"/solicitud/$idSolicitud";
    //
    Uri uri = Uri.parse(url);
    //
    HttpClientRequest httpRequest = await _httpClient.getUrl(uri);
    httpRequest.headers.add("Authorization", appToken);
    httpRequest.headers.add("Content-Type", "application/json");
    //
    HttpClientResponse httpResponse = await httpRequest.close();        
    //
    if (httpResponse.statusCode < HttpStatus.badRequest ) {
      await httpResponse.transform(utf8.decoder).join()
              .then(json.decode)
              .then(
                (solicitud) => (retValue = Solicitud.fromJson(solicitud))
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

  Future<void> deleteSolicitud(num idSolicitud) async {        
    //
    String url = BASE_API_URL+"/solicitud/$idSolicitud";
    print(url);
    //
    Uri uri = Uri.parse(url);    
    //
    HttpClientRequest httpRequest = await _httpClient.deleteUrl(uri);
    httpRequest.headers.add("Authorization", appToken);   
    httpRequest.headers.add("Content-Type", "application/json");
    //
    HttpClientResponse httpResponse = await httpRequest.close();        
    //
    if (httpResponse.statusCode < HttpStatus.badRequest ) {
      //Nada porque la respuesta viene vacia
    }
    else{
      await httpResponse.transform(utf8.decoder).join()
        .then(json.decode)
        .then((exception) => ( throw new ApiException.fromJson(exception)));
    } 
  }

  Future<void> postSolicitud(Solicitud solicitud) async {   
    solicitud.fechaEnvio = new DateTime.now();
    solicitud.textoEnvio = "Solicitud de servicios";
    //
    String url = BASE_API_URL+"/solicitud";
    //
    Uri uri = Uri.parse(url); 
    print("$uri");
    //
    HttpClientRequest httpRequest = await _httpClient.postUrl(uri);
    httpRequest.headers.add("Authorization", appToken);   
    httpRequest.headers.add("Content-Type", "application/json");
    //
    httpRequest.add(utf8.encode(json.encode( solicitud )));
    //
    HttpClientResponse httpResponse = await httpRequest.close();        
    //
    if (httpResponse.statusCode < HttpStatus.badRequest ) {
      //Nada porque la respuesta viene vacia... en teoria...      
    }
    else{
      await httpResponse.transform(utf8.decoder).join()
        .then(json.decode)
        .then((exception) => ( throw new ApiException.fromJson(exception)));
    } 
  }

  Future<void> putSolicitud(num idSolicitud, Solicitud solicitud) async {        
    //
    String url = BASE_API_URL+"/solicitud/$idSolicitud";
    print(url);
    //
    Uri uri = Uri.parse(url);
    //
    HttpClientRequest httpRequest = await _httpClient.putUrl(uri);
    httpRequest.headers.add("Authorization", appToken);   
    httpRequest.headers.add("Content-Type", "application/json");
    //    
    print(json.encode( solicitud ));
    httpRequest.add(utf8.encode(json.encode( solicitud )));
    //
    HttpClientResponse httpResponse = await httpRequest.close();        
    //
    if (httpResponse.statusCode < HttpStatus.badRequest ) {
      //Nada porque la respuesta viene vacia... en teoria...      
    }
    else{
      await httpResponse.transform(utf8.decoder).join()
        .then(json.decode)
        .then((exception) => ( throw new ApiException.fromJson(exception)));
    } 
  }

}