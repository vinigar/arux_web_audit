import 'dart:convert';

GetProveedoresQt getProveedoresQtFromMap(String str) =>
    GetProveedoresQt.fromMap(json.decode(str));

String getProveedoresQtToMap(GetProveedoresQt data) =>
    json.encode(data.toMap());

class GetProveedoresQt {
  GetProveedoresQt({
    required this.data,
    required this.status,
    required this.error,
    required this.count,
  });

  final List<Datum> data;
  final int status;
  final dynamic error;
  final dynamic count;

  factory GetProveedoresQt.fromMap(Map<String, dynamic> json) =>
      GetProveedoresQt(
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
    required this.proveedor,
    required this.cuentaSap,
    required this.esquema,
    required this.estado,
  });

  final int idProveedor;
  final String proveedor;
  final String cuentaSap;
  final String esquema;
  final String estado;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        idProveedor: json["id_proveedor"],
        proveedor: json["proveedor"],
        cuentaSap: json["cuenta_sap"],
        esquema: json["esquema"],
        estado: json["estado"],
      );

  Map<String, dynamic> toMap() => {
        "id_proveedor": idProveedor,
        "proveedor": proveedor,
        "cuenta_sap": cuentaSap,
        "esquema": esquema,
        "estado": estado,
      };
}
