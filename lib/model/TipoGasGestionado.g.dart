// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TipoGasGestionado.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

TipoGasGestionado _$TipoGasGestionadoFromJson(Map<String, dynamic> json) {
  return new TipoGasGestionado(
      gestion: json['gestion'] == null
          ? new Gestion(idGestion: json['id_gestion'] as num)
          : new Gestion.fromJson(json['gestion'] as Map<String, dynamic>),
      tipoGas: json['tipoGas'] == null
          ? new TipoGas(idTipoGas: json['id_tipo_gas'] as String)
          : new TipoGas.fromJson(json['tipoGas'] as Map<String, dynamic>),
      reuso: num.tryParse(json['gas_reu'] as String)?.toDouble(),
      regenerado: num.tryParse(json['gas_reg'] as String)?.toDouble(),
      noRegenerado: num.tryParse(json['gas_nre'] as String)?.toDouble());
}

abstract class _$TipoGasGestionadoSerializerMixin {
  Gestion get gestion;
  TipoGas get tipoGas;
  double get reuso;
  double get regenerado;
  double get noRegenerado;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id_gestion': gestion?.idGestion,
        'id_tipo_gas': tipoGas.idTipoGas,
        'gas_reu': reuso,
        'gas_reg': regenerado,
        'gas_nre': noRegenerado
      };
}
