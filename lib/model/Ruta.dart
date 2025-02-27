import 'package:json_annotation/json_annotation.dart';

part 'Ruta.g.dart';

@JsonSerializable()
class Ruta extends Object with _$RutaSerializerMixin {
  num idRutas;

  int idPersonaDe;

  String nombreR;
  String descripcion;

  String latitud;

  String longitud;

  double kilometraje;
  double gasolina;
  double peaje;
  double paradas;
  double conductor;
  double auxiliar;
  double desgaste;

  List<Point> points;
  Fin fin;
  Inicio inicio;

  Ruta({
    this.idRutas,
    this.idPersonaDe,
    this.nombreR,
    this.descripcion,
    this.latitud,
    this.longitud,
    this.kilometraje,
    this.gasolina,
    this.peaje,
    this.paradas,
    this.conductor,
    this.auxiliar,
    this.desgaste,
    this.points,
    this.fin,
    this.inicio,
  });

  factory Ruta.fromJson(Map<String, dynamic> json) => _$RutaFromJson(json);

  Ruta.fromInicioFin(dynamic jsonInicio, dynamic jsonFin, dynamic json) {
    this.inicio = Inicio.fromJson(jsonInicio[0]);
    this.fin = Fin.fromJson(jsonFin[0]);
    this.points = List<Point>.from(json.map((x) => Point.fromJson(x)));
  }

  @override
  String toString() {
    return 'Ruta[idRutas=$idRutas]';
  }

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType) return false;
    final Ruta typedOther = other;
    return typedOther.idRutas == this.idRutas;
  }

  @override
  int get hashCode => this.idRutas.hashCode;

  double total() {
    return this.gasolina +
        this.peaje +
        this.paradas +
        this.conductor +
        this.auxiliar +
        this.desgaste;
  }
}

class Point {
  Point({
    this.ruta,
    this.nombre,
    this.descripcion,
    this.latitud,
    this.longitud,
  });

  String ruta;
  String nombre;
  String descripcion;
  double latitud;
  double longitud;

  factory Point.fromJson(Map<String, dynamic> json) => Point(
        ruta: json['ruta'],
        nombre: json['nombre'],
        descripcion: json['descripcion'],
        latitud: double.parse(json['latitud']),
        longitud: double.parse(json['longitud']),
      );
}

class Inicio {
  String ruta;
  String nombre;
  double latitud;
  double longitud;

  Inicio({
    this.ruta,
    this.nombre,
    this.latitud,
    this.longitud,
  });

  factory Inicio.fromJson(Map<String, dynamic> json) => Inicio(
        ruta: json['inicioR'],
        nombre: json['nombreP'],
        latitud: double.parse(json['latitudP']),
        longitud: double.parse(json['longitudP']),
      );
}

class Fin {
  String ruta;
  String nombre;
  double latitud;
  double longitud;

  Fin({
    this.ruta,
    this.nombre,
    this.latitud,
    this.longitud,
  });

  factory Fin.fromJson(Map<String, dynamic> json) => Fin(
        ruta: json['finR'],
        nombre: json['nombreP'],
        latitud: double.parse(json['latitudP']),
        longitud: double.parse(json['longitudP']),
      );
}
