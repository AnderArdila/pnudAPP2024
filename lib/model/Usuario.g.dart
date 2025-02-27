// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Usuario.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Usuario _$UsuarioFromJson(Map<String, dynamic> json) {
  return new Usuario(
      idUsuario: json['id_usuario'] as int,
      correo: json['correo'] as String,
      clave: json['clave'] as String,
      token: json['token'] as String,
      activo: ((json['activo'] as num)==1),
      persona: json['persona'] == null
          ? null
          : new Persona.fromJson(json['persona'] as Map<String, dynamic>),
      );
}

abstract class _$UsuarioSerializerMixin {
  int get idUsuario;
  String get correo;
  String get clave;
  String get token;
  bool get activo;
  Persona get persona;  
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id_usuario': idUsuario,
        'correo': correo,
        'clave': clave,
        //'token': token,
        //'activo': activo ? 1 : 0,
        //'persona': persona,        
      };
}
