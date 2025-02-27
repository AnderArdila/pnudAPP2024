// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Solicitud.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Solicitud _$SolicitudFromJson(Map<String, dynamic> json) {
  return new Solicitud(
      idSolicitud: json['id_solicitud'] as num,
      solicitante: json['personaDe'] == null
          ? new Persona(idPersona: json['id_persona_de'] as num) 
          : new Persona.fromJson(json['personaDe'] as Map<String, dynamic>),
      solicitado: json['personaPara'] == null
          ? new Persona(idPersona: json['id_persona_para'] as num) 
          : new Persona.fromJson(json['personaPara'] as Map<String, dynamic>),
      fechaEnvio: json['fecha_envio'] == null
          ? null
          : DateTime.parse(json['fecha_envio'] as String),
      textoEnvio: json['texto_envio'] as String,
      fechaVisto: json['fecha_visto'] == null
          ? null
          : DateTime.parse(json['fecha_visto'] as String),
      textoVisto: json['texto_visto'] as String,
      fechaResuelta: json['fecha_resuelta'] == null
          ? null
          : DateTime.parse(json['fecha_resuelta'] as String),
      textoResuelta: json['texto_resuelta'] as String,
    servicios: json['tipoServicios'] == null 
        ? []
        : (json['tipoServicios'] as List)
          ?.map((e) => e == null 
              ? null
              : new TipoServicio.fromJson(e as Map<String, dynamic>))
          ?.toList()
  );
}

abstract class _$SolicitudSerializerMixin {
  num get idSolicitud;
  Persona get solicitante;
  Persona get solicitado;
  DateTime get fechaEnvio;
  String get textoEnvio;
  DateTime get fechaVisto;
  String get textoVisto;
  DateTime get fechaResuelta;
  String get textoResuelta;
  List<TipoServicio> get servicios;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id_solicitud': idSolicitud,
        'id_persona_de': solicitante.idPersona,
        'id_persona_para': solicitado.idPersona,
        'fecha_envio': fechaEnvio?.toIso8601String(),
        'texto_envio': textoEnvio,
        'fecha_visto': fechaVisto?.toIso8601String(),
        'texto_visto': textoVisto,
        'fecha_resuelta': fechaResuelta?.toIso8601String(),
        'texto_resuelta': textoResuelta,
        'tipoServicios': servicios
      };
}
