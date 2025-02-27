import 'Ubicacion.dart';
import 'Telefono.dart';
import 'Perfil.dart';
import 'Usuario.dart';

import 'package:json_annotation/json_annotation.dart';

part 'Persona.g.dart';

@JsonSerializable()
class Persona extends Object with _$PersonaSerializerMixin {

  int idPersona;
  
  num identificacion;

  Perfil perfil;
   
  String nombre;
  
  Ubicacion ubicacion;
  
  double latitud;
  
  double longitud;
  
  String imagen;

  Persona personaPadre;

  bool experto;
    
  List<Telefono> telefonos = [];

  Usuario usuario;


  Persona({
      this.idPersona, this.identificacion, this.nombre, this.perfil, 
      this.latitud, this.longitud, this.ubicacion, 
      this.imagen,
      this.usuario, this.telefonos,
      this.experto,
      this.personaPadre
    });

  factory Persona.fromJson(Map<String, dynamic> json) => _$PersonaFromJson(json);

  @override
  String toString()  {
    return 'Persona[idPersona=$idPersona]';
  }

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType)
      return false;
    final Persona typedOther = other;
    return typedOther.idPersona == this.idPersona;
  }

  @override
  int get hashCode => this.idPersona.hashCode;

}