// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Logro.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Logro _$LogroFromJson(Map<String, dynamic> json) {
  return new Logro(      
    estrellas: num.tryParse(json['estrellas']??'0')?.toDouble(),
    co2: num.tryParse(json['co2']??'0')?.toDouble(),
    o3: num.tryParse(json['o3']??'0')?.toDouble(),
    reuso: num.tryParse(json['gas_reu']??'0')?.toDouble(),
    regenerado: num.tryParse(json['gas_reg']??'0')?.toDouble(),
    noRegenerado: num.tryParse(json['gas_nre']??'0')?.toDouble(),
  );
}

abstract class _$LogroSerializerMixin {  
  double get estrellas;
  double get co2;
  double get o3;
  double get reuso;
  double get regenerado;
  double get noRegenerado;
  Map<String, dynamic> toJson() => <String, dynamic>{        
        'estrellas': estrellas,
        'co2': co2,
        'o3': o3,
        'gas_reu':reuso,
        'gas_reg':regenerado,
        'gas_nre':noRegenerado,
      };
}
