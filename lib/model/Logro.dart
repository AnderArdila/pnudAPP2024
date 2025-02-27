import 'package:json_annotation/json_annotation.dart';

part 'Logro.g.dart';

@JsonSerializable()
class Logro extends Object with _$LogroSerializerMixin {

  double estrellas;
  
  double co2;
  
  double o3;
  
  /* Gas regenerado reutilizado */  
  double reuso;

  /* Gas recuperado apto para regenerar */
  double regenerado;
  
  /* Gas recuperado no apto para regenerar */
  double noRegenerado;

  Logro({this.estrellas, this.co2, this.o3, this.reuso, this.regenerado, this.noRegenerado});

  factory Logro.fromJson(Map<String, dynamic> json) => _$LogroFromJson(json);

  @override
  String toString()  {
    return 'Logro[estrellas=$estrellas, co2=$co2, o3=$o3';
  }

}