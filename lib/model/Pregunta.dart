import 'Persona.dart';

import 'package:json_annotation/json_annotation.dart';

part 'Pregunta.g.dart';

@JsonSerializable()
class Pregunta extends Object with _$PreguntaSerializerMixin {

  int idPregunta;
  
  Persona persona;

  String texto;  

  String respuesta; 

  List<Pregunta> respuestas = [];
  
  Pregunta({
      this.idPregunta,
      this.persona, this.texto,
      this.respuestas
    });

  factory Pregunta.fromJson(Map<String, dynamic> json) => _$PreguntaFromJson(json);

  @override
  String toString()  {
    return 'Pregunta[idPregunta=$idPregunta]';
  }

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType)
      return false;
    final Pregunta typedOther = other;
    return typedOther.idPregunta == this.idPregunta;
  }

  @override
  int get hashCode => this.idPregunta.hashCode;

}