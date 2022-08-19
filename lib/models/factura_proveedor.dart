// To parse this JSON data, do
//
//     final facturaProveedor = facturaProveedorFromMap(jsonString);

import 'dart:convert';

class FacturaProveedor {
  FacturaProveedor({
    required this.idProveedorPk,
    required this.identificadorSap,
    required this.sociedad,
    required this.nombreFiscal,
    required this.identificadorFiscal,
    required this.direccion,
    required this.contacto,
    required this.telefonoProveedor,
    required this.idEsquemaFk,
    required this.descuento,
    required this.pagarAntesDe,
    required this.imagenProveedor,
    required this.documento,
    required this.vigencia,
    required this.fechaRegistroProveedor,
    required this.condPago,
    required this.idEstadoFk,
    required this.idPartidasPk,
    required this.idProveedorFk,
    required this.cuentaMayor,
    required this.acreedor,
    required this.asignacion,
    required this.referencia,
    required this.noDocPartida,
    required this.clase,
    required this.importe,
    required this.moneda,
    required this.importeMl,
    required this.ml,
    required this.tipoCambio,
    required this.docComp,
    required this.fechaDoc,
    required this.fechaContab,
    required this.cPag,
    required this.datosRetencion,
    required this.calcImpuestos,
    required this.imptImpuesto,
    required this.indicadorImpuesto,
    required this.noLote,
    required this.condicionPago,
    required this.fechaBase,
    required this.fechaRegistro,
    required this.diasPago,
    required this.descuentoPorcPp,
    required this.prontoPago,
    required this.descuentoCantPp,
    this.idPagoFk,
    required this.idNcSapFk,
    required this.idEstatusFk,
    required this.idEstadoPk,
    required this.fechaRegistroEstado,
    required this.nombreEstado,
    required this.fechaCreacion,
    required this.nombreEstatus,
  });

  int idProveedorPk;
  String identificadorSap;
  String sociedad;
  String nombreFiscal;
  String identificadorFiscal;
  String direccion;
  String contacto;
  String telefonoProveedor;
  int idEsquemaFk;
  double descuento;
  int pagarAntesDe;
  String imagenProveedor;
  dynamic documento;
  DateTime vigencia;
  DateTime fechaRegistroProveedor;
  int condPago;
  int idEstadoFk;
  int idPartidasPk;
  int idProveedorFk;
  dynamic cuentaMayor;
  dynamic acreedor;
  dynamic asignacion;
  String referencia;
  String noDocPartida;
  dynamic clase;
  double importe;
  String moneda;
  dynamic importeMl;
  dynamic ml;
  dynamic tipoCambio;
  dynamic docComp;
  DateTime fechaDoc;
  dynamic fechaContab;
  dynamic cPag;
  dynamic datosRetencion;
  dynamic calcImpuestos;
  dynamic imptImpuesto;
  dynamic indicadorImpuesto;
  dynamic noLote;
  dynamic condicionPago;
  DateTime fechaBase;
  DateTime fechaRegistro;
  int diasPago;
  int descuentoPorcPp;
  double prontoPago;
  double descuentoCantPp;
  int? idPagoFk;
  dynamic idNcSapFk;
  int idEstatusFk;
  int idEstadoPk;
  DateTime fechaRegistroEstado;
  NombreEstado nombreEstado;
  DateTime fechaCreacion;
  String nombreEstatus;

  factory FacturaProveedor.fromJson(String str) =>
      FacturaProveedor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FacturaProveedor.fromMap(Map<String, dynamic> json) =>
      FacturaProveedor(
        idProveedorPk: json["id_proveedor_pk"],
        identificadorSap: json["identificador_sap"],
        sociedad: json["sociedad"],
        nombreFiscal: json["nombre_fiscal"],
        identificadorFiscal: json["identificador_fiscal"],
        direccion: json["direccion"],
        contacto: json["contacto"],
        telefonoProveedor: json["telefono_proveedor"],
        idEsquemaFk: json["id_esquema_fk"],
        descuento: json["descuento"].toDouble(),
        pagarAntesDe: json["pagar_antes_de"],
        imagenProveedor: json["imagen_proveedor"],
        documento: json["documento"],
        vigencia: DateTime.parse(json["vigencia"]),
        fechaRegistroProveedor:
            DateTime.parse(json["fecha_registro_proveedor"]),
        condPago: json["cond_pago"],
        idEstadoFk: json["id_estado_fk"],
        idPartidasPk: json["id_partidas_pk"],
        idProveedorFk: json["id_proveedor_fk"],
        cuentaMayor: json["cuenta_mayor"],
        acreedor: json["acreedor"],
        asignacion: json["asignacion"],
        referencia: json["referencia"],
        noDocPartida: json["no_doc_partida"],
        clase: json["clase"],
        importe: json["importe"].toDouble(),
        moneda: json["moneda"],
        importeMl: json["importe_ml"],
        ml: json["ml"],
        tipoCambio: json["tipo_cambio"],
        docComp: json["doc_comp"],
        fechaDoc: DateTime.parse(json["fecha_doc"]),
        fechaContab: json["fecha_contab"],
        cPag: json["c_pag"],
        datosRetencion: json["datos_retencion"],
        calcImpuestos: json["calc_impuestos"],
        imptImpuesto: json["impt_impuesto"],
        indicadorImpuesto: json["indicador_impuesto"],
        noLote: json["no_lote"],
        condicionPago: json["condicion_pago"],
        fechaBase: DateTime.parse(json["fecha_base"]),
        fechaRegistro: DateTime.parse(json["fecha_registro"]),
        diasPago: json["dias_pago"],
        descuentoPorcPp: json["descuento_porc_pp"],
        prontoPago: json["pronto_pago"].toDouble(),
        descuentoCantPp: json["descuento_cant_pp"].toDouble(),
        idPagoFk: json["id_pago_fk"],
        idNcSapFk: json["id_nc_sap_fk"],
        idEstatusFk: json["id_estatus_fk"],
        idEstadoPk: json["id_estado_pk"],
        fechaRegistroEstado: DateTime.parse(json["fecha_registro_estado"]),
        nombreEstado: nombreEstadoValues.map[json["nombre_estado"]]!,
        fechaCreacion: DateTime.parse(json["fecha_creacion"]),
        nombreEstatus: json["nombre_estatus"],
      );

  Map<String, dynamic> toMap() => {
        "id_proveedor_pk": idProveedorPk,
        "identificador_sap": identificadorSap,
        "sociedad": sociedad,
        "nombre_fiscal": nombreFiscal,
        "identificador_fiscal": identificadorFiscal,
        "direccion": direccion,
        "contacto": contacto,
        "telefono_proveedor": telefonoProveedor,
        "id_esquema_fk": idEsquemaFk,
        "descuento": descuento,
        "pagar_antes_de": pagarAntesDe,
        "imagen_proveedor": imagenProveedor,
        "documento": documento,
        "vigencia": vigencia.toIso8601String(),
        "fecha_registro_proveedor": fechaRegistroProveedor.toIso8601String(),
        "cond_pago": condPago,
        "id_estado_fk": idEstadoFk,
        "id_partidas_pk": idPartidasPk,
        "id_proveedor_fk": idProveedorFk,
        "cuenta_mayor": cuentaMayor,
        "acreedor": acreedor,
        "asignacion": asignacion,
        "referencia": referencia,
        "no_doc_partida": noDocPartida,
        "clase": clase,
        "importe": importe,
        "moneda": moneda,
        "importe_ml": importeMl,
        "ml": ml,
        "tipo_cambio": tipoCambio,
        "doc_comp": docComp,
        "fecha_doc": fechaDoc.toIso8601String(),
        "fecha_contab": fechaContab,
        "c_pag": cPag,
        "datos_retencion": datosRetencion,
        "calc_impuestos": calcImpuestos,
        "impt_impuesto": imptImpuesto,
        "indicador_impuesto": indicadorImpuesto,
        "no_lote": noLote,
        "condicion_pago": condicionPago,
        "fecha_base": fechaBase.toIso8601String(),
        "fecha_registro": fechaRegistro.toIso8601String(),
        "dias_pago": diasPago,
        "descuento_porc_pp": descuentoPorcPp,
        "pronto_pago": prontoPago,
        "descuento_cant_pp": descuentoCantPp,
        "id_pago_fk": idPagoFk == null ? null : idPagoFk,
        "id_nc_sap_fk": idNcSapFk,
        "id_estatus_fk": idEstatusFk,
        "id_estado_pk": idEstadoPk,
        "fecha_registro_estado": fechaRegistroEstado.toIso8601String(),
        "nombre_estado": nombreEstadoValues.reverse[nombreEstado],
        "fecha_creacion": fechaCreacion.toIso8601String(),
        "nombre_estatus": nombreEstatus,
      };
}

enum NombreEstado { VIGENTE }

final nombreEstadoValues = EnumValues({"Vigente": NombreEstado.VIGENTE});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
