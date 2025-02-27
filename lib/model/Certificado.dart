import 'dart:io';

import 'Persona.dart';

import 'package:json_annotation/json_annotation.dart';

part 'Certificado.g.dart';

@JsonSerializable()
class Certificado extends Object with _$CertificadoSerializerMixin {

  num idCertificado;

  bool valido;

  Persona persona;

  String imagen;

  File imageFile;
  
  DateTime fechaInicial;
  
  DateTime fechaFinal;
  
  DateTime fechaRevision;  
  
  Certificado({
    this.idCertificado, this.valido,
    this.persona,
    this.imagen,
    this.fechaInicial, this.fechaFinal, this.fechaRevision,
  });

  factory Certificado.fromJson(Map<String, dynamic> json) => _$CertificadoFromJson(json);

  @override
  String toString()  {
    return 'Certificado[idCertificado=$idCertificado]';
  }


}
