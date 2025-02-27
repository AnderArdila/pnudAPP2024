import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../constants.dart';
import '../model/TipoGas.dart';
import 'exception/ApiException.dart';



class TipoGasApi{  

  final HttpClient _httpClient = HttpClient();  

  Future<List<TipoGas>> getTiposGas() async {    
    List<TipoGas> retValue = new List<TipoGas>();
    //
    String url = BASE_API_URL+"/tipo-gas?pagination=false";
    print("url: $url");
    //
    Uri uri = Uri.parse(url);
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
                (tiposGas) =>
                  tiposGas.forEach( (tipoGas) => retValue.add( TipoGas.fromJson(tipoGas) ) )
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