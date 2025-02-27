import 'Persona.dart';
import 'TipoGasGestionado.dart';

import 'package:json_annotation/json_annotation.dart';

part 'Gestion.g.dart';

@JsonSerializable()
class Gestion extends Object with _$GestionSerializerMixin {

  num idGestion;
  
  DateTime horaFecha;
  
  Persona personaQueEntrega;
  
  Persona personaQueGestiona;
  
  List<TipoGasGestionado> tiposGasGestionados = [];
  
  Gestion({this.idGestion, this.horaFecha, this.personaQueEntrega, this.personaQueGestiona, this.tiposGasGestionados});

  factory Gestion.fromJson(Map<String, dynamic> json) => _$GestionFromJson(json);

  @override
  String toString()  {
    return 'Gestion[idGestion=$idGestion]';
  }

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType)
      return false;
    final Gestion typedOther = other;
    return typedOther.idGestion == this.idGestion;
  }

  @override
  int get hashCode => this.idGestion.hashCode;
}