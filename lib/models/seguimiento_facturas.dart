import 'dart:convert';

class SeguimientoFacturas {
  SeguimientoFacturas({
    required this.idddu,
    required this.idPartidasPk,
    required this.proveedor,
    required this.factura,
    required this.esquema,
    required this.moneda,
    required this.fechaDocumento,
    required this.fechaInicio,
    required this.fechaLimite,
    required this.semaforo,
    required this.fechaPago,
    required this.estatus,
  });

  String idddu;
  int idPartidasPk;
  String proveedor;
  String factura;
  String esquema;
  String moneda;
  DateTime fechaDocumento;
  DateTime? fechaInicio;
  DateTime? fechaLimite;
  String semaforo;
  DateTime? fechaPago;
  String estatus;

  factory SeguimientoFacturas.fromJson(String str) =>
      SeguimientoFacturas.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SeguimientoFacturas.fromMap(Map<String, dynamic> json) =>
      SeguimientoFacturas(
        idddu: json["idddu"],
        idPartidasPk: json["id_partidas_pk"],
        proveedor: json["proveedor"],
        factura: json["factura"],
        esquema: json["esquema"],
        moneda: json["moneda"],
        fechaDocumento: DateTime.parse(json["fecha_documento"]),
        fechaInicio: DateTime.parse(json["fecha_inicio"]),
        fechaLimite: DateTime.parse(json["fecha_limite"]),
        semaforo: json["semaforo"],
        fechaPago: json["fecha_pago"] == null
            ? null
            : DateTime.parse(json["fecha_pago"]),
        estatus: json["estatus"],
      );

  Map<String, dynamic> toMap() => {
        "idddu": idddu,
        "id_partidas_pk": idPartidasPk,
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
        "semaforo": semaforo,
        "fecha_pago": fechaPago == null
            ? null
            : "${fechaPago!.year.toString().padLeft(4, '0')}-${fechaPago!.month.toString().padLeft(2, '0')}-${fechaPago!.day.toString().padLeft(2, '0')}",
        "estatus": estatus,
      };
}
