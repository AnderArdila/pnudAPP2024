
import 'package:json_annotation/json_annotation.dart';

part 'Ubicacion.g.dart';

@JsonSerializable()
class Ubicacion extends Object with _$UbicacionSerializerMixin {

  String idUbicacion;

  String nombre;

  double latitud;

  double longitud;

  Ubicacion padre;

  Ubicacion({this.idUbicacion, this.nombre, this.latitud, this.longitud, this.padre});

  factory Ubicacion.fromJson(Map<String, dynamic> json) => _$UbicacionFromJson(json);

  @override
  String toString()  {
    return 'Ubicacion[idUbicacion=$idUbicacion]';
  }

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType)
      return false;
    final Ubicacion typedOther = other;
    return typedOther.idUbicacion == this.idUbicacion;
  }

  @override
  int get hashCode => this.idUbicacion.hashCode;

}