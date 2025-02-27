// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Gestion.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Gestion _$GestionFromJson(Map<String, dynamic> json) {
  return new Gestion(
      idGestion: json['id_gestion'] as num,
      horaFecha: json['hora_fecha'] == null
          ? null
          : DateTime.parse(json['hora_fecha'] as String),
      personaQueEntrega: json['personaEnt'] == null
          ? new Persona(idPersona: json['id_persona_ent'] as num)
          : new Persona.fromJson(json['personaEnt'] as Map<String, dynamic>),
      personaQueGestiona: json['personaGes'] == null
          ? new Persona(idPersona: json['id_persona_ges'])
          : new Persona.fromJson(json['personaGes'] as Map<String, dynamic>),
      tiposGasGestionados: json['gestionGas'] == null 
        ? []
        : (json['gestionGas'] as List)
          ?.map((e) => e == null 
              ? null
              : new TipoGasGestionado.fromJson(e as Map<String, dynamic>))
          ?.toList()      
    );
}

abstract class _$GestionSerializerMixin {
  num get idGestion;
  DateTime get horaFecha;
  Persona get personaQueEntrega;
  Persona get personaQueGestiona;
  List<TipoGasGestionado> get tiposGasGestionados;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id_gestion': idGestion,
        'hora_fecha': (horaFecha==null ? new DateTime.now() : horaFecha).toIso8601String(),
        'id_persona_ent': personaQueEntrega.idPersona,
        'id_persona_ges': personaQueGestiona.idPersona,
        'gestionGas': tiposGasGestionados
      };
}
