import 'dart:convert';

GetReporteSeguimientoFacturasQt getReporteSeguimientoFacturasQtFromMap(
        String str) =>
    GetReporteSeguimientoFacturasQt.fromMap(json.decode(str));

String getReporteSeguimientoFacturasQtToMap(
        GetReporteSeguimientoFacturasQt data) =>
    json.encode(data.toMap());

class GetReporteSeguimientoFacturasQt {
  GetReporteSeguimientoFacturasQt({
    required this.data,
    required this.status,
    required this.error,
    required this.count,
  });

  final List<Datum> data;
  final int status;
  final dynamic error;
  final dynamic count;

  factory GetReporteSeguimientoFacturasQt.fromMap(Map<String, dynamic> json) =>
      GetReporteSeguimientoFacturasQt(
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
    required this.idProveedor,
    required this.idddu,
    required this.proveedor,
    required this.idPartida,
    required this.factura,
    required this.importe,
    required this.moneda,
    required this.ncSap,
    required this.importeNc,
    required this.docPagoSap,
    required this.estatus,
  });

  final int idProveedor;
  final int idddu;
  final String proveedor;
  final int idPartida;
  final String factura;
  final double importe;
  final String moneda;
  final int? ncSap;
  final double? importeNc;
  final String? docPagoSap;
  final String estatus;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        idProveedor: json["id_proveedor"],
        idddu: json["idddu"],
        proveedor: json["proveedor"],
        idPartida: json["id_partida"],
        factura: json["factura"],
        importe: json["importe"].toDouble(),
        moneda: json["moneda"],
        ncSap: json["nc_sap"],
        importeNc: json["importe_nc"] ?? json["importe_nc"].toDouble(),
        docPagoSap: json["doc_pago_sap"],
        estatus: json["estatus"],
      );

  Map<String, dynamic> toMap() => {
        "id_proveedor": idProveedor,
        "idddu": idddu,
        "proveedor": proveedor,
        "id_partida": idPartida,
        "factura": factura,
        "importe": importe,
        "moneda": moneda,
        "nc_sap": ncSap,
        "importe_nc": importeNc,
        "doc_pago_sap": docPagoSap,
        "estatus": estatus,
      };
}
