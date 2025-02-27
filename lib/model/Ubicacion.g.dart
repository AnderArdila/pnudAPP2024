// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Ubicacion.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Ubicacion _$UbicacionFromJson(Map<String, dynamic> json) {
  return new Ubicacion(
      idUbicacion: json['id_ubicacion'] as String,
      nombre: json['nombre'] as String,
      latitud: num.tryParse(json['latitud'] as String)?.toDouble(),
      longitud: num.tryParse(json['longitud'] as String)?.toDouble(),
      padre: json['ubicacionPadre'] == null
          ? new Ubicacion(idUbicacion: json['id_ubicacion_padre'] )
          : new Ubicacion.fromJson(json['ubicacionPadre'] as Map<String, dynamic>));
}

abstract class _$UbicacionSerializerMixin {
  String get idUbicacion;
  String get nombre;
  double get latitud;
  double get longitud;
  Ubicacion get padre;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id_ubicacion': idUbicacion,
        //'nombre': nombre,
        //'latitud': latitud,
        //'longitud': longitud,
        //'id_ubicacion_padre' : padre.idUbicacion,
        //'ubicacionPadre': padre
      };
}
