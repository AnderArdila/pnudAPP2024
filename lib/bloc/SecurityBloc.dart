import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../api/SecurityApi.dart';
import '../model/Persona.dart';
import '../model/Usuario.dart';

class SecurityBloc{

  final SecurityApi _securityApi  = new SecurityApi();  
  final Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();
  
  Future<Usuario> login(String username, String password) async {
    Usuario usuario = await _securityApi.loginByUsernameAndPassword(username, password);
    if( usuario != null ){
      _currentUserController.add(usuario);
    }
    return usuario;
  }

  Future<Usuario> autologin() async{
    Usuario usuario;
    final SharedPreferences sharedPreferences = await _sharedPreferences;
    String token = sharedPreferences.getString("Authorization");
    if(token != null){
      print("Token recuperado: $token");
      try{
        Usuario usuario = await _securityApi.loginByToken(token);
        if( usuario != null ){
          _currentUserController.add(usuario);
        }
      } on Exception catch( e ){
        await sharedPreferences.remove("Authorization");
        print("autologin paila $e");        
      }
      
    }
    return usuario;
  }

  Future<Usuario> logout(){
    _currentUserController.add(null);
    return null;
  }

  final StreamController<Usuario> _currentUserController = new StreamController<Usuario>();

  final BehaviorSubject<Persona> _persona = BehaviorSubject<Persona>();

  Stream<Persona> get persona => this._persona.stream;

  SecurityBloc(){
    _currentUserController.stream.listen(
        (usuario) async {
          final SharedPreferences sharedPreferences = await _sharedPreferences;
          print("llego un usuario $usuario");
          if( usuario != null ){
            print("El token es ${usuario.token}");
            appToken = "Bearer "+usuario.token;
            await sharedPreferences.setString("Authorization", appToken);          
            usuario.persona.usuario = usuario;
            _persona.add(usuario.persona);
          }
          else{
            appToken = null;
            await sharedPreferences.remove("Authorization").then( (res) => _persona.add(null) );            
          }
        }
    );
    this.autologin();
  }  

  void dispose(){    
    _currentUserController.close();    
    _persona.close();
  }
  
}