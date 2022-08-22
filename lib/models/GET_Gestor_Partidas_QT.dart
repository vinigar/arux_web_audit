// To parse this JSON data, do
//
//     final getGestorPartidasQt = getGestorPartidasQtFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetGestorPartidasQt getGestorPartidasQtFromMap(String str) =>
    GetGestorPartidasQt.fromMap(json.decode(str));

String getGestorPartidasQtToMap(GetGestorPartidasQt data) =>
    json.encode(data.toMap());

class GetGestorPartidasQt {
  GetGestorPartidasQt({
    required this.data,
    required this.status,
    required this.error,
    required this.count,
  });

  final List<Datum> data;
  final int status;
  final dynamic error;
  final dynamic count;

  factory GetGestorPartidasQt.fromMap(Map<String, dynamic> json) =>
      GetGestorPartidasQt(
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
    required this.idPartidasPk,
    required this.proveedor,
    required this.referencia,
    required this.importe,
    required this.moneda,
    required this.importeUsd,
    required this.diasPago,
    required this.porcDpp,
    required this.cantDpp,
    required this.prontoPago,
  });

  final int idPartidasPk;
  final String proveedor;
  final String referencia;
  final double importe;
  final String moneda;
  final double importeUsd;
  final int diasPago;
  final double porcDpp;
  final double cantDpp;
  final double prontoPago;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        idPartidasPk: json["id_partidas_pk"],
        proveedor: json["proveedor"],
        referencia: json["referencia"],
        importe: json["importe"].toDouble(),
        moneda: json["moneda"],
        importeUsd: json["importe_usd"].toDouble(),
        diasPago: json["dias_pago"],
        porcDpp: json["porc_dpp"],
        cantDpp: json["cant_dpp"],
        prontoPago: json["pronto_pago"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "id_partidas_pk": idPartidasPk,
        "proveedor": proveedor,
        "referencia": referencia,
        "importe": importe,
        "moneda": moneda,
        "importe_usd": importeUsd,
        "dias_pago": diasPago,
        "porc_dpp": porcDpp,
        "cant_dpp": cantDpp,
        "pronto_pago": prontoPago,
      };
}
