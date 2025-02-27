
import 'package:json_annotation/json_annotation.dart';

import 'Persona.dart';

part 'Usuario.g.dart';

@JsonSerializable()
class Usuario extends Object with _$UsuarioSerializerMixin {

  int idUsuario;
  
  String correo;

  String clave;

  String token;

  bool activo;  

  Persona persona;  

  Usuario({this.idUsuario, this.correo, this.clave, this.token, this.activo, this.persona});

  factory Usuario.fromJson(Map<String, dynamic> json) => _$UsuarioFromJson(json);

  @override 
  String toString()  {
    return 'Usuario[idUsuario=$idUsuario]';
  }

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType)
      return false;
    final Usuario typedOther = other;
    return typedOther.idUsuario == this.idUsuario;
  }

  @override
  int get hashCode => this.idUsuario.hashCode;

}