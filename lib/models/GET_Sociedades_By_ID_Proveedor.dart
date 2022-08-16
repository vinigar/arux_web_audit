// To parse this JSON data, do
//
//     final getSociedadesByIdProveedorQt = getSociedadesByIdProveedorQtFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetSociedadesByIdProveedorQt getSociedadesByIdProveedorQtFromMap(String str) => GetSociedadesByIdProveedorQt.fromMap(json.decode(str));

String getSociedadesByIdProveedorQtToMap(GetSociedadesByIdProveedorQt data) => json.encode(data.toMap());

class GetSociedadesByIdProveedorQt {
    GetSociedadesByIdProveedorQt({
        required this.data,
        required this.status,
        required this.error,
        required this.count,
    });

    final List<Datum> data;
    final int status;
    final dynamic error;
    final dynamic count;

    factory GetSociedadesByIdProveedorQt.fromMap(Map<String, dynamic> json) => GetSociedadesByIdProveedorQt(
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
        required this.idsociedad,
        required this.categoria,
        required this.cuenta,
        required this.sociedad,
        required this.telefono,
        required this.contacto,
        required this.diasPago,
        required this.tipo,
        required this.idproveedor,
    });

    final int idsociedad;
    final String categoria;
    final int cuenta;
    final String sociedad;
    final String telefono;
    final String contacto;
    final String diasPago;
    final String tipo;
    final int idproveedor;

    factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        idsociedad: json["idsociedad"],
        categoria: json["categoria"],
        cuenta: json["cuenta"],
        sociedad: json["sociedad"],
        telefono: json["telefono"],
        contacto: json["contacto"],
        diasPago: json["dias_pago"],
        tipo: json["tipo"],
        idproveedor: json["idproveedor"],
    );

    Map<String, dynamic> toMap() => {
        "idsociedad": idsociedad,
        "categoria": categoria,
        "cuenta": cuenta,
        "sociedad": sociedad,
        "telefono": telefono,
        "contacto": contacto,
        "dias_pago": diasPago,
        "tipo": tipo,
        "idproveedor": idproveedor,
    };
}
