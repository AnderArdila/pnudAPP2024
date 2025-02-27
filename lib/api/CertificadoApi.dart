import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';

import '../main.dart';
import '../constants.dart';
import '../model/Certificado.dart';
import '../model/Persona.dart';
import 'exception/ApiException.dart';

class CertificadoApi{

  final HttpClient _httpClient = HttpClient();  


  Future<List<Certificado>> getCertificados(Persona persona) async {
    List<Certificado> retValue = new List<Certificado>();
    //
    String url = BASE_API_URL+"/certificado?pagination=false&CertificadoSearch[id_persona]=${persona.idPersona}";    
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
                (certificados) =>
                  certificados.forEach( (certificado) => retValue.add( Certificado.fromJson(certificado) ) )
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

  Future<void> postCertificado(Certificado certificado) async {        
    //
    String url = BASE_API_URL+"/certificado";
    //
    Uri uri = Uri.parse(url);
    //
    MultipartRequest httpRequest = new MultipartRequest("POST", uri);
    if( appToken != null ){
      httpRequest.headers["Authorization"] = appToken;      
    }
    //
    httpRequest.fields['id_persona'] = "${certificado.persona.idPersona}";    
    httpRequest.files.add(
      new MultipartFile(
        "imageFile", 
        (new ByteStream(DelegatingStream.typed(certificado.imageFile.openRead()))), 
        (await certificado.imageFile.length()),
        filename: basename(certificado.imageFile.path),
      )
    );
    StreamedResponse httpResponse = await httpRequest.send();        
    //
    if (httpResponse.statusCode < HttpStatus.badRequest ) {
      //Nada porque la respuesta viene vacia... en teoria...      
    }
    else{ 
      await httpResponse.stream.transform(utf8.decoder).join()
        .then(json.decode)
        .then((exception) => ( throw new ApiException.fromJson(exception)));        
    } 
  }


}