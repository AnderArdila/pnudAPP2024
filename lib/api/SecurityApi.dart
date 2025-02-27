import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../main.dart';
import '../constants.dart';
import '../model/Usuario.dart';
import 'exception/ApiException.dart';

class SecurityApi{

  final HttpClient _httpClient = HttpClient();

  Future<Usuario> loginByUsernameAndPassword(String username, String password) async {
    Usuario retValue;
    //
    String url = BASE_API_URL+"/login";
    print("url: $url");
    //
    Uri uri = Uri.parse(url);
    //
    HttpClientRequest httpRequest = await _httpClient.postUrl(uri);
    httpRequest.headers.add("Content-Type", "application/json");
    if( fcmKey != null ){
      httpRequest.headers.add("FCM", fcmKey);
    }
    //    
    httpRequest.add(utf8.encode(json.encode( new _User(username: username, password: password))));
    //      
    final httpResponse = await httpRequest.close();        
    //
    if (httpResponse.statusCode < HttpStatus.badRequest ) {
      await httpResponse.transform(utf8.decoder).join()
              .then(json.decode)
              .then(
                (usuario) => (retValue = Usuario.fromJson(usuario))
              );
    }
    else{
      await httpResponse.transform(utf8.decoder).join()
        .then(json.decode)
        .then((exception) => (throw new ApiException.fromJson(exception)));
    } 
    //
    return retValue;
  }


  Future<Usuario> loginByToken(String token) async {
    Usuario retValue;
    //
    String url = BASE_API_URL+"/token";
    //
    Uri uri = Uri.parse(url);
    //
    HttpClientRequest httpRequest = await _httpClient.postUrl(uri);
    httpRequest.headers.add("Content-Type", "application/json");
    httpRequest.headers.add("Authorization", token);
    if( fcmKey != null ){
      httpRequest.headers.add("FCM", fcmKey);
    }

    //      
    final httpResponse = await httpRequest.close();        
    //
    if (httpResponse.statusCode < HttpStatus.badRequest ) {
      await httpResponse.transform(utf8.decoder).join()
              .then(json.decode)
              .then(
                (usuario) => (retValue = Usuario.fromJson(usuario))
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

  Future<void> recoverPassword(String username) async{
    //
    String url = BASE_API_URL+"/recover";
    print("url: $url");
    //
    Uri uri = Uri.parse(url);
    //
    HttpClientRequest httpRequest = await _httpClient.postUrl(uri);
    httpRequest.headers.add("Content-Type", "application/json");
    //    
    httpRequest.add(utf8.encode('{"email": "$username"}'));
    //      
    final httpResponse = await httpRequest.close();        
    //    
    if (httpResponse.statusCode < HttpStatus.badRequest ) {
      //Nada...
    }
    else{
      await httpResponse.transform(utf8.decoder).join()
        .then(json.decode)
        .then((exception) => (throw new ApiException.fromJson(exception)));
    } 
  }

}


class _User{

  String username;

  String password;

  _User({this.username, this.password});

   Map<String, dynamic> toJson() =>
   {
      'username': username,
      'password': password,
   };

}