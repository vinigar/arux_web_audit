import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:arux/models/seguimiento_facturas.dart';
import 'package:arux/pages/seguimiento_facturas/widgets/detalle_factura_popup.dart';
import 'package:arux/functions/date_format.dart';
import 'package:arux/helpers/supabase/queries.dart';
import 'package:arux/helpers/global_utility.dart';
import 'package:arux/helpers/globals.dart';
import 'package:arux/models/get_gestor_partidas_qt.dart';
import 'package:arux/pages/seguimiento_facturas/widgets/popup_nota_credito.dart';
import 'package:arux/pages/widgets/side_menu/side_menu.dart';
import 'package:arux/pages/widgets/top_menu/top_menu.dart';

class SeguimientoDeFacturasPage extends StatefulWidget {
  const SeguimientoDeFacturasPage({Key? key}) : super(key: key);

  @override
  State<SeguimientoDeFacturasPage> createState() =>
      _SeguimientoDeFacturasPageState();
}

class _SeguimientoDeFacturasPageState extends State<SeguimientoDeFacturasPage> {
  GlobalUtility globalUtility = GlobalUtility();
  final formKey = GlobalKey<FormState>();

  final busquedaController = TextEditingController();
  final iddduController = TextEditingController();
  final proveedorController = TextEditingController();
  final facturaController = TextEditingController();
  final esquemaController = TextEditingController();
  final monedaController = TextEditingController();
  final fechaDocController = TextEditingController();
  final fechaInicioController = TextEditingController();
  final fechaLimiteController = TextEditingController();
  final fechaPagoController = TextEditingController();
  final estatusController = TextEditingController();
  final busquedaFiltroController = TextEditingController();

  bool filtroSimple = false;
  bool filtroAvanzado = false;

  List<SeguimientoFacturas> seguimientoFacturas = [];
  List<List<dynamic>> facturas = [];
  String orden = "idddu";
  bool asc = true;
  int countI = 0;
  int countF = 19;

  bool popupRise = false;
  List<String?> selectedDDEnc = ["Registro SAP"];
  List<String?> selectedDDEncTransf = [""];
  List<String?> selectedDDOpe = ["="];
  List<String?> parametroFilt = [""];

  @override
  void initState() {
    getFacturas();
    super.initState();
  }

  Future<void> getFacturas() async {
    final res = await supabase
        .rpc('get_seguimiento_factura',
            params: {'busqueda': busquedaController.text})
        .order(orden, ascending: asc)
        .range(0, countF)
        .execute();

    if (res.hasError) {
      print("-----Error: ${res.error}");
      return;
    }

    seguimientoFacturas = (res.data as List<dynamic>)
        .map((factura) => SeguimientoFacturas.fromJson(jsonEncode(factura)))
        .toList();

    setState(() {});
  }

  //TODO: agregar pk a consulta
  Future<void> getFacturasBy_() async {
    try {
      dynamic response = await supabase
          .rpc('get_gestor_partidas_push_by__', params: {
            'idpartida': iddduController.text,
            'proveedor': proveedorController.text,
            'referencia': esquemaController.text,
            'importe': fechaDocController.text,
            'moneda': monedaController.text
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

      facturas = [];

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

        facturas.add(localList);
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
                                                      busquedaController,
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
                                                  onChanged: (value) async {
                                                    if (filtroAvanzado) {
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
                                                      await getFacturas();
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
                                      width: 130,
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
                                              InkWell(
                                                child: Container(
                                                  width: 25,
                                                  height: 23.5,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        globalUtility.primary,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(0),
                                                      bottomRight:
                                                          Radius.circular(0),
                                                      topLeft:
                                                          Radius.circular(30),
                                                      topRight:
                                                          Radius.circular(0),
                                                    ),
                                                  ),
                                                  child: const Icon(
                                                    Icons.arrow_drop_up_sharp,
                                                    color: Colors.white,
                                                    size: 18,
                                                  ),
                                                ),
                                                onTap: () async {
                                                  if (filtroSimple == false ||
                                                      filtroAvanzado == false) {
                                                    countF++;
                                                    await getFacturas();
                                                  }
                                                  setState(() {});
                                                },
                                              ),
                                              InkWell(
                                                child: Container(
                                                  width: 25,
                                                  height: 23.5,
                                                  decoration: BoxDecoration(
                                                    color: countF == 0
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
                                                onTap: () async {
                                                  if (filtroSimple == false ||
                                                      filtroAvanzado == false) {
                                                    if (countF >= 1) {
                                                      countF--;
                                                      await getFacturas();
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
                                                  width: 50,
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
                                                      onChanged: (value) async {
                                                        try {
                                                          print(
                                                              "---Valor: ${value.toString()}");
                                                          if (value
                                                                  .isNotEmpty ||
                                                              value != "0") {
                                                            countF = int.parse(
                                                                value
                                                                    .toString());
                                                            countF = countF - 1;
                                                            await getFacturas();
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
                                                    style: iddduController
                                                            .text.isNotEmpty
                                                        ? globalUtility
                                                            .encabezadoTablasOn(
                                                                context)
                                                        : globalUtility
                                                            .encabezadoTablasOff(
                                                                context),
                                                  ),
                                                  onTap: () async {
                                                    if (filtroSimple == false) {
                                                      filtroAvanzado = false;
                                                      filtroSimple = true;
                                                    } else {
                                                      filtroSimple = false;
                                                      iddduController.clear();
                                                      proveedorController
                                                          .clear();
                                                      esquemaController.clear();
                                                      fechaDocController
                                                          .clear();
                                                      monedaController.clear();
                                                    }
                                                    await getFacturas();
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
                                                  onTap: () async {
                                                    if (orden != "idddu") {
                                                      orden = "idddu";
                                                      asc = true;
                                                    } else {
                                                      asc == true
                                                          ? asc = false
                                                          : asc = true;
                                                    }
                                                    if (filtroAvanzado) {
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
                                                    } else if (filtroSimple) {
                                                      getFacturasBy_();
                                                    } else {
                                                      await getFacturas();
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
                                                    style: proveedorController
                                                            .text.isNotEmpty
                                                        ? globalUtility
                                                            .encabezadoTablasOn(
                                                                context)
                                                        : globalUtility
                                                            .encabezadoTablasOff(
                                                                context),
                                                  ),
                                                  onTap: () async {
                                                    if (filtroSimple == false) {
                                                      filtroAvanzado = false;
                                                      filtroSimple = true;
                                                    } else {
                                                      filtroSimple = false;
                                                      iddduController.clear();
                                                      proveedorController
                                                          .clear();
                                                      esquemaController.clear();
                                                      fechaDocController
                                                          .clear();
                                                      monedaController.clear();
                                                    }
                                                    await getFacturas();
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
                                                  onTap: () async {
                                                    if (orden != "proveedor") {
                                                      orden = "proveedor";
                                                      asc = true;
                                                    } else {
                                                      asc == true
                                                          ? asc = false
                                                          : asc = true;
                                                    }
                                                    if (filtroAvanzado) {
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
                                                    } else if (filtroSimple) {
                                                      getFacturasBy_();
                                                    } else {
                                                      await getFacturas();
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
                                                    style: esquemaController
                                                            .text.isNotEmpty
                                                        ? globalUtility
                                                            .encabezadoTablasOn(
                                                                context)
                                                        : globalUtility
                                                            .encabezadoTablasOff(
                                                                context),
                                                  ),
                                                  onTap: () async {
                                                    if (filtroSimple == false) {
                                                      filtroAvanzado = false;
                                                      filtroSimple = true;
                                                    } else {
                                                      filtroSimple = false;
                                                      iddduController.clear();
                                                      proveedorController
                                                          .clear();
                                                      esquemaController.clear();
                                                      fechaDocController
                                                          .clear();
                                                      monedaController.clear();
                                                    }
                                                    await getFacturas();
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
                                                  onTap: () async {
                                                    if (orden != "factura") {
                                                      orden = "factura";
                                                      asc = true;
                                                    } else {
                                                      asc == true
                                                          ? asc = false
                                                          : asc = true;
                                                    }
                                                    if (filtroAvanzado) {
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
                                                    } else if (filtroSimple) {
                                                      getFacturasBy_();
                                                    } else {
                                                      await getFacturas();
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
                                                    style: esquemaController
                                                            .text.isNotEmpty
                                                        ? globalUtility
                                                            .encabezadoTablasOn(
                                                                context)
                                                        : globalUtility
                                                            .encabezadoTablasOff(
                                                                context),
                                                  ),
                                                  onTap: () async {
                                                    if (filtroSimple == false) {
                                                      filtroAvanzado = false;
                                                      filtroSimple = true;
                                                    } else {
                                                      filtroSimple = false;
                                                      iddduController.clear();
                                                      proveedorController
                                                          .clear();
                                                      esquemaController.clear();
                                                      fechaDocController
                                                          .clear();
                                                      monedaController.clear();
                                                    }
                                                    await getFacturas();
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
                                                  onTap: () async {
                                                    if (orden != "esquema") {
                                                      orden = "esquema";
                                                      asc = true;
                                                    } else {
                                                      asc == true
                                                          ? asc = false
                                                          : asc = true;
                                                    }
                                                    if (filtroAvanzado) {
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
                                                    } else if (filtroSimple) {
                                                      getFacturasBy_();
                                                    } else {
                                                      await getFacturas();
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
                                                    style: monedaController
                                                            .text.isNotEmpty
                                                        ? globalUtility
                                                            .encabezadoTablasOn(
                                                                context)
                                                        : globalUtility
                                                            .encabezadoTablasOff(
                                                                context),
                                                  ),
                                                  onTap: () async {
                                                    if (filtroSimple == false) {
                                                      filtroAvanzado = false;
                                                      filtroSimple = true;
                                                    } else {
                                                      filtroSimple = false;
                                                      iddduController.clear();
                                                      proveedorController
                                                          .clear();
                                                      esquemaController.clear();
                                                      fechaDocController
                                                          .clear();
                                                      monedaController.clear();
                                                    }
                                                    await getFacturas();
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
                                                  onTap: () async {
                                                    if (orden != "moneda") {
                                                      orden = "moneda";
                                                      asc = true;
                                                    } else {
                                                      asc == true
                                                          ? asc = false
                                                          : asc = true;
                                                    }
                                                    if (filtroAvanzado) {
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
                                                    } else if (filtroSimple) {
                                                      getFacturasBy_();
                                                    } else {
                                                      await getFacturas();
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
                                                    style: fechaDocController
                                                            .text.isNotEmpty
                                                        ? globalUtility
                                                            .encabezadoTablasOn(
                                                                context)
                                                        : globalUtility
                                                            .encabezadoTablasOff(
                                                                context),
                                                  ),
                                                  onTap: () async {
                                                    if (filtroSimple == false) {
                                                      filtroAvanzado = false;
                                                      filtroSimple = true;
                                                    } else {
                                                      filtroSimple = false;
                                                      iddduController.clear();
                                                      proveedorController
                                                          .clear();
                                                      esquemaController.clear();
                                                      fechaDocController
                                                          .clear();
                                                      monedaController.clear();
                                                    }
                                                    await getFacturas();
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
                                                  onTap: () async {
                                                    if (orden !=
                                                        "fecha_documento") {
                                                      orden = "fecha_documento";
                                                      asc = true;
                                                    } else {
                                                      asc == true
                                                          ? asc = false
                                                          : asc = true;
                                                    }
                                                    if (filtroAvanzado) {
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
                                                    } else if (filtroSimple) {
                                                      getFacturasBy_();
                                                    } else {
                                                      await getFacturas();
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
                                                  onTap: () async {
                                                    if (filtroSimple == false) {
                                                      filtroAvanzado = false;
                                                      filtroSimple = true;
                                                    } else {
                                                      filtroSimple = false;
                                                      iddduController.clear();
                                                      proveedorController
                                                          .clear();
                                                      esquemaController.clear();
                                                      fechaDocController
                                                          .clear();
                                                      monedaController.clear();
                                                    }
                                                    await getFacturas();
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
                                                  onTap: () async {
                                                    if (orden !=
                                                        "fecha_inicio") {
                                                      orden = "fecha_inicio";
                                                      asc = true;
                                                    } else {
                                                      asc == true
                                                          ? asc = false
                                                          : asc = true;
                                                    }
                                                    if (filtroAvanzado) {
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
                                                    } else if (filtroSimple) {
                                                      getFacturasBy_();
                                                    } else {
                                                      await getFacturas();
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
                                                  onTap: () async {
                                                    if (filtroSimple == false) {
                                                      filtroAvanzado = false;
                                                      filtroSimple = true;
                                                    } else {
                                                      filtroSimple = false;
                                                      iddduController.clear();
                                                      proveedorController
                                                          .clear();
                                                      esquemaController.clear();
                                                      fechaDocController
                                                          .clear();
                                                      monedaController.clear();
                                                    }
                                                    await getFacturas();
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
                                                  onTap: () async {
                                                    if (orden !=
                                                        "fecha_limite") {
                                                      orden = "fecha_limite";
                                                      asc = true;
                                                    } else {
                                                      asc == true
                                                          ? asc = false
                                                          : asc = true;
                                                    }
                                                    if (filtroAvanzado) {
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
                                                    } else if (filtroSimple) {
                                                      getFacturasBy_();
                                                    } else {
                                                      await getFacturas();
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
                                                  onTap: () async {
                                                    if (filtroSimple == false) {
                                                      filtroAvanzado = false;
                                                      filtroSimple = true;
                                                    } else {
                                                      filtroSimple = false;
                                                      iddduController.clear();
                                                      proveedorController
                                                          .clear();
                                                      esquemaController.clear();
                                                      fechaDocController
                                                          .clear();
                                                      monedaController.clear();
                                                    }
                                                    await getFacturas();
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
                                                  onTap: () async {
                                                    if (orden != "fecha_pago") {
                                                      orden = "fecha_pago";
                                                      asc = true;
                                                    } else {
                                                      asc == true
                                                          ? asc = false
                                                          : asc = true;
                                                    }
                                                    if (filtroAvanzado) {
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
                                                    } else if (filtroSimple) {
                                                      getFacturasBy_();
                                                    } else {
                                                      await getFacturas();
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
                                                  onTap: () async {
                                                    if (filtroSimple == false) {
                                                      filtroAvanzado = false;
                                                      filtroSimple = true;
                                                    } else {
                                                      filtroSimple = false;
                                                      iddduController.clear();
                                                      proveedorController
                                                          .clear();
                                                      esquemaController.clear();
                                                      fechaDocController
                                                          .clear();
                                                      monedaController.clear();
                                                    }
                                                    await getFacturas();
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
                                                  onTap: () async {
                                                    if (orden != "estatus") {
                                                      orden = "estatus";
                                                      asc = true;
                                                    } else {
                                                      asc == true
                                                          ? asc = false
                                                          : asc = true;
                                                    }
                                                    if (filtroAvanzado) {
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
                                                    } else if (filtroSimple) {
                                                      getFacturasBy_();
                                                    } else {
                                                      await getFacturas();
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
                                      filtroSimple == true
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
                                                              iddduController,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                          onChanged: (value) {
                                                            getFacturasBy_();
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
                                                              proveedorController,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                          onChanged: (value) {
                                                            getFacturasBy_();
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
                                                              facturaController,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                          onChanged: (value) {
                                                            getFacturasBy_();
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
                                                              esquemaController,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                          onChanged: (value) {
                                                            getFacturasBy_();
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
                                                              monedaController,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                          onChanged: (value) {
                                                            getFacturasBy_();
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
                                                              fechaDocController,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                          onChanged: (value) {
                                                            getFacturasBy_();
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
                                                              fechaInicioController,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                          onChanged: (value) {
                                                            getFacturasBy_();
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
                                                              fechaLimiteController,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                          onChanged: (value) {
                                                            getFacturasBy_();
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
                                                              fechaPagoController,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                          onChanged: (value) {
                                                            getFacturasBy_();
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
                                                              estatusController,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                          onChanged: (value) {
                                                            getFacturasBy_();
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
                                  itemCount: seguimientoFacturas.length,
                                  itemBuilder: (context, index) {
                                    final factura = seguimientoFacturas[index];
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
                                                    factura.idddu,
                                                    textAlign: TextAlign.center,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    factura.proveedor,
                                                    textAlign: TextAlign.start,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    factura.factura,
                                                    textAlign: TextAlign.center,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    factura.esquema,
                                                    textAlign: TextAlign.end,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    factura.moneda,
                                                    textAlign: TextAlign.center,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    dateFormat(
                                                        factura.fechaDocumento),
                                                    textAlign: TextAlign.end,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    dateFormat(
                                                        factura.fechaInicio),
                                                    textAlign: TextAlign.center,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Icon(Icons.circle,
                                                    color: factura.semaforo ==
                                                            "VERDE"
                                                        ? Colors.green
                                                        : factura.semaforo ==
                                                                "AMARILLO"
                                                            ? Colors.yellow
                                                            : Colors.red),
                                                Expanded(
                                                  child: Text(
                                                    dateFormat(
                                                        factura.fechaLimite),
                                                    textAlign: TextAlign.center,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    dateFormat(
                                                        factura.fechaPago),
                                                    textAlign: TextAlign.end,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    factura.estatus,
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
                                                            .center,
                                                    children: [
                                                      factura.estatus ==
                                                              'NC Pendiente'
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                horizontal: 5,
                                                              ),
                                                              child: Material(
                                                                child: InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    await showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return FolioNotaCreditoPopup(
                                                                            partidasSapId:
                                                                                factura.idPartidasPk,
                                                                            formKey:
                                                                                formKey,
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
                                                              ),
                                                            )
                                                          : Container(),
                                                      factura.estatus ==
                                                              'Pagado'
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                horizontal: 5,
                                                              ),
                                                              child: Material(
                                                                child: InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    await SupabaseQueries
                                                                        .completarFactura(
                                                                      factura
                                                                          .idPartidasPk,
                                                                    );
                                                                    await getFacturas();
                                                                  },
                                                                  child: Icon(
                                                                    Icons.check,
                                                                    color: globalUtility
                                                                        .secondary,
                                                                    size: 30,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          : Container(),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 5,
                                                        ),
                                                        child: Material(
                                                          child: InkWell(
                                                            onTap: () async {
                                                              await showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return DetalleFacturaPopup(
                                                                      factura:
                                                                          factura,
                                                                    );
                                                                  });
                                                            },
                                                            child: Icon(
                                                              Icons.visibility,
                                                              color:
                                                                  globalUtility
                                                                      .secondary,
                                                              size: 30,
                                                            ),
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
