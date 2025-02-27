import 'Persona.dart';
import 'TipoServicio.dart';

import 'package:json_annotation/json_annotation.dart';

part 'Solicitud.g.dart';

@JsonSerializable()
class Solicitud extends Object with _$SolicitudSerializerMixin {
  
  num idSolicitud;
  
  Persona solicitante;
  
  Persona solicitado;
  
  DateTime fechaEnvio;
  
  String textoEnvio;
  
  DateTime fechaVisto;
  
  String textoVisto;
  
  DateTime fechaResuelta;
  
  String textoResuelta;
  
  List<TipoServicio> servicios = [];
  
  Solicitud({ 
      this.idSolicitud, this.solicitante, this.solicitado, 
      this.fechaEnvio, this.textoEnvio, 
      this.fechaVisto, this.textoVisto, 
      this.fechaResuelta, this.textoResuelta,
      this.servicios
    });

  factory Solicitud.fromJson(Map<String, dynamic> json) => _$SolicitudFromJson(json);

  @override
  String toString()  {
    return 'Solicitud[idSolicitud=$idSolicitud]';
  }

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType)
      return false;
    final Solicitud typedOther = other;
    return typedOther.idSolicitud == this.idSolicitud;
  }

  @override
  int get hashCode => this.idSolicitud.hashCode;
}

