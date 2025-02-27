// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Reto.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Reto _$RetoFromJson(Map<String, dynamic> json) {
  return new Reto(
      idReto: json['id_reto'] as num,
      responsable: json['responsable'] == null
          ? new Persona(idPersona: json['id_responsable'] as num)
          : new Persona.fromJson(json['responsable'] as Map<String, dynamic>),
      aprobado: ((json['aprobado'] as num)==1),      
      activo: ((json['estado'] as String)=="activo"),      
      fechaInicio: json['fecha_inicio'] == null
          ? null
          : DateTime.parse(json['fecha_inicio'] as String),
      fechaFin: json['fecha_fin'] == null
          ? null
          : DateTime.parse(json['fecha_fin'] as String),
      numeroGanadores: json['numero_ganadores'] as num,
      titulo: json['titulo'] as String,
      objetivo: json['objetivo'] as String,
      condiciones: json['condiciones'] as String,
      ganadores: json['ganadores'] == null 
        ? []
        : (json['ganadores'] as List)
          ?.map((e) => e == null 
              ? null
              : new Persona.fromJson(e as Map<String, dynamic>))
          ?.toList()
  );    
}

abstract class _$RetoSerializerMixin {
  num get idReto;
  Persona get responsable;
  bool get aprobado;  
  DateTime get fechaInicio;
  DateTime get fechaFin;
  num get numeroGanadores;
  String get titulo;
  String get objetivo;
  String get condiciones;
  List<Persona> get ganadores;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id_reto': idReto,
        'id_responsable': responsable.idPersona,
        'aprobado': aprobado,        
        'fechaInicio': fechaInicio?.toIso8601String(),
        'fechaFin': fechaFin?.toIso8601String(),
        'numeroGanadores': numeroGanadores,
        'titulo': titulo,
        'objetivo': objetivo,
        'condiciones': condiciones,
        'ganadores': ganadores
      };
}
