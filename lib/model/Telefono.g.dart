// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Telefono.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Telefono _$TelefonoFromJson(Map<String, dynamic> json) {
  return new Telefono(
      persona: new Persona(idPersona: json['id_persona'] as num ),
      numero: num.tryParse(json['numero'] as String) 
    );
}

abstract class _$TelefonoSerializerMixin {
  Persona get persona;
  int get numero;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{
        'persona': persona, 
        'numero': numero
      };
}
