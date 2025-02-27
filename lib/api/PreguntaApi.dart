import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../constants.dart';
import '../main.dart';
import '../model/Pregunta.dart';
import 'exception/ApiException.dart';



class PreguntaApi{

  final HttpClient _httpClient = HttpClient();  

  Future<List<Pregunta>> getPreguntas() async {
    List<Pregunta> retValue = new List<Pregunta>();
    //
    String url = BASE_API_URL+"/pregunta?pagination=true&sort=-id_pregunta";        
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
                (preguntas) =>
                  preguntas.forEach( (pregunta) => retValue.add( Pregunta.fromJson(pregunta) ) )
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

  Future<Pregunta> getPregunta(num idPregunta) async {
    Pregunta retValue = new Pregunta();
    //
    String url = BASE_API_URL+"/pregunta/$idPregunta";
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
                (pregunta) => retValue = Pregunta.fromJson(pregunta)                  
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

  Future<void> postPregunta(Pregunta pregunta) async {        
    //
    String url = BASE_API_URL+"/pregunta";
    print("url: $url");
    //
    Uri uri = Uri.parse(url);
    //
    HttpClientRequest httpRequest = await _httpClient.postUrl(uri);
    httpRequest.headers.add("Authorization", appToken);
    httpRequest.headers.add("Content-Type", "application/json"); 
    //        
    httpRequest.add(utf8.encode( json.encode( pregunta )));
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

  Future<void> putPregunta(num idPregunta, Pregunta pregunta) async {        
    //
    String url = BASE_API_URL+"/pregunta/$idPregunta";
    //
    print("url: $url");
    Uri uri = Uri.parse(Uri.encodeFull(url));
    //    
    HttpClientRequest httpRequest = await _httpClient.putUrl(uri);
    httpRequest.headers.add("Authorization", appToken);
    httpRequest.headers.add("Content-Type", "application/json");
    //
    httpRequest.add(utf8.encode(json.encode( pregunta )));
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