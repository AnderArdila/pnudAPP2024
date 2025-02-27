// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Perfil.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Perfil _$PerfilFromJson(Map<String, dynamic> json) {
  return new Perfil(
      idPerfil: json['id_perfil'] as String,
      nombre: json['nombre'] as String,
      rol: json['rol'] as String,
      servicios: (json['servicios'] as List)
          ?.map((e) => e == null
              ? null
              : new TipoServicio.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

abstract class _$PerfilSerializerMixin {
  String get idPerfil;
  String get nombre;
  List<TipoServicio> get servicios;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id_perfil': idPerfil,
        'nombre': nombre,
        //'servicios': servicios
      };
}
