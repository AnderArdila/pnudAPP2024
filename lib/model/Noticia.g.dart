// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Noticia.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Noticia _$NoticiaFromJson(Map<String, dynamic> json) {
  return new Noticia(
      idNoticia: json['id_noticia'] as num,
      fechaPublicacion: json['fecha_publicacion'] == null ? null : DateTime.parse(json['fecha_publicacion'] as String),
      titulo: json['titulo'] as String,
      descripcion: json['descripcion'] as String,
      url: json['url'] as String,
      imagen: json['imagen'] as String,
      activo: (json['activo'] as num)==1,
    );
}

abstract class _$NoticiaSerializerMixin {
  num get idNoticia;
  DateTime get fechaPublicacion;
  String get titulo;
  String get descripcion;
  String get url; 
  String get imagen;
  bool get activo;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id_noticia': idNoticia,        
        'fecha_publicacion': fechaPublicacion?.toIso8601String(),
        'titulo': titulo,
        'descripcion': descripcion,
        'url': url,
        'imagen': imagen,
        'activo': activo?1:0,
      };
}
