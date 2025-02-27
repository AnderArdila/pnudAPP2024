
import 'package:json_annotation/json_annotation.dart';

part 'TipoGas.g.dart';

@JsonSerializable()
class TipoGas extends Object with _$TipoGasSerializerMixin {
  
  String idTipoGas;
  
  bool activo;
  
  /* Factor para el calculo de las estrellas del gas regenerado reutilizado */
  double factorEstrellasReuso;
  
  /* Factor para el calculo de las estrellas del gas recuperado apto para regenerar */
  double factorEstrellasRegenerado;

  /* Factor para el calculo de las estrellas del gas recuperado no apto para regenerar */  
  double factorEstrellasNoRegenerado;

  /* Factor para el calculo del Co2 del gas regenerado reutilizado */
  double factorCo2Reuso;
  /* Factor para el calculo del Co2 del gas recuperado apto para regenerar */
  double factorCo2Regenerado;

  /* Factor para el calculo del Co2 del gas recuperado no apto para regenerar */
  double factorCo2NoRegenerado;

  /* Factor para el calculo del O3 del gas regenerado reutilizado */
  double factorO3Reuso;

  /* Factor para el calculo del O3 del gas recuperado apto para regenerar */
  double factorO3Regenerado;

  /* Factor para el calculo del O3 del gas recuperado no apto para regenerar */
  double factorO3NoRegenerado;
   // range from 0 to //
  TipoGas({
      this.idTipoGas, this.activo, 
      this.factorEstrellasReuso, this.factorEstrellasRegenerado, this.factorEstrellasNoRegenerado,
      this.factorCo2Reuso, this.factorCo2Regenerado, this.factorCo2NoRegenerado,
      this.factorO3Reuso, this.factorO3Regenerado, this.factorO3NoRegenerado,
    });

  factory TipoGas.fromJson(Map<String, dynamic> json) => _$TipoGasFromJson(json);

  @override
  String toString()  {
    return 'TipoGas[idTipoGas=$idTipoGas]';
  }

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType)
      return false;
    final TipoGas typedOther = other;
    return typedOther.idTipoGas == this.idTipoGas;
  }

  @override
  int get hashCode => this.idTipoGas.hashCode;

}