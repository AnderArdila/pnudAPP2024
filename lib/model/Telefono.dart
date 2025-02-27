import 'Persona.dart';

import 'package:json_annotation/json_annotation.dart';

part 'Telefono.g.dart';

@JsonSerializable()
class Telefono extends Object with _$TelefonoSerializerMixin {

  Persona persona;

  int numero;

  Telefono({this.persona, this.numero});

  factory Telefono.fromJson(Map<String, dynamic> json) => _$TelefonoFromJson(json);

  @override
  String toString()  {
    return 'Telefono[persona=$persona, numero=$numero]';
  }

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType)
      return false;
    final Telefono typedOther = other;
    return typedOther.persona == this.persona && typedOther.numero == this.numero;
  }

  @override
  int get hashCode => this.persona.hashCode + (17 * this.numero.hashCode);
  
}