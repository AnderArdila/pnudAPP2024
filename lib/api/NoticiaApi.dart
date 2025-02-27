import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../constants.dart';
import '../model/Noticia.dart';
import 'exception/ApiException.dart';



class NoticiaApi{  

  final HttpClient _httpClient = HttpClient();

  Future<List<Noticia>> getNoticias() async {    
    List<Noticia> retValue = new List<Noticia>();
    //
    String url = BASE_API_URL+"/noticia?pagination=false&NoticiaSearch[activo]=1&sort=-fecha_publicacion";
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
                (noticias) =>
                  noticias.forEach( (noticia) => retValue.add( Noticia.fromJson(noticia) ) )
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

  Future<Noticia> getNoticia(num idNoticia) async {    
    Noticia retValue = new Noticia();
    //
    String url = BASE_API_URL+"/noticia/$idNoticia";
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
                (noticia) => retValue = Noticia.fromJson(noticia)                  
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