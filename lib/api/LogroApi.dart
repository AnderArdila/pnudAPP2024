import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../constants.dart';
import '../model/Logro.dart';
import 'exception/ApiException.dart';

class LogroApi{

  final HttpClient _httpClient = HttpClient();  

  Future<Logro> getLogro({num idPersonaEnt, num idPersonaGes, num idGestion}) async {    
    Logro retValue;
    //
    String url = BASE_API_URL+"/logro?pagination=false";
    if(idPersonaEnt!=null){
      url += "&LogroSearch[id_persona_ent]=$idPersonaEnt";
    }
    if(idPersonaGes!=null){
      url += "&LogroSearch[id_persona_ges]=$idPersonaGes";
    }
    if(idGestion!=null){
      url += "&LogroSearch[id_gestion]=$idGestion";
    }
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
                (logros) => logros.forEach( (logro) => (retValue = Logro.fromJson(logro)) )
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