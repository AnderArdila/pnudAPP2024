
import 'package:json_annotation/json_annotation.dart';

part 'Noticia.g.dart';

@JsonSerializable()
class Noticia extends Object with _$NoticiaSerializerMixin {

  num idNoticia;
  
  DateTime fechaPublicacion;  

  String titulo;
  
  String descripcion;
  
  String url;
  
  String imagen;
  
  bool activo;
  
  Noticia({this.idNoticia, this.fechaPublicacion, this.titulo, this.descripcion, this.url, this.imagen, this.activo});

  factory Noticia.fromJson(Map<String, dynamic> json) => _$NoticiaFromJson(json);

  @override
  String toString()  {
    return 'Noticia[idNoticia=$idNoticia]';
  }

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType)
      return false;
    final Noticia typedOther = other;
    return typedOther.idNoticia == this.idNoticia;
  }

  @override
  int get hashCode => this.idNoticia.hashCode;

}