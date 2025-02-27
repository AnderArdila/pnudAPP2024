import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../constants.dart';
import '../main.dart';
import '../model/Persona.dart';
import 'exception/ApiException.dart';



class PersonaApi{

  final HttpClient _httpClient = HttpClient();  

  Future<List<Persona>> getPersonas({List<String> roles, num identificacion, String query, String sort}) async {
    List<Persona> retValue = new List<Persona>();
    //
    String url = BASE_API_URL+"/persona?pagination=false&expand=perfil,ubicacion";    
    if(roles!=null){      
      for(String rol in roles){
        url += "&PersonaSearch[rol][]=$rol";
      }      
    }
    if(query != null){
      url += "&PersonaSearch[all]=$query";      
    }
    if(identificacion != null){
      url += "&PersonaSearch[identificacion]=$identificacion";
    }
    if(sort != null){
      url += "&sort=$sort";
    }
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
                (personas) =>
                  personas.forEach( (persona) => retValue.add( Persona.fromJson(persona) ) )
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

  Future<Persona> getPersona(num idPersona) async {    
    Persona retValue;
    //
    String url = BASE_API_URL+"/persona/$idPersona";
    //
    print("url: $url");
    Uri uri = Uri.parse(url);
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
                (persona) => (retValue = Persona.fromJson(persona))
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

  Future<void> postPersona(Persona persona) async {        
    //
    String url = BASE_API_URL+"/persona";
    print("url: $url");
    //
    Uri uri = Uri.parse(url);
    //
    HttpClientRequest httpRequest = await _httpClient.postUrl(uri);
    //httpRequest.headers.add("Authorization", appToken); Se supone que no porque se esta registrando
    httpRequest.headers.add("Content-Type", "application/json"); 
    //        
    httpRequest.add(utf8.encode( json.encode( persona )));
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

  Future<void> putPersona(num idPersona, Persona persona) async {        
    //
    String url = BASE_API_URL+"/persona/{idPersona}".replaceAll("{" + "idPersona" + "}", idPersona.toString());
    //
    Uri uri = Uri.parse(url);
    //
    HttpClientRequest httpRequest = await _httpClient.postUrl(uri);
    httpRequest.headers.add("Authorization", appToken);
    httpRequest.headers.add("Content-Type", "application/json");
    //
    httpRequest.add(utf8.encode(json.encode( persona )));
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