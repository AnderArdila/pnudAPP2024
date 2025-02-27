// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Ruta.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Ruta _$RutaFromJson(Map<String, dynamic> json) {
  return new Ruta(
    idRutas: json['id_rutas'] as num,
    idPersonaDe: json['id_persona_de'] as int,
    nombreR: json['nombreR'] as String,
    descripcion: json['descripcion'] as String,
    latitud: json['latitud'] as String,
    longitud: json['longitud'] as String,
    kilometraje: double.parse(json['kilometraje']),
    gasolina: double.parse(json['gasolina']),
    peaje: double.parse(json['peaje']),
    paradas: double.parse(json['paradas']),
    conductor: double.parse(json['conductor']),
    auxiliar: double.parse(json['auxiliar']),
    desgaste: double.parse(json['desgaste']),
  );
}

abstract class _$RutaSerializerMixin {
  num get idRutas;
  int get idPersonaDe;

  String get nombreR;
  String get descripcion;
  double get kilometraje;
  double get gasolina;
  double get peaje;
  double get paradas;
  double get conductor;
  double get auxiliar;
  double get desgaste;
  String get latitud;
  String get longitud;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id_rutas': idRutas,
        'id_persona_de': idPersonaDe,
        'nombreR': nombreR,
        'descripcion': descripcion,
        'kilometraje': kilometraje,
        'gasolina': gasolina,
        'peaje': peaje,
        'paradas': paradas,
        'conductor': conductor,
        'auxiliar': auxiliar,
        'desgaste': desgaste,
        'latitud': latitud,
        'longitud': longitud
      };
}
