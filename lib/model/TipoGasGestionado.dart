import 'Gestion.dart';
import 'TipoGas.dart';

import 'package:json_annotation/json_annotation.dart';

part 'TipoGasGestionado.g.dart';

@JsonSerializable()
class TipoGasGestionado extends Object with _$TipoGasGestionadoSerializerMixin {
  
  Gestion gestion;
  
  TipoGas tipoGas;
  
  /* Gas regenerado reutilizado */  
  double reuso;

  /* Gas recuperado apto para regenerar */
  double regenerado;
  
  /* Gas recuperado no apto para regenerar */
  double noRegenerado;
  
  TipoGasGestionado({this.gestion, this.tipoGas, this.reuso, this.regenerado, this.noRegenerado});

  factory TipoGasGestionado.fromJson(Map<String, dynamic> json) => _$TipoGasGestionadoFromJson(json);

  @override
  String toString()  {
    return 'TipoGasGestionado[gestion=$gestion, tipoGas=$tipoGas]';
  }

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType)
      return false;
    final TipoGasGestionado typedOther = other;
    return typedOther.gestion == this.gestion && typedOther.tipoGas == this.tipoGas;
  }

  @override
  int get hashCode => this.gestion.hashCode + (17 * this.tipoGas.hashCode);
}

