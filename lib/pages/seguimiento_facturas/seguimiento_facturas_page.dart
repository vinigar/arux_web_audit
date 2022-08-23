import 'dart:convert';

import 'package:arux/helpers/supabase/queries.dart';
import 'package:arux/pages/seguimiento_facturas/widgets/popup_nota_credito.dart';
import 'package:flutter/material.dart';

import 'package:arux/functions/date_format.dart';
import 'package:arux/helpers/globalUtility.dart';
import 'package:arux/helpers/globals.dart';
import 'package:arux/models/GET_Gestor_Partidas_QT.dart';
import 'package:arux/models/GET_Seguimiento_Facturas_QT.dart';
import 'package:arux/pages/widgets/side_menu/side_menu.dart';
import 'package:arux/pages/widgets/top_menu/top_menu.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SeguimientoDeFacturasPage extends StatefulWidget {
  const SeguimientoDeFacturasPage({Key? key}) : super(key: key);

  @override
  State<SeguimientoDeFacturasPage> createState() =>
      _SeguimientoDeFacturasPageState();
}

class _SeguimientoDeFacturasPageState extends State<SeguimientoDeFacturasPage> {
  GlobalUtility globalUtility = GlobalUtility();

  final controller_busqueda = TextEditingController();
  String parametro_busqueda = "";

  final controller_idddu = TextEditingController();
  String parametro_idddu = "";
  final controller_proveedor = TextEditingController();
  String parametro_proveedor = "";
  final controller_factura = TextEditingController();
  String parametro_factura = "";
  final controller_esquema = TextEditingController();
  String parametro_esquema = "";
  final controller_moneda = TextEditingController();
  String parametro_moneda = "";
  final controller_fecha_doc = TextEditingController();
  String parametro_fecha_doc = "";
  final controller_fecha_inicio = TextEditingController();
  String parametro_fecha_inicio = "";
  final controller_fecha_limite = TextEditingController();
  String parametro_fecha_limite = "";
  final controller_fecha_pago = TextEditingController();
  String parametro_fecha_pago = "";
  final controller_estatus = TextEditingController();
  String parametro_estatus = "";

  bool filtro_simple = false;

  List<List<dynamic>> list_facturas = [];
  String orden = "idddu";
  bool asc = true;
  int count_i = 0;
  int count_f = 19;

  bool popup_rise = false;
  List<String?> selectedDDEnc = ["Registro SAP"];
  List<String?> selectedDDEnc_transf = [""];
  List<String?> selectedDDOpe = ["="];
  List<String?> parametro_filt = [""];
  final controller_busqueda_filtro = TextEditingController();
  bool filtro_avanzado = false;

  ///////////////////////////////////////////////////////////////////////////////////

  @override
  void initState() {
    getFacturas();
    super.initState();
  }

  Future<void> getFacturas() async {
    try {
      final res = await supabase
          .rpc('get_seguimiento_factura',
              params: {'busqueda': parametro_busqueda})
          .order(orden, ascending: asc)
          .range(0, count_f)
          .execute();

      if (res.hasError) {
        print("-----Error: ${res.error}");
        return;
      }

      GetSeguimientoFacturasQt getSeguimientoFacturasQt =
          getSeguimientoFacturasQtFromMap(jsonEncode(res));

      list_facturas = [];

      for (var i = 0; i < getSeguimientoFacturasQt.data.length; i++) {
        List<dynamic> localList = [];

        localList.add(getSeguimientoFacturasQt.data[i].idddu);
        localList.add(getSeguimientoFacturasQt.data[i].proveedor);
        localList.add(getSeguimientoFacturasQt.data[i].factura);
        localList.add(getSeguimientoFacturasQt.data[i].esquema);
        localList.add(getSeguimientoFacturasQt.data[i].moneda);
        localList
            .add(dateFormat(getSeguimientoFacturasQt.data[i].fechaDocumento));
        if (getSeguimientoFacturasQt.data[i].fechaInicio == null) {
          localList.add("-");
        } else {
          localList
              .add(dateFormat(getSeguimientoFacturasQt.data[i].fechaInicio));
        }
        if (getSeguimientoFacturasQt.data[i].fechaLimite == null) {
          localList.add("-");
        } else {
          localList
              .add(dateFormat(getSeguimientoFacturasQt.data[i].fechaLimite));
        }
        if (getSeguimientoFacturasQt.data[i].fechaPago == null) {
          localList.add("-");
        } else {
          localList.add(dateFormat(getSeguimientoFacturasQt.data[i].fechaPago));
        }

        localList.add(getSeguimientoFacturasQt.data[i].estatus);
        localList.add(getSeguimientoFacturasQt.data[i].idPartidasPk);

        list_facturas.add(localList);
      }
    } catch (e) {
      print(e);
    }

    setState(() {});
  }

  ///////////////////////////////////////////////////////////////////////////////////
  //TODO: agregar pk a consulta
  Future<void> GetFacturasBy_() async {
    try {
      dynamic response = await supabase
          .rpc('get_gestor_partidas_push_by__', params: {
            'idpartida': parametro_idddu,
            'proveedor': parametro_proveedor,
            'referencia': parametro_esquema,
            'importe': parametro_fecha_doc,
            'moneda': parametro_moneda
          })
          .order(orden, ascending: asc)
          .execute();

      print("-----Error: ${response.error}");

      response = jsonEncode(response);

      // print("-----Parametro de Busqueda: $parametro_busqueda");
      print("-----Response: ");
      print(response.toString());

      GetGestorPartidasQt getSeguimientoFacturasQt =
          getGestorPartidasQtFromMap(response);

      list_facturas = [];

      for (var i = 0; i < getSeguimientoFacturasQt.data.length; i++) {
        List<dynamic> localList = [];

        localList.add(getSeguimientoFacturasQt.data[i].idPartidasPk);
        localList.add(getSeguimientoFacturasQt.data[i].proveedor);
        localList.add(getSeguimientoFacturasQt.data[i].referencia);
        localList.add("\$ ${getSeguimientoFacturasQt.data[i].importe}");
        localList.add(getSeguimientoFacturasQt.data[i].moneda);
        localList.add("\$ ${getSeguimientoFacturasQt.data[i].importeUsd}");
        localList.add(getSeguimientoFacturasQt.data[i].diasPago);
        localList.add("${getSeguimientoFacturasQt.data[i].porcDpp} %");
        localList.add("\$ ${getSeguimientoFacturasQt.data[i].cantDpp}");
        localList.add("\$ ${getSeguimientoFacturasQt.data[i].prontoPago}");

        list_facturas.add(localList);
      }
    } catch (e) {
      print(e);
    }

    setState(() {});
  }

  ///////////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const TopMenuWidget(),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SideMenuWidget(),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 30, 0),
                                    child: Icon(
                                      Icons.arrow_back_outlined,
                                      color: globalUtility.primary,
                                      size: 30,
                                    ),
                                  ),
                                  Text(
                                    'Seguimiento de Facturas',
                                    style: globalUtility.tituloPagina(context),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 25, 0),
                                    child: Container(
                                      width: 45,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        color: globalUtility.primaryBg,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: globalUtility.primary,
                                          width: 2,
                                        ),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.download_outlined,
                                          color: globalUtility.primary,
                                          size: 28,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 15, 0),
                                    child: Container(
                                      width: 250,
                                      height: 51,
                                      decoration: BoxDecoration(
                                        color: globalUtility.primaryBg,
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                          color: globalUtility.primary,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(10, 0, 0, 0),
                                            child: Icon(
                                              Icons.search,
                                              color: globalUtility.primary,
                                              size: 24,
                                            ),
                                          ),
                                          Center(
                                            child: SizedBox(
                                              width: 200,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 5,
                                                ),
                                                child: TextFormField(
                                                  controller:
                                                      controller_busqueda,
                                                  autofocus: true,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    hintText: 'Buscar',
                                                    hintStyle: globalUtility
                                                        .hinttxt(context),
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: globalUtility
                                                            .transparente,
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: globalUtility
                                                            .transparente,
                                                      ),
                                                    ),
                                                  ),
                                                  style: globalUtility
                                                      .textoA(context),
                                                  onChanged: (value) {
                                                    parametro_busqueda = value;
                                                    if (filtro_avanzado) {
                                                      switch (
                                                          selectedDDOpe[0]) {
                                                        case "=":
                                                          //GetPartidasIgual();
                                                          break;
                                                        case "<":
                                                          //GetPartidasMenor();
                                                          break;
                                                        case "<=":
                                                          //GetPartidasMenorI();
                                                          break;
                                                        case ">":
                                                          //GetPartidasMayor();
                                                          break;
                                                        case ">=":
                                                          //GetPartidasMayorI();
                                                          break;
                                                        case "!=":
                                                          //GetPartidasDif();
                                                          break;
                                                      }
                                                    } else {
                                                      getFacturas();
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 15, 0),
                                    child: Container(
                                      width: 250,
                                      height: 51,
                                      decoration: BoxDecoration(
                                        color: globalUtility.primaryBg,
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                          color: globalUtility.primary,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  InkWell(
                                                    child: Container(
                                                      width: 25,
                                                      height: 23.5,
                                                      decoration: BoxDecoration(
                                                        color: globalUtility
                                                            .primary,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  0),
                                                          topLeft:
                                                              Radius.circular(
                                                                  30),
                                                          topRight:
                                                              Radius.circular(
                                                                  0),
                                                        ),
                                                      ),
                                                      child: const Icon(
                                                        Icons
                                                            .arrow_drop_up_sharp,
                                                        color: Colors.white,
                                                        size: 18,
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      if (filtro_simple ==
                                                              false ||
                                                          filtro_avanzado ==
                                                              false) {
                                                        count_f++;
                                                        getFacturas();
                                                      }
                                                      setState(() {});
                                                    },
                                                  ),
                                                ],
                                              ),
                                              InkWell(
                                                child: Container(
                                                  width: 25,
                                                  height: 23.5,
                                                  decoration: BoxDecoration(
                                                    color: count_f == 0
                                                        ? globalUtility
                                                            .secondary
                                                        : globalUtility.primary,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(30),
                                                      bottomRight:
                                                          Radius.circular(0),
                                                      topLeft:
                                                          Radius.circular(0),
                                                      topRight:
                                                          Radius.circular(0),
                                                    ),
                                                  ),
                                                  child: const Icon(
                                                    Icons.arrow_drop_down_sharp,
                                                    color: Colors.white,
                                                    size: 18,
                                                  ),
                                                ),
                                                onTap: () {
                                                  if (filtro_simple == false ||
                                                      filtro_avanzado ==
                                                          false) {
                                                    if (count_f >= 1) {
                                                      count_f--;
                                                      getFacturas();
                                                      setState(() {});
                                                    }
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .only(start: 10),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Filas: ',
                                                  style: globalUtility
                                                      .textoIgual(context),
                                                ),
                                                SizedBox(
                                                  width: 100,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10),
                                                    child: TextFormField(
                                                      initialValue: "20",
                                                      style: globalUtility
                                                          .textoA(context),
                                                      decoration:
                                                          const InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none),
                                                      onChanged: (value) {
                                                        try {
                                                          print(
                                                              "---Valor: ${value.toString()}");
                                                          if (value
                                                                  .isNotEmpty ||
                                                              value != "0") {
                                                            count_f = int.parse(
                                                                value
                                                                    .toString());
                                                            count_f =
                                                                count_f - 1;
                                                            getFacturas();
                                                            setState(() {});
                                                          }
                                                        } catch (e) {
                                                          print("---Error: $e");
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 150,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: globalUtility.primaryBg,
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        color: globalUtility.primary,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          value: selectedDDEnc[0],
                                          items: <String>[
                                            "Registro SAP",
                                            "Proveedor",
                                            "Referencia",
                                            "Importe",
                                            "Moneda",
                                            "Importe USD",
                                            "Dias para Pago",
                                            "%DPP",
                                            "\$DPP",
                                            "Pronto Pago"
                                          ]
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Text(item),
                                                  ))
                                              .toList(),
                                          onChanged: (item) => setState(
                                              () => selectedDDEnc[0] = item),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(top: 20),
                            child: Material(
                              color: globalUtility.transparente,
                              elevation: 10,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: globalUtility.primary,
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 5),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    "IDDDU",
                                                    textAlign: TextAlign.center,
                                                    style: parametro_idddu
                                                            .isNotEmpty
                                                        ? globalUtility
                                                            .encabezadoTablasOn(
                                                                context)
                                                        : globalUtility
                                                            .encabezadoTablasOff(
                                                                context),
                                                  ),
                                                  onTap: () {
                                                    if (filtro_simple ==
                                                        false) {
                                                      filtro_avanzado = false;
                                                      filtro_simple = true;
                                                    } else {
                                                      filtro_simple = false;
                                                      controller_idddu.clear();
                                                      parametro_idddu = "";
                                                      controller_proveedor
                                                          .clear();
                                                      parametro_proveedor = "";
                                                      controller_esquema
                                                          .clear();
                                                      parametro_esquema = "";
                                                      controller_fecha_doc
                                                          .clear();
                                                      parametro_fecha_doc = "";
                                                      controller_moneda.clear();
                                                      parametro_moneda = "";
                                                    }
                                                    getFacturas();
                                                    setState(() {});
                                                  },
                                                ),
                                                InkWell(
                                                  child: Icon(
                                                      orden == "idddu"
                                                          ? asc == true
                                                              ? Icons
                                                                  .arrow_drop_down
                                                              : Icons
                                                                  .arrow_drop_up
                                                          : Icons
                                                              .arrow_drop_down,
                                                      color: orden == "idddu"
                                                          ? globalUtility
                                                              .primaryBg
                                                          : globalUtility
                                                              .secondary),
                                                  onTap: () {
                                                    if (orden != "idddu") {
                                                      orden = "idddu";
                                                      asc = true;
                                                    } else {
                                                      asc == true
                                                          ? asc = false
                                                          : asc = true;
                                                    }
                                                    if (filtro_avanzado) {
                                                      switch (
                                                          selectedDDOpe[0]) {
                                                        case "=":
                                                          //GetPartidasIgual();
                                                          break;
                                                        case "<":
                                                          //GetPartidasMenor();
                                                          break;
                                                        case "<=":
                                                          //GetPartidasMenorI();
                                                          break;
                                                        case ">":
                                                          //GetPartidasMayor();
                                                          break;
                                                        case ">=":
                                                          //GetPartidasMayorI();
                                                          break;
                                                        case "!=":
                                                          //GetPartidasDif();
                                                          break;
                                                      }
                                                    } else if (filtro_simple) {
                                                      GetFacturasBy_();
                                                    } else {
                                                      getFacturas();
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    "Proveedor",
                                                    textAlign: TextAlign.center,
                                                    style: parametro_proveedor
                                                            .isNotEmpty
                                                        ? globalUtility
                                                            .encabezadoTablasOn(
                                                                context)
                                                        : globalUtility
                                                            .encabezadoTablasOff(
                                                                context),
                                                  ),
                                                  onTap: () {
                                                    if (filtro_simple ==
                                                        false) {
                                                      filtro_avanzado = false;
                                                      filtro_simple = true;
                                                    } else {
                                                      filtro_simple = false;
                                                      controller_idddu.clear();
                                                      parametro_idddu = "";
                                                      controller_proveedor
                                                          .clear();
                                                      parametro_proveedor = "";
                                                      controller_esquema
                                                          .clear();
                                                      parametro_esquema = "";
                                                      controller_fecha_doc
                                                          .clear();
                                                      parametro_fecha_doc = "";
                                                      controller_moneda.clear();
                                                      parametro_moneda = "";
                                                    }
                                                    getFacturas();
                                                    setState(() {});
                                                  },
                                                ),
                                                InkWell(
                                                  child: Icon(
                                                      orden == "proveedor"
                                                          ? asc == true
                                                              ? Icons
                                                                  .arrow_drop_down
                                                              : Icons
                                                                  .arrow_drop_up
                                                          : Icons
                                                              .arrow_drop_down,
                                                      color:
                                                          orden == "proveedor"
                                                              ? globalUtility
                                                                  .primaryBg
                                                              : globalUtility
                                                                  .secondary),
                                                  onTap: () {
                                                    if (orden != "proveedor") {
                                                      orden = "proveedor";
                                                      asc = true;
                                                    } else {
                                                      asc == true
                                                          ? asc = false
                                                          : asc = true;
                                                    }
                                                    if (filtro_avanzado) {
                                                      switch (
                                                          selectedDDOpe[0]) {
                                                        case "=":
                                                          //GetPartidasIgual();
                                                          break;
                                                        case "<":
                                                          //GetPartidasMenor();
                                                          break;
                                                        case "<=":
                                                          //GetPartidasMenorI();
                                                          break;
                                                        case ">":
                                                          //GetPartidasMayor();
                                                          break;
                                                        case ">=":
                                                          //GetPartidasMayorI();
                                                          break;
                                                        case "!=":
                                                          //GetPartidasDif();
                                                          break;
                                                      }
                                                    } else if (filtro_simple) {
                                                      GetFacturasBy_();
                                                    } else {
                                                      getFacturas();
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    "Factura",
                                                    textAlign: TextAlign.center,
                                                    style: parametro_esquema
                                                            .isNotEmpty
                                                        ? globalUtility
                                                            .encabezadoTablasOn(
                                                                context)
                                                        : globalUtility
                                                            .encabezadoTablasOff(
                                                                context),
                                                  ),
                                                  onTap: () {
                                                    if (filtro_simple ==
                                                        false) {
                                                      filtro_avanzado = false;
                                                      filtro_simple = true;
                                                    } else {
                                                      filtro_simple = false;
                                                      controller_idddu.clear();
                                                      parametro_idddu = "";
                                                      controller_proveedor
                                                          .clear();
                                                      parametro_proveedor = "";
                                                      controller_esquema
                                                          .clear();
                                                      parametro_esquema = "";
                                                      controller_fecha_doc
                                                          .clear();
                                                      parametro_fecha_doc = "";
                                                      controller_moneda.clear();
                                                      parametro_moneda = "";
                                                    }
                                                    getFacturas();
                                                    setState(() {});
                                                  },
                                                ),
                                                InkWell(
                                                  child: Icon(
                                                      orden == "factura"
                                                          ? asc == true
                                                              ? Icons
                                                                  .arrow_drop_down
                                                              : Icons
                                                                  .arrow_drop_up
                                                          : Icons
                                                              .arrow_drop_down,
                                                      color: orden == "factura"
                                                          ? globalUtility
                                                              .primaryBg
                                                          : globalUtility
                                                              .secondary),
                                                  onTap: () {
                                                    if (orden != "factura") {
                                                      orden = "factura";
                                                      asc = true;
                                                    } else {
                                                      asc == true
                                                          ? asc = false
                                                          : asc = true;
                                                    }
                                                    if (filtro_avanzado) {
                                                      switch (
                                                          selectedDDOpe[0]) {
                                                        case "=":
                                                          //GetPartidasIgual();
                                                          break;
                                                        case "<":
                                                          //GetPartidasMenor();
                                                          break;
                                                        case "<=":
                                                          //GetPartidasMenorI();
                                                          break;
                                                        case ">":
                                                          //GetPartidasMayor();
                                                          break;
                                                        case ">=":
                                                          //GetPartidasMayorI();
                                                          break;
                                                        case "!=":
                                                          //GetPartidasDif();
                                                          break;
                                                      }
                                                    } else if (filtro_simple) {
                                                      GetFacturasBy_();
                                                    } else {
                                                      getFacturas();
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    "Esquema",
                                                    textAlign: TextAlign.center,
                                                    style: parametro_idddu
                                                            .isNotEmpty
                                                        ? globalUtility
                                                            .encabezadoTablasOn(
                                                                context)
                                                        : globalUtility
                                                            .encabezadoTablasOff(
                                                                context),
                                                  ),
                                                  onTap: () {
                                                    if (filtro_simple ==
                                                        false) {
                                                      filtro_avanzado = false;
                                                      filtro_simple = true;
                                                    } else {
                                                      filtro_simple = false;
                                                      controller_idddu.clear();
                                                      parametro_idddu = "";
                                                      controller_proveedor
                                                          .clear();
                                                      parametro_proveedor = "";
                                                      controller_esquema
                                                          .clear();
                                                      parametro_esquema = "";
                                                      controller_fecha_doc
                                                          .clear();
                                                      parametro_fecha_doc = "";
                                                      controller_moneda.clear();
                                                      parametro_moneda = "";
                                                    }
                                                    getFacturas();
                                                    setState(() {});
                                                  },
                                                ),
                                                InkWell(
                                                  child: Icon(
                                                      orden == "esquema"
                                                          ? asc == true
                                                              ? Icons
                                                                  .arrow_drop_down
                                                              : Icons
                                                                  .arrow_drop_up
                                                          : Icons
                                                              .arrow_drop_down,
                                                      color: orden == "esquema"
                                                          ? globalUtility
                                                              .primaryBg
                                                          : globalUtility
                                                              .secondary),
                                                  onTap: () {
                                                    if (orden != "esquema") {
                                                      orden = "esquema";
                                                      asc = true;
                                                    } else {
                                                      asc == true
                                                          ? asc = false
                                                          : asc = true;
                                                    }
                                                    if (filtro_avanzado) {
                                                      switch (
                                                          selectedDDOpe[0]) {
                                                        case "=":
                                                          //GetPartidasIgual();
                                                          break;
                                                        case "<":
                                                          //GetPartidasMenor();
                                                          break;
                                                        case "<=":
                                                          //GetPartidasMenorI();
                                                          break;
                                                        case ">":
                                                          //GetPartidasMayor();
                                                          break;
                                                        case ">=":
                                                          //GetPartidasMayorI();
                                                          break;
                                                        case "!=":
                                                          //GetPartidasDif();
                                                          break;
                                                      }
                                                    } else if (filtro_simple) {
                                                      GetFacturasBy_();
                                                    } else {
                                                      getFacturas();
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    "Moneda",
                                                    textAlign: TextAlign.center,
                                                    style: parametro_moneda
                                                            .isNotEmpty
                                                        ? globalUtility
                                                            .encabezadoTablasOn(
                                                                context)
                                                        : globalUtility
                                                            .encabezadoTablasOff(
                                                                context),
                                                  ),
                                                  onTap: () {
                                                    if (filtro_simple ==
                                                        false) {
                                                      filtro_avanzado = false;
                                                      filtro_simple = true;
                                                    } else {
                                                      filtro_simple = false;
                                                      controller_idddu.clear();
                                                      parametro_idddu = "";
                                                      controller_proveedor
                                                          .clear();
                                                      parametro_proveedor = "";
                                                      controller_esquema
                                                          .clear();
                                                      parametro_esquema = "";
                                                      controller_fecha_doc
                                                          .clear();
                                                      parametro_fecha_doc = "";
                                                      controller_moneda.clear();
                                                      parametro_moneda = "";
                                                    }
                                                    getFacturas();
                                                    setState(() {});
                                                  },
                                                ),
                                                InkWell(
                                                  child: Icon(
                                                      orden == "moneda"
                                                          ? asc == true
                                                              ? Icons
                                                                  .arrow_drop_down
                                                              : Icons
                                                                  .arrow_drop_up
                                                          : Icons
                                                              .arrow_drop_down,
                                                      color: orden == "moneda"
                                                          ? globalUtility
                                                              .primaryBg
                                                          : globalUtility
                                                              .secondary),
                                                  onTap: () {
                                                    if (orden != "moneda") {
                                                      orden = "moneda";
                                                      asc = true;
                                                    } else {
                                                      asc == true
                                                          ? asc = false
                                                          : asc = true;
                                                    }
                                                    if (filtro_avanzado) {
                                                      switch (
                                                          selectedDDOpe[0]) {
                                                        case "=":
                                                          //GetPartidasIgual();
                                                          break;
                                                        case "<":
                                                          //GetPartidasMenor();
                                                          break;
                                                        case "<=":
                                                          //GetPartidasMenorI();
                                                          break;
                                                        case ">":
                                                          //GetPartidasMayor();
                                                          break;
                                                        case ">=":
                                                          //GetPartidasMayorI();
                                                          break;
                                                        case "!=":
                                                          //GetPartidasDif();
                                                          break;
                                                      }
                                                    } else if (filtro_simple) {
                                                      GetFacturasBy_();
                                                    } else {
                                                      getFacturas();
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    "Fecha\nDocumento",
                                                    textAlign: TextAlign.center,
                                                    style: parametro_fecha_doc
                                                            .isNotEmpty
                                                        ? globalUtility
                                                            .encabezadoTablasOn(
                                                                context)
                                                        : globalUtility
                                                            .encabezadoTablasOff(
                                                                context),
                                                  ),
                                                  onTap: () {
                                                    if (filtro_simple ==
                                                        false) {
                                                      filtro_avanzado = false;
                                                      filtro_simple = true;
                                                    } else {
                                                      filtro_simple = false;
                                                      controller_idddu.clear();
                                                      parametro_idddu = "";
                                                      controller_proveedor
                                                          .clear();
                                                      parametro_proveedor = "";
                                                      controller_esquema
                                                          .clear();
                                                      parametro_esquema = "";
                                                      controller_fecha_doc
                                                          .clear();
                                                      parametro_fecha_doc = "";
                                                      controller_moneda.clear();
                                                      parametro_moneda = "";
                                                    }
                                                    getFacturas();
                                                    setState(() {});
                                                  },
                                                ),
                                                InkWell(
                                                  child: Icon(
                                                      orden == "fecha_documento"
                                                          ? asc == true
                                                              ? Icons
                                                                  .arrow_drop_down
                                                              : Icons
                                                                  .arrow_drop_up
                                                          : Icons
                                                              .arrow_drop_down,
                                                      color: orden ==
                                                              "fecha_documento"
                                                          ? globalUtility
                                                              .primaryBg
                                                          : globalUtility
                                                              .secondary),
                                                  onTap: () {
                                                    if (orden !=
                                                        "fecha_documento") {
                                                      orden = "fecha_documento";
                                                      asc = true;
                                                    } else {
                                                      asc == true
                                                          ? asc = false
                                                          : asc = true;
                                                    }
                                                    if (filtro_avanzado) {
                                                      switch (
                                                          selectedDDOpe[0]) {
                                                        case "=":
                                                          //GetPartidasIgual();
                                                          break;
                                                        case "<":
                                                          //GetPartidasMenor();
                                                          break;
                                                        case "<=":
                                                          //GetPartidasMenorI();
                                                          break;
                                                        case ">":
                                                          //GetPartidasMayor();
                                                          break;
                                                        case ">=":
                                                          //GetPartidasMayorI();
                                                          break;
                                                        case "!=":
                                                          //GetPartidasDif();
                                                          break;
                                                      }
                                                    } else if (filtro_simple) {
                                                      GetFacturasBy_();
                                                    } else {
                                                      getFacturas();
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    "Fecha Inicio\nProceso",
                                                    textAlign: TextAlign.center,
                                                    style: globalUtility
                                                        .encabezadoTablasOff(
                                                            context),
                                                  ),
                                                  onTap: () {
                                                    if (filtro_simple ==
                                                        false) {
                                                      filtro_avanzado = false;
                                                      filtro_simple = true;
                                                    } else {
                                                      filtro_simple = false;
                                                      controller_idddu.clear();
                                                      parametro_idddu = "";
                                                      controller_proveedor
                                                          .clear();
                                                      parametro_proveedor = "";
                                                      controller_esquema
                                                          .clear();
                                                      parametro_esquema = "";
                                                      controller_fecha_doc
                                                          .clear();
                                                      parametro_fecha_doc = "";
                                                      controller_moneda.clear();
                                                      parametro_moneda = "";
                                                    }
                                                    getFacturas();
                                                    setState(() {});
                                                  },
                                                ),
                                                InkWell(
                                                  child: Icon(
                                                      orden == "fecha_inicio"
                                                          ? asc == true
                                                              ? Icons
                                                                  .arrow_drop_down
                                                              : Icons
                                                                  .arrow_drop_up
                                                          : Icons
                                                              .arrow_drop_down,
                                                      color: orden ==
                                                              "fecha_inicio"
                                                          ? globalUtility
                                                              .primaryBg
                                                          : globalUtility
                                                              .secondary),
                                                  onTap: () {
                                                    if (orden !=
                                                        "fecha_inicio") {
                                                      orden = "fecha_inicio";
                                                      asc = true;
                                                    } else {
                                                      asc == true
                                                          ? asc = false
                                                          : asc = true;
                                                    }
                                                    if (filtro_avanzado) {
                                                      switch (
                                                          selectedDDOpe[0]) {
                                                        case "=":
                                                          //GetPartidasIgual();
                                                          break;
                                                        case "<":
                                                          //GetPartidasMenor();
                                                          break;
                                                        case "<=":
                                                          //GetPartidasMenorI();
                                                          break;
                                                        case ">":
                                                          //GetPartidasMayor();
                                                          break;
                                                        case ">=":
                                                          //GetPartidasMayorI();
                                                          break;
                                                        case "!=":
                                                          //GetPartidasDif();
                                                          break;
                                                      }
                                                    } else if (filtro_simple) {
                                                      GetFacturasBy_();
                                                    } else {
                                                      getFacturas();
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    "Fecha Limite\nde Pago",
                                                    textAlign: TextAlign.center,
                                                    style: globalUtility
                                                        .encabezadoTablasOff(
                                                            context),
                                                  ),
                                                  onTap: () {
                                                    if (filtro_simple ==
                                                        false) {
                                                      filtro_avanzado = false;
                                                      filtro_simple = true;
                                                    } else {
                                                      filtro_simple = false;
                                                      controller_idddu.clear();
                                                      parametro_idddu = "";
                                                      controller_proveedor
                                                          .clear();
                                                      parametro_proveedor = "";
                                                      controller_esquema
                                                          .clear();
                                                      parametro_esquema = "";
                                                      controller_fecha_doc
                                                          .clear();
                                                      parametro_fecha_doc = "";
                                                      controller_moneda.clear();
                                                      parametro_moneda = "";
                                                    }
                                                    getFacturas();
                                                    setState(() {});
                                                  },
                                                ),
                                                InkWell(
                                                  child: Icon(
                                                      orden == "fecha_limite"
                                                          ? asc == true
                                                              ? Icons
                                                                  .arrow_drop_down
                                                              : Icons
                                                                  .arrow_drop_up
                                                          : Icons
                                                              .arrow_drop_down,
                                                      color: orden ==
                                                              "fecha_limite"
                                                          ? globalUtility
                                                              .primaryBg
                                                          : globalUtility
                                                              .secondary),
                                                  onTap: () {
                                                    if (orden !=
                                                        "fecha_limite") {
                                                      orden = "fecha_limite";
                                                      asc = true;
                                                    } else {
                                                      asc == true
                                                          ? asc = false
                                                          : asc = true;
                                                    }
                                                    if (filtro_avanzado) {
                                                      switch (
                                                          selectedDDOpe[0]) {
                                                        case "=":
                                                          //GetPartidasIgual();
                                                          break;
                                                        case "<":
                                                          //GetPartidasMenor();
                                                          break;
                                                        case "<=":
                                                          //GetPartidasMenorI();
                                                          break;
                                                        case ">":
                                                          //GetPartidasMayor();
                                                          break;
                                                        case ">=":
                                                          //GetPartidasMayorI();
                                                          break;
                                                        case "!=":
                                                          //GetPartidasDif();
                                                          break;
                                                      }
                                                    } else if (filtro_simple) {
                                                      GetFacturasBy_();
                                                    } else {
                                                      getFacturas();
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    "Fecha de\nPago",
                                                    textAlign: TextAlign.center,
                                                    style: globalUtility
                                                        .encabezadoTablasOff(
                                                            context),
                                                  ),
                                                  onTap: () {
                                                    if (filtro_simple ==
                                                        false) {
                                                      filtro_avanzado = false;
                                                      filtro_simple = true;
                                                    } else {
                                                      filtro_simple = false;
                                                      controller_idddu.clear();
                                                      parametro_idddu = "";
                                                      controller_proveedor
                                                          .clear();
                                                      parametro_proveedor = "";
                                                      controller_esquema
                                                          .clear();
                                                      parametro_esquema = "";
                                                      controller_fecha_doc
                                                          .clear();
                                                      parametro_fecha_doc = "";
                                                      controller_moneda.clear();
                                                      parametro_moneda = "";
                                                    }
                                                    getFacturas();
                                                    setState(() {});
                                                  },
                                                ),
                                                InkWell(
                                                  child: Icon(
                                                      orden == "fecha_pago"
                                                          ? asc == true
                                                              ? Icons
                                                                  .arrow_drop_down
                                                              : Icons
                                                                  .arrow_drop_up
                                                          : Icons
                                                              .arrow_drop_down,
                                                      color:
                                                          orden == "fecha_pago"
                                                              ? globalUtility
                                                                  .primaryBg
                                                              : globalUtility
                                                                  .secondary),
                                                  onTap: () {
                                                    if (orden != "fecha_pago") {
                                                      orden = "fecha_pago";
                                                      asc = true;
                                                    } else {
                                                      asc == true
                                                          ? asc = false
                                                          : asc = true;
                                                    }
                                                    if (filtro_avanzado) {
                                                      switch (
                                                          selectedDDOpe[0]) {
                                                        case "=":
                                                          //GetPartidasIgual();
                                                          break;
                                                        case "<":
                                                          //GetPartidasMenor();
                                                          break;
                                                        case "<=":
                                                          //GetPartidasMenorI();
                                                          break;
                                                        case ">":
                                                          //GetPartidasMayor();
                                                          break;
                                                        case ">=":
                                                          //GetPartidasMayorI();
                                                          break;
                                                        case "!=":
                                                          //GetPartidasDif();
                                                          break;
                                                      }
                                                    } else if (filtro_simple) {
                                                      GetFacturasBy_();
                                                    } else {
                                                      getFacturas();
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    "Estatus",
                                                    textAlign: TextAlign.center,
                                                    style: globalUtility
                                                        .encabezadoTablasOff(
                                                            context),
                                                  ),
                                                  onTap: () {
                                                    if (filtro_simple ==
                                                        false) {
                                                      filtro_avanzado = false;
                                                      filtro_simple = true;
                                                    } else {
                                                      filtro_simple = false;
                                                      controller_idddu.clear();
                                                      parametro_idddu = "";
                                                      controller_proveedor
                                                          .clear();
                                                      parametro_proveedor = "";
                                                      controller_esquema
                                                          .clear();
                                                      parametro_esquema = "";
                                                      controller_fecha_doc
                                                          .clear();
                                                      parametro_fecha_doc = "";
                                                      controller_moneda.clear();
                                                      parametro_moneda = "";
                                                    }
                                                    getFacturas();
                                                    setState(() {});
                                                  },
                                                ),
                                                InkWell(
                                                  child: Icon(
                                                      orden == "estatus"
                                                          ? asc == true
                                                              ? Icons
                                                                  .arrow_drop_down
                                                              : Icons
                                                                  .arrow_drop_up
                                                          : Icons
                                                              .arrow_drop_down,
                                                      color: orden == "estatus"
                                                          ? globalUtility
                                                              .primaryBg
                                                          : globalUtility
                                                              .secondary),
                                                  onTap: () {
                                                    if (orden != "estatus") {
                                                      orden = "estatus";
                                                      asc = true;
                                                    } else {
                                                      asc == true
                                                          ? asc = false
                                                          : asc = true;
                                                    }
                                                    if (filtro_avanzado) {
                                                      switch (
                                                          selectedDDOpe[0]) {
                                                        case "=":
                                                          //GetPartidasIgual();
                                                          break;
                                                        case "<":
                                                          //GetPartidasMenor();
                                                          break;
                                                        case "<=":
                                                          //GetPartidasMenorI();
                                                          break;
                                                        case ">":
                                                          //GetPartidasMayor();
                                                          break;
                                                        case ">=":
                                                          //GetPartidasMayorI();
                                                          break;
                                                        case "!=":
                                                          //GetPartidasDif();
                                                          break;
                                                      }
                                                    } else if (filtro_simple) {
                                                      GetFacturasBy_();
                                                    } else {
                                                      getFacturas();
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Acciones',
                                              textAlign: TextAlign.center,
                                              style: globalUtility
                                                  .encabezadoTablasOff(context),
                                            ),
                                          ),
                                        ],
                                      ),
                                      filtro_simple == true
                                          ? Row(
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Container(
                                                      height: 30,
                                                      width: 85,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color: globalUtility
                                                              .primaryBg,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          vertical: 9,
                                                          horizontal: 5,
                                                        ),
                                                        child: TextField(
                                                          controller:
                                                              controller_idddu,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                          onChanged: (value) {
                                                            parametro_idddu =
                                                                value
                                                                    .toString();
                                                            GetFacturasBy_();
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Container(
                                                      height: 30,
                                                      width: 85,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color: globalUtility
                                                              .primaryBg,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          vertical: 9,
                                                          horizontal: 5,
                                                        ),
                                                        child: TextField(
                                                          controller:
                                                              controller_proveedor,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                          onChanged: (value) {
                                                            parametro_proveedor =
                                                                value
                                                                    .toString();
                                                            GetFacturasBy_();
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Container(
                                                      height: 30,
                                                      width: 85,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color: globalUtility
                                                              .primaryBg,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          vertical: 9,
                                                          horizontal: 5,
                                                        ),
                                                        child: TextField(
                                                          controller:
                                                              controller_factura,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                          onChanged: (value) {
                                                            parametro_factura =
                                                                value
                                                                    .toString();
                                                            GetFacturasBy_();
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Container(
                                                      height: 30,
                                                      width: 85,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color: globalUtility
                                                              .primaryBg,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          vertical: 9,
                                                          horizontal: 5,
                                                        ),
                                                        child: TextField(
                                                          controller:
                                                              controller_esquema,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                          onChanged: (value) {
                                                            parametro_esquema =
                                                                value
                                                                    .toString();
                                                            GetFacturasBy_();
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Container(
                                                      height: 30,
                                                      width: 85,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color: globalUtility
                                                              .primaryBg,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          vertical: 9,
                                                          horizontal: 5,
                                                        ),
                                                        child: TextField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          controller:
                                                              controller_moneda,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                          onChanged: (value) {
                                                            parametro_moneda =
                                                                value
                                                                    .toString();
                                                            GetFacturasBy_();
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Container(
                                                      height: 30,
                                                      width: 85,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color: globalUtility
                                                              .primaryBg,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          vertical: 9,
                                                          horizontal: 5,
                                                        ),
                                                        child: TextField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          controller:
                                                              controller_fecha_doc,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                          onChanged: (value) {
                                                            parametro_fecha_doc =
                                                                value
                                                                    .toString();
                                                            GetFacturasBy_();
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Container(
                                                      height: 30,
                                                      width: 85,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color: globalUtility
                                                              .primaryBg,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          vertical: 9,
                                                          horizontal: 5,
                                                        ),
                                                        child: TextField(
                                                          controller:
                                                              controller_fecha_inicio,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                          onChanged: (value) {
                                                            parametro_fecha_inicio =
                                                                value
                                                                    .toString();
                                                            GetFacturasBy_();
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Container(
                                                      height: 30,
                                                      width: 85,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color: globalUtility
                                                              .primaryBg,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          vertical: 9,
                                                          horizontal: 5,
                                                        ),
                                                        child: TextField(
                                                          controller:
                                                              controller_fecha_limite,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                          onChanged: (value) {
                                                            parametro_fecha_limite =
                                                                value
                                                                    .toString();
                                                            GetFacturasBy_();
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Container(
                                                      height: 30,
                                                      width: 85,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color: globalUtility
                                                              .primaryBg,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          vertical: 9,
                                                          horizontal: 5,
                                                        ),
                                                        child: TextField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          controller:
                                                              controller_fecha_pago,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                          onChanged: (value) {
                                                            parametro_fecha_pago =
                                                                value
                                                                    .toString();
                                                            GetFacturasBy_();
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Container(
                                                      height: 30,
                                                      width: 85,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color: globalUtility
                                                              .primaryBg,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          vertical: 9,
                                                          horizontal: 5,
                                                        ),
                                                        child: TextField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          controller:
                                                              controller_estatus,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                          onChanged: (value) {
                                                            parametro_estatus =
                                                                value
                                                                    .toString();
                                                            GetFacturasBy_();
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const Expanded(
                                                    child: SizedBox())
                                              ],
                                            )
                                          : const SizedBox(
                                              height: 0,
                                              width: 0,
                                            )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: SingleChildScrollView(
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: list_facturas.length,
                                  itemBuilder: (context, index) {
                                    final factura = list_facturas[index];
                                    return Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 10, 0, 0),
                                      child: Material(
                                        color: Colors.transparent,
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Container(
                                          width: double.infinity,
                                          height: 55,
                                          decoration: BoxDecoration(
                                            color: globalUtility.primaryBg,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(5, 5, 5, 5),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    factura[0].toString(),
                                                    textAlign: TextAlign.center,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    factura[1].toString(),
                                                    textAlign: TextAlign.start,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    factura[2].toString(),
                                                    textAlign: TextAlign.center,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    factura[3].toString(),
                                                    textAlign: TextAlign.end,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    factura[4].toString(),
                                                    textAlign: TextAlign.center,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    factura[5].toString(),
                                                    textAlign: TextAlign.end,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    factura[6].toString(),
                                                    textAlign: TextAlign.center,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.circle,
                                                  color: factura[7] != "-" &&
                                                          factura[6] != "-"
                                                      ? Colors.green
                                                      : Colors.red,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    factura[7].toString(),
                                                    textAlign: TextAlign.center,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    factura[8].toString(),
                                                    textAlign: TextAlign.end,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    factura[9].toString(),
                                                    textAlign: TextAlign.end,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      factura[9] ==
                                                              'NC Pendiente'
                                                          ? Material(
                                                              child: InkWell(
                                                                onTap:
                                                                    () async {
                                                                  await showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return PopupNotaCredito(
                                                                          partidasSapId:
                                                                              factura[10],
                                                                        );
                                                                      });
                                                                  await getFacturas();
                                                                },
                                                                child: Icon(
                                                                  Icons
                                                                      .description,
                                                                  color: globalUtility
                                                                      .secondary,
                                                                  size: 30,
                                                                ),
                                                              ),
                                                            )
                                                          : Container(),
                                                      factura[9] == 'Pagado'
                                                          ? Material(
                                                              child: InkWell(
                                                                onTap:
                                                                    () async {
                                                                  await SupabaseQueries
                                                                      .completarFactura(
                                                                    factura[10],
                                                                  );
                                                                  getFacturas();
                                                                },
                                                                child: Icon(
                                                                  Icons.check,
                                                                  color: globalUtility
                                                                      .secondary,
                                                                  size: 30,
                                                                ),
                                                              ),
                                                            )
                                                          : Container(),
                                                      Material(
                                                        child: InkWell(
                                                          onTap: () {},
                                                          child: Icon(
                                                            Icons.visibility,
                                                            color: globalUtility
                                                                .secondary,
                                                            size: 30,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
