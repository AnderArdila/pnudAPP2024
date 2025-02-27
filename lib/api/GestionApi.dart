import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../constants.dart';
import '../main.dart';
import '../model/Gestion.dart';
import '../model/Persona.dart';
import 'exception/ApiException.dart';

class GestionApi{

  final HttpClient _httpClient = HttpClient();  

  Future<List<Gestion>> getGestiones(Persona persona) async {
    List<Gestion> retValue = new List<Gestion>();
    //
    String url = BASE_API_URL+"/gestion?pagination=false&sort=-id_gestion";
    print("url: $url");
    //            
    Uri uri = Uri.parse(Uri.encodeFull(url));
    //
    HttpClientRequest httpRequest = await _httpClient.getUrl(uri);
    if( appToken != null ){
      httpRequest.headers.add("Authorization", appToken);
    }
    httpRequest.headers.add("Content-Type", "application/json");
    //
    HttpClientResponse httpResponse = await httpRequest.close();         
    //
    if (httpResponse.statusCode < HttpStatus.badRequest ) {
      await httpResponse.transform(utf8.decoder).join()
              .then(json.decode)
              .then(
                (gestiones) =>
                  gestiones.forEach( (gestion) => retValue.add( Gestion.fromJson(gestion) ) )
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
  
  Future<Gestion> getGestion(num idGestion) async {
    Gestion retValue = new Gestion();
    //
    String url = BASE_API_URL+"/gestion/$idGestion";
    print("url: $url");
    //            
    Uri uri = Uri.parse(Uri.encodeFull(url));
    //
    HttpClientRequest httpRequest = await _httpClient.getUrl(uri);
    if( appToken != null ){
      httpRequest.headers.add("Authorization", appToken);
    }
    httpRequest.headers.add("Content-Type", "application/json");
    //
    HttpClientResponse httpResponse = await httpRequest.close();         
    //
    if (httpResponse.statusCode < HttpStatus.badRequest ) {
      await httpResponse.transform(utf8.decoder).join()
              .then(json.decode)
              .then(
                (gestion) =>  retValue = Gestion.fromJson(gestion)
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

  Future<void> deleteGestion(num idGestion) async {        
    //
    String url = BASE_API_URL+"/gestion/$idGestion";
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

  Future<void> postGestion(Gestion gestion) async {        
    //
    String url = BASE_API_URL+"/gestion";
    print("url: $url");
    //
    Uri uri = Uri.parse(url);
    //
    HttpClientRequest httpRequest = await _httpClient.postUrl(uri);
    httpRequest.headers.add("Authorization", appToken);   
    httpRequest.headers.add("Content-Type", "application/json");
    //
    httpRequest.add(utf8.encode(json.encode( gestion )));
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

  Future<void> putGestion(num idGestion, Gestion gestion) async {        
    //
    String url = BASE_API_URL+"/gestion/$idGestion";
    print(url);
    //
    Uri uri = Uri.parse(url);
    //
    HttpClientRequest httpRequest = await _httpClient.putUrl(uri);
    httpRequest.headers.add("Authorization", appToken);   
    httpRequest.headers.add("Content-Type", "application/json");
    //
    httpRequest.add(utf8.encode(json.encode( gestion )));
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