import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../constants.dart';
import '../model/Reto.dart';
import 'exception/ApiException.dart';



class RetoApi{  

  final HttpClient _httpClient = HttpClient();

  Future<List<Reto>> getRetos([bool activo]) async {    
    List<Reto> retValue = new List<Reto>();
    //
    //String url = BASE_API_URL+"/reto?activo=${activo??''}";
    String url = BASE_API_URL+"/reto?RetoSearch[estado]=${activo?'activo':'finalizado'}";
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
                (retos) =>
                  retos.forEach( (reto) => retValue.add( Reto.fromJson(reto) ) )
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

  Future<Reto> getReto(num idReto) async {    
    Reto retValue = new Reto();
    //    
    String url = BASE_API_URL+"/reto/$idReto";
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
                (reto) => retValue = Reto.fromJson(reto)                  
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