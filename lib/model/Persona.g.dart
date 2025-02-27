// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Persona.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Persona _$PersonaFromJson(Map<String, dynamic> json) {
  return new Persona(
      idPersona: json['id_persona'] as int,
      identificacion: num.tryParse( json['identificacion'] ),
      nombre: json['nombre'] as String,
      perfil: json['perfil'] == null
          ? new Perfil(idPerfil: json['id_perfil'])
          : new Perfil.fromJson(json['perfil'] as Map<String, dynamic>),      
      latitud: num.tryParse(json['latitud'] as String)?.toDouble(),
      longitud: num.tryParse(json['longitud'] as String)?.toDouble(),
      ubicacion: json['ubicacion'] == null
          ? new Ubicacion(idUbicacion: json['id_ubicacion'] as String)
          : new Ubicacion.fromJson(json['ubicacion'] as Map<String, dynamic>),      
      imagen: json['imagen'] as String,
      telefonos: json['telefonos'] == null 
        ? []        
        : (json['telefonos'] as List)
          ?.map((e) => e == null
              ? null
              : new Telefono.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      usuario: json['usuario'] == null
          ? null
          : new Usuario.fromJson(json['usuario'] as Map<String, dynamic>),            
      personaPadre: json['personaPadre'] == null
          ? ( json['id_persona_padre'] == null ? null : new Persona(idPersona: json['id_persona_padre']) )
          : new Persona.fromJson(json['personaPadre'] as Map<String, dynamic>),      
      experto: ((json['experto'] as num)==1)
  );
}

abstract class _$PersonaSerializerMixin {
  int get idPersona;
  num get identificacion;
  String get nombre;
  Perfil get perfil;
  double get latitud;
  double get longitud;
  Ubicacion get ubicacion;  
  String get imagen;
  List<Telefono> get telefonos;
  Usuario get usuario;  
  Persona get personaPadre;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id_persona': idPersona,
        'identificacion': identificacion,
        'nombre': nombre,
        'id_perfil': perfil.idPerfil,
        'latitud': latitud??ubicacion.latitud,
        'longitud': longitud??ubicacion.longitud,
        'id_ubicacion': ubicacion.idUbicacion,        
        'imagen': imagen,
        'telefonos': telefonos,
        'usuario': usuario,
        'id_persona_padre': personaPadre?.idPersona,
      };
}
