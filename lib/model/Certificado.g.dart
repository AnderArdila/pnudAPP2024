// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Certificado.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Certificado _$CertificadoFromJson(Map<String, dynamic> json) {
  return new Certificado(
      idCertificado: json['id_certificado'] as num,
      valido: ((json['valido'] as num)==1),
      persona: json['persona'] == null
          ? new Persona(idPersona: json['id_persona'] as num)
          : new Persona.fromJson(json['persona'] as Map<String, dynamic>),
      imagen: json['imagen'] as String,
      fechaInicial: json['fecha_inicial'] == null
          ? null
          : DateTime.parse(json['fecha_inicial'] as String),
      fechaFinal: json['fecha_final'] == null
          ? null
          : DateTime.parse(json['fecha_final'] as String),
      fechaRevision: json['fecha_revision'] == null
          ? null
          : DateTime.parse(json['fecha_revision'] as String),
      );
}

abstract class _$CertificadoSerializerMixin {
  num get idCertificado;
  bool get valido;
  Persona get persona;
  String get imagen;
  DateTime get fechaInicial;
  DateTime get fechaFinal;
  DateTime get fechaRevision;  
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id_certificado': idCertificado,
        'valido': valido?1:0,
        'id_persona': persona.idPersona,
        'imagen': imagen,
        'fecha_inicial': fechaInicial?.toIso8601String(),
        'fecha_final': fechaFinal?.toIso8601String(),
        'fecha_revision': fechaRevision?.toIso8601String(),        
      };
}
