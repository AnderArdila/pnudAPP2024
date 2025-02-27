import 'Persona.dart';

import 'package:json_annotation/json_annotation.dart';

part 'Reto.g.dart';

@JsonSerializable()
class Reto extends Object with _$RetoSerializerMixin {
  
  num idReto;
  
  Persona responsable;
  
  bool aprobado;

  bool activo;
  
  DateTime fechaInicio;
  
  DateTime fechaFin;
  
  num numeroGanadores;
  
  String titulo;

  String objetivo;
  
  String condiciones;
  
  List<Persona> ganadores = [];
  
  Reto({this.idReto, this.responsable, this.aprobado, this.activo, this.fechaInicio, this.fechaFin, this.numeroGanadores, this.titulo, this.objetivo, this.condiciones, this.ganadores});

  factory Reto.fromJson(Map<String, dynamic> json) => _$RetoFromJson(json);

  @override
  String toString()  {
    return 'Reto[idReto=$idReto]';
  }

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType)
      return false;
    final Reto typedOther = other;
    return typedOther.idReto == this.idReto;
  }

  @override
  int get hashCode => this.idReto.hashCode;
}

