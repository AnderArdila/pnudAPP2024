import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../constants.dart';
import '../model/Perfil.dart';
import 'exception/ApiException.dart';



class PerfilApi{  

  final HttpClient _httpClient = HttpClient();  

  Future<List<Perfil>> getPerfiles({List<String> roles}) async {    
    List<Perfil> retValue = new List<Perfil>();
    //
    String url = BASE_API_URL+"/perfil?pagination=false";    
    if(roles!=null){      
      for(String rol in roles){
        url += "&PerfilSearch[rol][]=$rol";
      }      
    }
    print(url);
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
                (perfiles) =>
                  perfiles.forEach( (perfil) => retValue.add( Perfil.fromJson(perfil) ) )
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

  Future<Perfil> getPerfil(String idPerfil) async {    
    Perfil retValue;
    //
    String url = BASE_API_URL+"/perfil?PerfilSearch[id_perfil]=$idPerfil&expand=servicios";        
    print(url);    
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
                (perfiles) => perfiles.forEach( (perfil) => (retValue = Perfil.fromJson(perfil)) )
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