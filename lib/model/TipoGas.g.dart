// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TipoGas.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

TipoGas _$TipoGasFromJson(Map<String, dynamic> json) {
  return new TipoGas(
      idTipoGas: json['id_tipo_gas'] as String,
      activo: (json['activo'] as num) == 1,
      factorEstrellasReuso:        num.tryParse(json['fac_est_reu'] as String)?.toDouble(),
      factorEstrellasRegenerado:   num.tryParse(json['fac_est_reg'] as String)?.toDouble(),
      factorEstrellasNoRegenerado: num.tryParse(json['fac_est_nre'] as String)?.toDouble(),
      factorCo2Reuso:              num.tryParse(json['fac_co2_reu'] as String)?.toDouble(),
      factorCo2Regenerado:         num.tryParse(json['fac_co2_reg'] as String)?.toDouble(),
      factorCo2NoRegenerado:       num.tryParse(json['fac_co2_nre'] as String)?.toDouble(),
      factorO3Reuso:               num.tryParse(json['fac_o3_reu'] as String)?.toDouble(),
      factorO3Regenerado:          num.tryParse(json['fac_o3_reg'] as String)?.toDouble(),
      factorO3NoRegenerado:        num.tryParse(json['fac_o3_nre'] as String)?.toDouble());
}

abstract class _$TipoGasSerializerMixin {
  String get idTipoGas;
  bool get activo;
  double get factorEstrellasReuso;
  double get factorEstrellasRegenerado;
  double get factorEstrellasNoRegenerado;
  double get factorCo2Reuso;
  double get factorCo2Regenerado;
  double get factorCo2NoRegenerado;
  double get factorO3Reuso;
  double get factorO3Regenerado;
  double get factorO3NoRegenerado;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id_tipo_gas': idTipoGas,
        'activo': activo,
        'fac_est_reu': factorEstrellasReuso,
        'fac_est_reg': factorEstrellasRegenerado,
        'fac_est_nre': factorEstrellasNoRegenerado,
        'fac_co2_reu': factorCo2Reuso,
        'fac_co2_reg': factorCo2Regenerado,
        'fac_co2_nre': factorCo2NoRegenerado,
        'fac_o3_reu': factorO3Reuso,
        'fac_o3_reg': factorO3Regenerado,
        'fac_o3_nre': factorO3NoRegenerado
      };
}
