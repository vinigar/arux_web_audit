// To parse this JSON data, do
//
//     final proveedorFromPartidaQt = proveedorFromPartidaQtFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProveedorFromPartidaQt proveedorFromPartidaQtFromMap(String str) =>
    ProveedorFromPartidaQt.fromMap(json.decode(str));

String proveedorFromPartidaQtToMap(ProveedorFromPartidaQt data) =>
    json.encode(data.toMap());

class ProveedorFromPartidaQt {
  ProveedorFromPartidaQt({
    required this.data,
    required this.status,
    required this.error,
    required this.count,
  });

  final List<Datum> data;
  final int status;
  final dynamic error;
  final dynamic count;

  factory ProveedorFromPartidaQt.fromMap(Map<String, dynamic> json) =>
      ProveedorFromPartidaQt(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
        status: json["status"],
        error: json["error"],
        count: json["count"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "status": status,
        "error": error,
        "count": count,
      };
}

class Datum {
  Datum({
    required this.proveedores,
  });

  final Proveedores proveedores;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        proveedores: Proveedores.fromMap(json["proveedores"]),
      );

  Map<String, dynamic> toMap() => {
        "proveedores": proveedores.toMap(),
      };
}

class Proveedores {
  Proveedores({
    required this.sociedad,
  });

  final String sociedad;

  factory Proveedores.fromMap(Map<String, dynamic> json) => Proveedores(
        sociedad: json["sociedad"],
      );

  Map<String, dynamic> toMap() => {
        "sociedad": sociedad,
      };
}
