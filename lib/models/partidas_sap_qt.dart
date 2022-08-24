import 'dart:convert';

PartidasSapQt partidasSapQtFromMap(String str) =>
    PartidasSapQt.fromMap(json.decode(str));

String partidasSapQtToMap(PartidasSapQt data) => json.encode(data.toMap());

class PartidasSapQt {
  PartidasSapQt({
    required this.data,
    required this.status,
    required this.error,
    required this.count,
  });

  final List<Datum> data;
  final int status;
  final dynamic error;
  final dynamic count;

  factory PartidasSapQt.fromMap(Map<String, dynamic> json) => PartidasSapQt(
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
    required this.idProveedorFk,
    required this.sociedad,
    required this.cuentaMayor,
    required this.acreedor,
    required this.asignacion,
    required this.referencia,
    required this.noDoc,
    required this.clase,
    required this.importe,
    required this.moneda,
    required this.importeMl,
    required this.ml,
    required this.tipoCambio,
    required this.docComp,
    required this.varcharo,
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
    required this.idPagoFk,
  });

  final int idPartidasPk;
  final int idProveedorFk;
  final String sociedad;
  final dynamic cuentaMayor;
  final dynamic acreedor;
  final dynamic asignacion;
  final String referencia;
  final dynamic noDoc;
  final dynamic clase;
  final double importe;
  final String moneda;
  final dynamic importeMl;
  final dynamic ml;
  final dynamic tipoCambio;
  final dynamic docComp;
  final dynamic varcharo;
  final dynamic fechaDoc;
  final dynamic fechaContab;
  final dynamic cPag;
  final dynamic datosRetencion;
  final dynamic calcImpuestos;
  final dynamic imptImpuesto;
  final dynamic indicadorImpuesto;
  final dynamic noLote;
  final dynamic condicionPago;
  final dynamic fechaBase;
  final DateTime fechaRegistro;
  final int diasPago;
  final int descuentoPorcPp;
  final double prontoPago;
  final int descuentoCantPp;
  final int idPagoFk;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        idPartidasPk: json["id_partidas_pk"],
        idProveedorFk: json["id_proveedor_fk"],
        sociedad: json["sociedad"],
        cuentaMayor: json["cuenta_mayor"],
        acreedor: json["acreedor"],
        asignacion: json["asignacion"],
        referencia: json["referencia"],
        noDoc: json["no_doc"],
        clase: json["clase"],
        importe: json["importe"].toDouble(),
        moneda: json["moneda"],
        importeMl: json["importe_ml"],
        ml: json["ml"],
        tipoCambio: json["tipo_cambio"],
        docComp: json["doc_comp"],
        varcharo: json["varcharo"],
        fechaDoc: json["fecha_doc"],
        fechaContab: json["fecha_contab"],
        cPag: json["c_pag"],
        datosRetencion: json["datos_retencion"],
        calcImpuestos: json["calc_impuestos"],
        imptImpuesto: json["impt_impuesto"],
        indicadorImpuesto: json["indicador_impuesto"],
        noLote: json["no_lote"],
        condicionPago: json["condicion_pago"],
        fechaBase: json["fecha_base"],
        fechaRegistro: DateTime.parse(json["fecha_registro"]),
        diasPago: json["dias_pago"],
        descuentoPorcPp: json["descuento_porc_pp"],
        prontoPago: json["pronto_pago"].toDouble(),
        descuentoCantPp: json["descuento_cant_pp"],
        idPagoFk: json["id_pago_fk"],
      );

  Map<String, dynamic> toMap() => {
        "id_partidas_pk": idPartidasPk,
        "id_proveedor_fk": idProveedorFk,
        "sociedad": sociedad,
        "cuenta_mayor": cuentaMayor,
        "acreedor": acreedor,
        "asignacion": asignacion,
        "referencia": referencia,
        "no_doc": noDoc,
        "clase": clase,
        "importe": importe,
        "moneda": moneda,
        "importe_ml": importeMl,
        "ml": ml,
        "tipo_cambio": tipoCambio,
        "doc_comp": docComp,
        "varcharo": varcharo,
        "fecha_doc": fechaDoc,
        "fecha_contab": fechaContab,
        "c_pag": cPag,
        "datos_retencion": datosRetencion,
        "calc_impuestos": calcImpuestos,
        "impt_impuesto": imptImpuesto,
        "indicador_impuesto": indicadorImpuesto,
        "no_lote": noLote,
        "condicion_pago": condicionPago,
        "fecha_base": fechaBase,
        "fecha_registro": fechaRegistro.toIso8601String(),
        "dias_pago": diasPago,
        "descuento_porc_pp": descuentoPorcPp,
        "pronto_pago": prontoPago,
        "descuento_cant_pp": descuentoCantPp,
        "id_pago_fk": idPagoFk,
      };
}
