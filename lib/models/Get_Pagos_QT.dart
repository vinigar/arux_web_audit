import 'dart:convert';

GetPagosQt getPagosQtFromMap(String str) =>
    GetPagosQt.fromMap(json.decode(str));

String getPagosQtToMap(GetPagosQt data) => json.encode(data.toMap());

class GetPagosQt {
  GetPagosQt({
    required this.data,
    required this.status,
    required this.error,
    required this.count,
  });

  final List<Datum> data;
  final int status;
  final dynamic error;
  final dynamic count;

  factory GetPagosQt.fromMap(Map<String, dynamic> json) => GetPagosQt(
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
    required this.fechaExtraccion,
    required this.moneda,
    required this.esquema,
    required this.estatus,
    required this.acreedor,
    required this.proveedor,
    required this.idPartida,
    required this.noDocPartida,
    required this.referenciaPartida,
    required this.importePartida,
    required this.idNc,
    required this.noDocNc,
    required this.referenciaNc,
    required this.descuentoProveedor,
    required this.dpp,
    required this.total,
  });

  final DateTime fechaExtraccion;
  final String moneda;
  final String esquema;
  final String estatus;
  final dynamic acreedor;
  final String proveedor;
  final int idPartida;
  final String noDocPartida;
  final String referenciaPartida;
  final double importePartida;
  final dynamic idNc;
  final dynamic noDocNc;
  final dynamic referenciaNc;
  final double descuentoProveedor;
  final double dpp;
  final double total;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        fechaExtraccion: DateTime.parse(json["fecha_extraccion"]),
        moneda: json["moneda"],
        esquema: json["esquema"],
        estatus: json["estatus"],
        acreedor: json["acreedor"],
        proveedor: json["proveedor"],
        idPartida: json["id_partida"],
        noDocPartida: json["no_doc_partida"],
        referenciaPartida: json["referencia_partida"],
        importePartida: json["importe_partida"].toDouble(),
        idNc: json["id_nc"],
        noDocNc: json["no_doc_nc"],
        referenciaNc: json["referencia_nc"],
        descuentoProveedor: json["descuento_proveedor"].toDouble(),
        dpp: json["dpp"].toDouble(),
        total: json["total"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "fecha_extraccion":
            "${fechaExtraccion.year.toString().padLeft(4, '0')}-${fechaExtraccion.month.toString().padLeft(2, '0')}-${fechaExtraccion.day.toString().padLeft(2, '0')}",
        "moneda": moneda,
        "esquema": esquema,
        "estatus": estatus,
        "acreedor": acreedor,
        "proveedor": proveedor,
        "id_partida": idPartida,
        "no_doc_partida": noDocPartida,
        "referencia_partida": referenciaPartida,
        "importe_partida": importePartida,
        "id_nc": idNc,
        "no_doc_nc": noDocNc,
        "referencia_nc": referenciaNc,
        "descuento_proveedor": descuentoProveedor,
        "dpp": dpp,
        "total": total,
      };
}
