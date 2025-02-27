// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TipoServicio.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

TipoServicio _$TipoServicioFromJson(Map<String, dynamic> json) {
  return new TipoServicio(
      idTipoServicio: json['id_tipo_servicio'] as String,
      nombre: json['nombre'] as String,
      observaciones: json['observaciones'] as String);
}

abstract class _$TipoServicioSerializerMixin {
  String get idTipoServicio;
  String get nombre;
  String get observaciones;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id_tipo_servicio': idTipoServicio,
        'nombre': nombre,
        'observaciones': observaciones
      };
}
