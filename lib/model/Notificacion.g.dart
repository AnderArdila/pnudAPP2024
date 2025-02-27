// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Notificacion.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Notificacion _$NotificacionFromJson(Map<String, dynamic> json) {
  print("Notificacion -> $json");
  return new Notificacion(
      titulo: json['titulo'] as String,
      descripcion: json['descripcion'] as String,
      tipo: json['tipo'] as String,
      referencia: num.tryParse(json['referencia'] as String)  
    );
}

abstract class _$NotificacionSerializerMixin {
  String get titulo;
  String get descripcion;
  String get tipo; 
  num get referencia;  
  Map<String, dynamic> toJson() => <String, dynamic>{
        'titulo': titulo,
        'descripcion': descripcion,
        'tipo': tipo,
        'referencia': referencia        
      };
}
