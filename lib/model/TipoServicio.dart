
import 'package:json_annotation/json_annotation.dart';

part 'TipoServicio.g.dart';

@JsonSerializable()
class TipoServicio extends Object with _$TipoServicioSerializerMixin {

  String idTipoServicio;

  String nombre;

  String observaciones;

  TipoServicio({this.idTipoServicio, this.nombre, this.observaciones});
  
  factory TipoServicio.fromJson(Map<String, dynamic> json) => _$TipoServicioFromJson(json);

  @override
  String toString()  {
    return 'TipoServicio[idTipoServicio=$idTipoServicio]';
  }

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType)
      return false;
    final TipoServicio typedOther = other;
    return typedOther.idTipoServicio == this.idTipoServicio;
  }

  @override
  int get hashCode => this.idTipoServicio.hashCode;

}