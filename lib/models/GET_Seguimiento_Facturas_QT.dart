// To parse this JSON data, do
//
//     final getSeguimientoFacturasQt = getSeguimientoFacturasQtFromMap(jsonString);

import 'dart:convert';

GetSeguimientoFacturasQt getSeguimientoFacturasQtFromMap(String str) =>
    GetSeguimientoFacturasQt.fromMap(json.decode(str));

String getSeguimientoFacturasQtToMap(GetSeguimientoFacturasQt data) =>
    json.encode(data.toMap());

class GetSeguimientoFacturasQt {
  GetSeguimientoFacturasQt({
    required this.data,
    required this.status,
    required this.error,
    required this.count,
  });

  final List<Datum> data;
  final int status;
  final dynamic error;
  final dynamic count;

  factory GetSeguimientoFacturasQt.fromMap(Map<String, dynamic> json) =>
      GetSeguimientoFacturasQt(
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
    required this.idddu,
    required this.idPartidasPk,
    required this.proveedor,
    required this.factura,
    required this.esquema,
    required this.moneda,
    required this.fechaDocumento,
    required this.fechaInicio,
    required this.fechaLimite,
    required this.fechaPago,
    required this.estatus,
  });

  final int idddu;
  final int idPartidasPk;
  final String proveedor;
  final String factura;
  final String esquema;
  final String moneda;
  final DateTime fechaDocumento;
  final DateTime? fechaInicio;
  final DateTime? fechaLimite;
  final DateTime? fechaPago;
  final String estatus;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        idddu: json["idddu"],
        idPartidasPk: json["id_partidas_pk"],
        proveedor: json["proveedor"],
        factura: json["factura"],
        esquema: json["esquema"],
        moneda: json["moneda"],
        fechaDocumento: DateTime.parse(json["fecha_documento"]),
        fechaInicio: json["fecha_inicio"] == null
            ? null
            : DateTime.parse(json["fecha_inicio"]),
        fechaLimite: json["fecha_limite"] == null
            ? null
            : DateTime.parse(json["fecha_limite"]),
        fechaPago: json["fecha_pago"] == null
            ? null
            : DateTime.parse(json["fecha_pago"]),
        estatus: json["estatus"],
      );

  Map<String, dynamic> toMap() => {
        "idddu": idddu,
        "idPartidasPk": idPartidasPk,
        "proveedor": proveedor,
        "factura": factura,
        "esquema": esquema,
        "moneda": moneda,
        "fecha_documento":
            "${fechaDocumento.year.toString().padLeft(4, '0')}-${fechaDocumento.month.toString().padLeft(2, '0')}-${fechaDocumento.day.toString().padLeft(2, '0')}",
        "fecha_inicio": fechaInicio == null
            ? null
            : "${fechaInicio!.year.toString().padLeft(4, '0')}-${fechaInicio!.month.toString().padLeft(2, '0')}-${fechaInicio!.day.toString().padLeft(2, '0')}",
        "fecha_limite": fechaLimite == null
            ? null
            : "${fechaLimite!.year.toString().padLeft(4, '0')}-${fechaLimite!.month.toString().padLeft(2, '0')}-${fechaLimite!.day.toString().padLeft(2, '0')}",
        "fecha_pago": fechaPago == null
            ? null
            : "${fechaPago!.year.toString().padLeft(4, '0')}-${fechaPago!.month.toString().padLeft(2, '0')}-${fechaPago!.day.toString().padLeft(2, '0')}",
        "estatus": estatus,
      };
}
