import 'package:json_annotation/json_annotation.dart';

part 'Notificacion.g.dart';

@JsonSerializable()
class Notificacion extends Object with _$NotificacionSerializerMixin {

  String titulo;
  
  String descripcion;
  
  String tipo;

  num referencia;
  
  Notificacion({this.titulo, this.descripcion, this.tipo, this.referencia});

  factory Notificacion.fromJson(Map<String, dynamic> json) => _$NotificacionFromJson(json);

  @override
  String toString()  {
    return 'Notificacion[tipo=$tipo, referencia=$referencia]';
  }

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType)
      return false;
    final Notificacion typedOther = other;
    return typedOther.hashCode == this.hashCode;
  }

  @override
  int get hashCode => this.tipo.hashCode + 5*this.descripcion.hashCode + 8*this.referencia.hashCode;

}