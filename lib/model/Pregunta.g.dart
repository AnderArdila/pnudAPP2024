// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Pregunta.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Pregunta _$PreguntaFromJson(Map<String, dynamic> json) {
  return new Pregunta(
      idPregunta: json['id_pregunta'] as int,
      texto: json['texto'] as String,
      persona: json['persona'] == null
          ? new Persona(idPersona: json['id_persona'])
          : new Persona.fromJson(json['persona'] as Map<String, dynamic>),      
      respuestas: json['respuestas'] == null 
        ? []        
        : (json['respuestas'] as List)
          ?.map((e) => e == null
              ? null
              : new Pregunta.fromJson(e as Map<String, dynamic>))
          ?.toList(),
  );
}

abstract class _$PreguntaSerializerMixin {
  int get idPregunta;  
  String get texto;
  Persona get persona;
  String get respuesta;  
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id_pregunta': idPregunta,
        'id_persona': persona.idPersona,
        'texto': texto,        
        'respuesta': respuesta,
      };
}
