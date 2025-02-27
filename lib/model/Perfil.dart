
import 'package:flutter/material.dart';

import 'TipoServicio.dart';

import 'package:json_annotation/json_annotation.dart';
import '../constants.dart';

part 'Perfil.g.dart';

@JsonSerializable()
class Perfil extends Object with _$PerfilSerializerMixin {

  String idPerfil;
  
  String nombre;

  String rol;
  
  List<TipoServicio> servicios = [];
  
  Perfil({this.idPerfil, this.nombre, this.rol, this.servicios});

  factory Perfil.fromJson(Map<String, dynamic> json) => _$PerfilFromJson(json);

  Color get color {    
    return colorPerfil.containsKey(this.rol+'.'+this.idPerfil) ? colorPerfil[this.rol+'.'+this.idPerfil] : colorPerfil[this.rol];
  }

  @override
  String toString()  {
    return 'Perfil[idPerfil=$idPerfil]';
  }

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType)
      return false;
    final Perfil typedOther = other;
    return typedOther.idPerfil == this.idPerfil;
  }

  @override
  int get hashCode => this.idPerfil.hashCode;

}
