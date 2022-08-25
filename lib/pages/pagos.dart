import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

import 'package:arux/functions/date_format.dart';
import 'package:arux/functions/money_format.dart';
import 'package:arux/helpers/global_utility.dart';
import 'package:arux/helpers/globals.dart';
import 'package:arux/models/get_gestor_partidas_qt.dart';
import 'package:arux/models/get_proveedores_qt.dart';
import 'package:arux/models/get_sociedades_by_id_proveedor.dart';
import 'package:arux/models/get_pagos_qt.dart';
import 'package:arux/pages/widgets/side_menu/side_menu.dart';
import 'package:arux/pages/widgets/top_menu/top_menu.dart';
import 'package:arux/helpers/supabase/queries.dart';

class Pagos extends StatefulWidget {
  const Pagos({Key? key}) : super(key: key);

  @override
  State<Pagos> createState() => _PagosState();
}

class _PagosState extends State<Pagos> {
  GlobalUtility globalUtility = GlobalUtility();

  final controllerBusqueda = TextEditingController();
  String parametroBusqueda = "";

  final controllerProveedor = TextEditingController();
  String parametroProveedor = "";
  final controllerCuentaSap = TextEditingController();
  String parametroCuentaSap = "";
  final controllerEsquema = TextEditingController();
  String parametroEsquema = "";
  final controllerEstado = TextEditingController();
  String parametroEstado = "";

  List<List<dynamic>> listPagos = [];
  String orden = "fecha_extraccion";
  String orden_2 = "sociedad";
  bool asc = true;
  bool asc_2 = true;
  final controllerCount = TextEditingController();
  int countI = 0;
  int countF = 19;

  bool popupRise = false;
  List<String?> selectedDDEnc = ["Registro SAP"];
  List<String?> selectedDDEncTransf = [""];
  List<String?> selectedDDOpe = ["="];
  List<String?> parametroFilt = [""];
  final controllerBusquedaFiltro = TextEditingController();

  bool filtroAvanzado = false;
  bool filtroSimple = false;

  @override
  void initState() {
    getPagos();
    super.initState();
  }

  Future<void> getPagos() async {
    try {
      dynamic response = await supabase
          .rpc('get_pagos', params: {'busqueda': parametroBusqueda})
          .order(orden, ascending: asc)
          .execute();

      // print("-----Error: ${response.error}");

      response = jsonEncode(response);

      GetPagosQt getPagosQTResponse = getPagosQtFromMap(response);

      listPagos = [];

      for (var i = 0; i < getPagosQTResponse.data.length; i++) {
        List<dynamic> localList = [];

        localList.add(dateFormat(getPagosQTResponse.data[i].fechaExtraccion));
        localList.add(getPagosQTResponse.data[i].moneda);
        localList.add(getPagosQTResponse.data[i].esquema);
        localList.add(getPagosQTResponse.data[i].estatus);
        localList.add(getPagosQTResponse.data[i].acreedor);
        localList.add(getPagosQTResponse.data[i].proveedor);
        localList.add(getPagosQTResponse.data[i].idPartida);
        localList.add(getPagosQTResponse.data[i].noDocPartida);
        localList.add(getPagosQTResponse.data[i].referenciaPartida);
        localList.add(getPagosQTResponse.data[i].importePartida);
        localList.add(getPagosQTResponse.data[i].idNc);
        localList.add(getPagosQTResponse.data[i].noDocNc);
        localList.add(getPagosQTResponse.data[i].referenciaNc);
        localList.add(getPagosQTResponse.data[i].descuentoProveedor);
        localList.add(getPagosQTResponse.data[i].dpp);
        localList.add(getPagosQTResponse.data[i].total);
        listPagos.add(localList);
      }
    } catch (e) {
      // print(e);
    }

    setState(() {});
  }

  Future<void> getPartidasMenor() async {
    try {
      listPagos = [];

      dynamic response = await supabase
          .rpc('get_gestor_partidas', params: {'busqueda': parametroBusqueda})
          .lt('${selectedDDEncTransf[0]}', '${parametroFilt[0]}')
          .order(orden, ascending: asc)
          .execute();

      // print("-----Error: ${response.error}");

      response = jsonEncode(response);

      // print("-----Parametro de Busqueda: $parametroBusqueda");
      // print("-----Response: ");
      // print(response.toString());

      GetGestorPartidasQt getPagosQTResponse =
          getGestorPartidasQtFromMap(response);

      for (var i = 0; i < getPagosQTResponse.data.length; i++) {
        List<dynamic> localList = [];

        localList.add(getPagosQTResponse.data[i].idPartidasPk);
        localList.add(getPagosQTResponse.data[i].proveedor);
        localList.add(getPagosQTResponse.data[i].referencia);
        localList.add("\$ ${getPagosQTResponse.data[i].importe}");
        localList.add(getPagosQTResponse.data[i].moneda);
        localList.add("\$ ${getPagosQTResponse.data[i].importeUsd}");
        localList.add(getPagosQTResponse.data[i].diasPago);
        localList.add("${getPagosQTResponse.data[i].porcDpp} %");
        localList.add("${getPagosQTResponse.data[i].cantDpp}");
        localList.add("\$ ${getPagosQTResponse.data[i].prontoPago}");

        listPagos.add(localList);
      }
    } catch (e) {
      // print(e);
    }

    setState(() {});
  }

  ///////////////////////////////////////////////////////////////////////////////////

  // ignore: non_constant_identifier_names
  Future<void> getPagosBy__() async {
    try {
      dynamic response = await supabase
          .rpc('get_Pagos_by__', params: {
            'proveedor': parametroProveedor,
            'cuenta_sap': parametroCuentaSap,
            'esquema': parametroEsquema,
            'estado': parametroEstado
          })
          .order(orden, ascending: asc)
          .range(0, countF)
          .execute();

      response = jsonEncode(response);

      GetProveedoresQt getPagosQTResponse = getProveedoresQtFromMap(response);

      listPagos = [];

      for (var i = 0; i < getPagosQTResponse.data.length; i++) {
        List<dynamic> localList = [];
        List<dynamic> localList_2 = [];

        localList.add(getPagosQTResponse.data[i].idProveedor);
        localList.add(getPagosQTResponse.data[i].proveedor);
        localList.add(getPagosQTResponse.data[i].cuentaSap);
        localList.add(getPagosQTResponse.data[i].esquema);
        localList.add(getPagosQTResponse.data[i].estado);

        dynamic response = await supabase
            .rpc('get_sociedades_by_id_proveedor',
                params: {'busqueda': getPagosQTResponse.data[i].idProveedor})
            .order(orden_2, ascending: asc_2)
            .execute();

        // print("-----Error: ${response.error}");

        response = jsonEncode(response);

        /* // print("-----Response: ");
        // print(response.toString()); */

        GetSociedadesByIdProveedorQt getSociedadesByIdProveedorQt =
            getSociedadesByIdProveedorQtFromMap(response);

        for (var j = 0; j < getSociedadesByIdProveedorQt.data.length; j++) {
          List<dynamic> localList_3 = [];

          localList_3.add(getSociedadesByIdProveedorQt.data[j].idsociedad);
          localList_3.add(getSociedadesByIdProveedorQt.data[j].categoria);
          localList_3.add(getSociedadesByIdProveedorQt.data[j].cuenta);
          localList_3.add(getSociedadesByIdProveedorQt.data[j].sociedad);
          localList_3.add(getSociedadesByIdProveedorQt.data[j].telefono);
          localList_3.add(getSociedadesByIdProveedorQt.data[j].contacto);
          localList_3.add(getSociedadesByIdProveedorQt.data[j].diasPago);
          localList_3.add(getSociedadesByIdProveedorQt.data[j].tipo);
          localList_3.add(getSociedadesByIdProveedorQt.data[j].idproveedor);

          localList_2.add(localList_3);
        }

        if (localList_2.isNotEmpty) {
          localList.add(localList_2);
        } else {
          localList.add("Proveedor Sin Sociedad");
        }

        listPagos.add(localList);

        //// print("Indice $i : ${list_Pagos[i]}");
        //// print("Longitud $i : ${list_Pagos[i].length}");
        //// print("Proveedor $i : ${list_Pagos[i][1]}");
        //// print("Sociedades $i : ${list_Pagos[i][5]}");
        //// print("Sociedad 0 $i : ${list_Pagos[i][5][0]}");
        //// print("idSociedad $i : ${list_Pagos[i][5][0][0]}");
      }

      //// print("Listas : ${list_Pagos.length}");

    } catch (e) {
      // print(e);
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
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 30, 0, 0),
                            child: Row(
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
                                      'Pagos',
                                      style:
                                          globalUtility.tituloPagina(context),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 0, 25, 0),
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
                                                Icons.person_add_outlined,
                                                color: globalUtility.primary,
                                                size: 28,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 0, 15, 0),
                                          child: Container(
                                            width: 250,
                                            height: 51,
                                            decoration: BoxDecoration(
                                              color: globalUtility.primaryBg,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              border: Border.all(
                                                color: globalUtility.primary,
                                                width: 1.5,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          10, 0, 0, 0),
                                                  child: Icon(
                                                    Icons.search,
                                                    color:
                                                        globalUtility.primary,
                                                    size: 24,
                                                  ),
                                                ),
                                                Center(
                                                  child: SizedBox(
                                                    width: 200,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 5,
                                                      ),
                                                      child: TextFormField(
                                                        controller:
                                                            controllerBusqueda,
                                                        autofocus: true,
                                                        obscureText: false,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText: 'Buscar',
                                                          hintStyle:
                                                              globalUtility
                                                                  .textoA(
                                                                      context),
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: globalUtility
                                                                  .transparente,
                                                            ),
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: globalUtility
                                                                  .transparente,
                                                            ),
                                                          ),
                                                        ),
                                                        style: globalUtility
                                                            .textoA(context),
                                                        onChanged: (value) {
                                                          parametroBusqueda =
                                                              value;
                                                          if (filtroAvanzado) {
                                                            switch (
                                                                selectedDDOpe[
                                                                    0]) {
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
                                                            getPagos();
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
                                        Container(
                                          width: 250,
                                          height: 51,
                                          decoration: BoxDecoration(
                                            color: globalUtility.primaryBg,
                                            borderRadius:
                                                BorderRadius.circular(30),
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
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      InkWell(
                                                        child: Container(
                                                          width: 25,
                                                          height: 23.5,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: globalUtility
                                                                .primary,
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .only(
                                                              bottomLeft: Radius
                                                                  .circular(0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          0),
                                                              topLeft: Radius
                                                                  .circular(30),
                                                              topRight: Radius
                                                                  .circular(0),
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
                                                          if (filtroSimple ==
                                                                  false ||
                                                              filtroAvanzado ==
                                                                  false) {
                                                            countF++;
                                                            getPagos();
                                                          }
                                                          setState(() {});
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      InkWell(
                                                        child: Container(
                                                          width: 25,
                                                          height: 23.5,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: countF == 0
                                                                ? globalUtility
                                                                    .secondary
                                                                : globalUtility
                                                                    .primary,
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .only(
                                                              bottomLeft: Radius
                                                                  .circular(30),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          0),
                                                              topLeft: Radius
                                                                  .circular(0),
                                                              topRight: Radius
                                                                  .circular(0),
                                                            ),
                                                          ),
                                                          child: const Icon(
                                                            Icons
                                                                .arrow_drop_down_sharp,
                                                            color: Colors.white,
                                                            size: 18,
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          if (filtroSimple ==
                                                                  false ||
                                                              filtroAvanzado ==
                                                                  false) {
                                                            if (countF >= 1) {
                                                              countF--;
                                                              getPagos();
                                                              setState(() {});
                                                            }
                                                          }
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .only(start: 10),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'Filas: ',
                                                          style: globalUtility
                                                              .textoIgual(
                                                                  context),
                                                        ),
                                                        SizedBox(
                                                          width: 100,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10),
                                                            child:
                                                                TextFormField(
                                                              initialValue:
                                                                  "20",
                                                              style: globalUtility
                                                                  .textoA(
                                                                      context),
                                                              decoration: const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                              onChanged:
                                                                  (value) {
                                                                try {
                                                                  // print("---Valor: ${value.toString()}");
                                                                  if (value
                                                                          .isNotEmpty ||
                                                                      value !=
                                                                          "0") {
                                                                    countF = int
                                                                        .parse(value
                                                                            .toString());
                                                                    countF =
                                                                        countF -
                                                                            1;
                                                                    getPagos();
                                                                    setState(
                                                                        () {});
                                                                  }
                                                                } catch (e) {
                                                                  // print("---Error: $e");
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
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                                                    "Fecha de Extración",
                                                    textAlign: TextAlign.center,
                                                    style: parametroProveedor
                                                            .isNotEmpty
                                                        ? globalUtility
                                                            .encabezadoTablasOn(
                                                                context)
                                                        : globalUtility
                                                            .encabezadoTablasOff(
                                                                context),
                                                  ),
                                                  onTap: () {
                                                    if (filtroSimple == false) {
                                                      filtroAvanzado = false;
                                                      filtroSimple = true;
                                                    } else {
                                                      filtroSimple = false;
                                                      controllerProveedor
                                                          .clear();
                                                      parametroProveedor = "";
                                                      controllerCuentaSap
                                                          .clear();
                                                      parametroCuentaSap = "";
                                                      controllerEsquema.clear();
                                                      parametroEsquema = "";
                                                      controllerEstado.clear();
                                                      parametroEstado = "";
                                                    }
                                                    getPagos();
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
                                                      getPagosBy__();
                                                    } else {
                                                      getPagos();
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
                                                    style: parametroCuentaSap
                                                            .isNotEmpty
                                                        ? globalUtility
                                                            .encabezadoTablasOn(
                                                                context)
                                                        : globalUtility
                                                            .encabezadoTablasOff(
                                                                context),
                                                  ),
                                                  onTap: () {
                                                    if (filtroSimple == false) {
                                                      filtroAvanzado = false;
                                                      filtroSimple = true;
                                                    } else {
                                                      filtroSimple = false;
                                                      controllerProveedor
                                                          .clear();
                                                      parametroProveedor = "";
                                                      controllerCuentaSap
                                                          .clear();
                                                      parametroCuentaSap = "";
                                                      controllerEsquema.clear();
                                                      parametroEsquema = "";
                                                      controllerEstado.clear();
                                                      parametroEstado = "";
                                                    }
                                                    getPagos();
                                                    setState(() {});
                                                  },
                                                ),
                                                InkWell(
                                                  child: Icon(
                                                      orden == "cuenta_sap"
                                                          ? asc == true
                                                              ? Icons
                                                                  .arrow_drop_down
                                                              : Icons
                                                                  .arrow_drop_up
                                                          : Icons
                                                              .arrow_drop_down,
                                                      color:
                                                          orden == "cuenta_sap"
                                                              ? globalUtility
                                                                  .primaryBg
                                                              : globalUtility
                                                                  .secondary),
                                                  onTap: () {
                                                    if (orden != "cuenta_sap") {
                                                      orden = "cuenta_sap";
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
                                                      getPagosBy__();
                                                    } else {
                                                      getPagos();
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
                                                    style: parametroEsquema
                                                            .isNotEmpty
                                                        ? globalUtility
                                                            .encabezadoTablasOn(
                                                                context)
                                                        : globalUtility
                                                            .encabezadoTablasOff(
                                                                context),
                                                  ),
                                                  onTap: () {
                                                    if (filtroSimple == false) {
                                                      filtroAvanzado = false;
                                                      filtroSimple = true;
                                                    } else {
                                                      filtroSimple = false;
                                                      controllerProveedor
                                                          .clear();
                                                      parametroProveedor = "";
                                                      controllerCuentaSap
                                                          .clear();
                                                      parametroCuentaSap = "";
                                                      controllerEsquema.clear();
                                                      parametroEsquema = "";
                                                      controllerEstado.clear();
                                                      parametroEstado = "";
                                                    }
                                                    getPagos();
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
                                                      getPagosBy__();
                                                    } else {
                                                      getPagos();
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
                                                    "Estátus",
                                                    textAlign: TextAlign.center,
                                                    style: parametroEstado
                                                            .isNotEmpty
                                                        ? globalUtility
                                                            .encabezadoTablasOn(
                                                                context)
                                                        : globalUtility
                                                            .encabezadoTablasOff(
                                                                context),
                                                  ),
                                                  onTap: () {
                                                    if (filtroSimple == false) {
                                                      filtroAvanzado = false;
                                                      filtroSimple = true;
                                                    } else {
                                                      filtroSimple = false;
                                                      controllerProveedor
                                                          .clear();
                                                      parametroProveedor = "";
                                                      controllerCuentaSap
                                                          .clear();
                                                      parametroCuentaSap = "";
                                                      controllerEsquema.clear();
                                                      parametroEsquema = "";
                                                      controllerEstado.clear();
                                                      parametroEstado = "";
                                                    }
                                                    getPagos();
                                                    setState(() {});
                                                  },
                                                ),
                                                InkWell(
                                                  child: Icon(
                                                      orden == "estado"
                                                          ? asc == true
                                                              ? Icons
                                                                  .arrow_drop_down
                                                              : Icons
                                                                  .arrow_drop_up
                                                          : Icons
                                                              .arrow_drop_down,
                                                      color: orden == "estado"
                                                          ? globalUtility
                                                              .primaryBg
                                                          : globalUtility
                                                              .secondary),
                                                  onTap: () {
                                                    if (orden != "estado") {
                                                      orden = "estado";
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
                                                      getPagosBy__();
                                                    } else {
                                                      getPagos();
                                                    }
                                                  },
                                                ),
                                              ],
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
                                                              controllerProveedor,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                          onChanged: (value) {
                                                            parametroProveedor =
                                                                value
                                                                    .toString();
                                                            getPagosBy__();
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
                                                              controllerCuentaSap,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                          onChanged: (value) {
                                                            parametroCuentaSap =
                                                                value
                                                                    .toString();
                                                            getPagosBy__();
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
                                                              controllerEsquema,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                          onChanged: (value) {
                                                            parametroEsquema =
                                                                value
                                                                    .toString();
                                                            getPagosBy__();
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
                                                              controllerEstado,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                          onChanged: (value) {
                                                            parametroEstado =
                                                                value
                                                                    .toString();
                                                            getPagosBy__();
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
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
                                  itemCount: listPagos.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 10, 0, 0),
                                      child: ExpandablePanel(
                                        theme: ExpandableThemeData(
                                            iconColor: globalUtility.primary),
                                        header: Material(
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
                                                color:
                                                    globalUtility.transparente,
                                                width: 1,
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(5, 5, 5, 5),
                                              //row info
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: Center(
                                                      child: listPagos[index]
                                                                  [0] ==
                                                              null
                                                          ? Text(
                                                              '-',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: globalUtility
                                                                  .contenidoTablas(
                                                                      context),
                                                            )
                                                          : Text(
                                                              listPagos[index]
                                                                      [0]
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: globalUtility
                                                                  .contenidoTablas(
                                                                      context),
                                                            ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Center(
                                                      child: listPagos[index]
                                                                  [2] ==
                                                              null
                                                          ? Text(
                                                              '-',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: globalUtility
                                                                  .contenidoTablas(
                                                                      context),
                                                            )
                                                          : Text(
                                                              listPagos[index]
                                                                      [2]
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: globalUtility
                                                                  .contenidoTablas(
                                                                      context),
                                                            ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Center(
                                                      child: listPagos[index]
                                                                  [1] ==
                                                              null
                                                          ? Text(
                                                              '-',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: globalUtility
                                                                  .contenidoTablas(
                                                                      context),
                                                            )
                                                          : Text(
                                                              listPagos[index]
                                                                      [1]
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: globalUtility
                                                                  .contenidoTablas(
                                                                      context),
                                                            ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Center(
                                                      child: listPagos[index]
                                                                  [3] ==
                                                              null
                                                          ? Text(
                                                              '-',
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: globalUtility
                                                                  .contenidoTablas(
                                                                      context),
                                                            )
                                                          : Text(
                                                              listPagos[index]
                                                                      [3]
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: globalUtility
                                                                  .contenidoTablas(
                                                                      context),
                                                            ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        collapsed: const SizedBox(
                                          height: 0,
                                          width: 0,
                                        ),
                                        expanded: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              top: 10,
                                              right: 50,
                                              bottom: 10),
                                          child: Column(
                                            children: [
                                              Material(
                                                color:
                                                    globalUtility.transparente,
                                                elevation: 10,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(5),
                                                    bottomRight:
                                                        Radius.circular(5),
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                  ),
                                                ),
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      color: globalUtility
                                                          .primaryBg,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        bottomLeft:
                                                            Radius.circular(5),
                                                        bottomRight:
                                                            Radius.circular(5),
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                      ),
                                                      border: Border.all(
                                                          color: globalUtility
                                                              .primary)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            0, 5, 0, 5),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          //Titulos dentro de las tablas
                                                          children: [
                                                            Expanded(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    "No. Documento SAP",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: globalUtility
                                                                        .encabezadoTablasOffAlt(
                                                                            context),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    "Acreedor",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: globalUtility
                                                                        .encabezadoTablasOffAlt(
                                                                            context),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    "Proveedor",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: globalUtility
                                                                        .encabezadoTablasOffAlt(
                                                                            context),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    "Referencia",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: globalUtility
                                                                        .encabezadoTablasOffAlt(
                                                                            context),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    "Importe",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: globalUtility
                                                                        .encabezadoTablasOffAlt(
                                                                            context),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    "Moneda",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: globalUtility
                                                                        .encabezadoTablasOffAlt(
                                                                            context),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    "Estatus",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: globalUtility
                                                                        .encabezadoTablasOffAlt(
                                                                            context),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  //Contenedores dentro del padding
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            0, 10, 0, 0),
                                                    child: Material(
                                                      color: Colors.transparent,
                                                      elevation: 5,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Container(
                                                        width: double.infinity,
                                                        height: 55,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: globalUtility
                                                              .primaryBg,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                  5, 5, 5, 5),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Expanded(
                                                                child: Center(
                                                                  child: listPagos[index]
                                                                              [
                                                                              8] ==
                                                                          null
                                                                      ? Text(
                                                                          '-',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              globalUtility.contenidoTablas(context),
                                                                        )
                                                                      : Text(
                                                                          listPagos[index][8]
                                                                              .toString(),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              globalUtility.contenidoTablas(context),
                                                                        ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Center(
                                                                  child: listPagos[index]
                                                                              [
                                                                              4] ==
                                                                          null
                                                                      ? Text(
                                                                          '-',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              globalUtility.contenidoTablas(context),
                                                                        )
                                                                      : Text(
                                                                          listPagos[index][4]
                                                                              .toString(),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              globalUtility.contenidoTablas(context),
                                                                        ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Center(
                                                                  child: listPagos[index]
                                                                              [
                                                                              5] ==
                                                                          null
                                                                      ? Text(
                                                                          '-',
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style:
                                                                              globalUtility.contenidoTablas(context),
                                                                        )
                                                                      : Text(
                                                                          listPagos[index][5]
                                                                              .toString(),
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style:
                                                                              globalUtility.contenidoTablas(context),
                                                                        ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: listPagos[index]
                                                                            [
                                                                            7] ==
                                                                        null
                                                                    ? Text(
                                                                        '-',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: globalUtility
                                                                            .contenidoTablas(context),
                                                                      )
                                                                    : Text(
                                                                        listPagos[index][7]
                                                                            .toString(),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: globalUtility
                                                                            .contenidoTablas(context),
                                                                      ),
                                                              ),
                                                              Expanded(
                                                                child: Center(
                                                                  child: listPagos[index]
                                                                              [
                                                                              9] ==
                                                                          null
                                                                      ? Text(
                                                                          '-',
                                                                          textAlign:
                                                                              TextAlign.end,
                                                                          style:
                                                                              globalUtility.contenidoTablas(context),
                                                                        )
                                                                      : Text(
                                                                          '\$ ${moneyFormat(listPagos[index][9])}',
                                                                          textAlign:
                                                                              TextAlign.end,
                                                                          style:
                                                                              globalUtility.contenidoTablas(context),
                                                                        ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Center(
                                                                  child: listPagos[index]
                                                                              [
                                                                              1] ==
                                                                          null
                                                                      ? Text(
                                                                          '-',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              globalUtility.contenidoTablas(context),
                                                                        )
                                                                      : Text(
                                                                          listPagos[index][1]
                                                                              .toString(),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              globalUtility.contenidoTablas(context),
                                                                        ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                  child: Center(
                                                                child: listPagos[index]
                                                                            [
                                                                            3] ==
                                                                        null
                                                                    ? Text(
                                                                        '-',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style: globalUtility
                                                                            .contenidoTablas(context),
                                                                      )
                                                                    : Text(
                                                                        listPagos[index][3]
                                                                            .toString(),
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style: globalUtility
                                                                            .contenidoTablas(context),
                                                                      ),
                                                              )),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            0, 10, 0, 0),
                                                    child: Material(
                                                      color: Colors.transparent,
                                                      elevation: 5,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Container(
                                                        width: double.infinity,
                                                        height: 55,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: globalUtility
                                                              .primaryBg,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                  5, 5, 5, 5),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Expanded(
                                                                child: Center(
                                                                  child: listPagos[index]
                                                                              [
                                                                              12] ==
                                                                          null
                                                                      ? Text(
                                                                          '-',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              globalUtility.contenidoTablas(context),
                                                                        )
                                                                      : Text(
                                                                          listPagos[index][12]
                                                                              .toString(),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              globalUtility.contenidoTablas(context),
                                                                        ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Center(
                                                                  child: listPagos[index]
                                                                              [
                                                                              4] ==
                                                                          null
                                                                      ? Text(
                                                                          '-',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              globalUtility.contenidoTablas(context),
                                                                        )
                                                                      : Text(
                                                                          listPagos[index][4]
                                                                              .toString(),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              globalUtility.contenidoTablas(context),
                                                                        ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Center(
                                                                  child: listPagos[index]
                                                                              [
                                                                              5] ==
                                                                          null
                                                                      ? Text(
                                                                          '-',
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style:
                                                                              globalUtility.contenidoTablas(context),
                                                                        )
                                                                      : Text(
                                                                          listPagos[index][5]
                                                                              .toString(),
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style:
                                                                              globalUtility.contenidoTablas(context),
                                                                        ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: listPagos[index]
                                                                            [
                                                                            11] ==
                                                                        null
                                                                    ? Text(
                                                                        '-',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: globalUtility
                                                                            .contenidoTablas(context),
                                                                      )
                                                                    : Text(
                                                                        listPagos[index][11]
                                                                            .toString(),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: globalUtility
                                                                            .contenidoTablas(context),
                                                                      ),
                                                              ),
                                                              Expanded(
                                                                child: Center(
                                                                  child: listPagos[index]
                                                                              [
                                                                              14] ==
                                                                          null
                                                                      ? Text(
                                                                          '-',
                                                                          textAlign:
                                                                              TextAlign.end,
                                                                          style:
                                                                              globalUtility.contenidoTablas(context),
                                                                        )
                                                                      : Text(
                                                                          '\$ ${moneyFormat(listPagos[index][14])}',
                                                                          textAlign:
                                                                              TextAlign.end,
                                                                          style:
                                                                              globalUtility.contenidoTablas(context),
                                                                        ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Center(
                                                                  child: listPagos[index]
                                                                              [
                                                                              1] ==
                                                                          null
                                                                      ? Text(
                                                                          '-',
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style:
                                                                              globalUtility.contenidoTablas(context),
                                                                        )
                                                                      : Text(
                                                                          listPagos[index][1]
                                                                              .toString(),
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style:
                                                                              globalUtility.contenidoTablas(context),
                                                                        ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                  child: Center(
                                                                child: listPagos[index]
                                                                            [
                                                                            3] ==
                                                                        null
                                                                    ? Text(
                                                                        '-',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style: globalUtility
                                                                            .contenidoTablas(context),
                                                                      )
                                                                    : Text(
                                                                        listPagos[index][3]
                                                                            .toString(),
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style: globalUtility
                                                                            .contenidoTablas(context),
                                                                      ),
                                                              )),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            0, 10, 0, 0),
                                                    child: Material(
                                                      color: Colors.transparent,
                                                      elevation: 5,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Container(
                                                        width: double.infinity,
                                                        height: 55,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: globalUtility
                                                              .primaryBg,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                  5, 5, 5, 5),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Expanded(
                                                                child: Center(
                                                                  child: Text(
                                                                    '',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: globalUtility
                                                                        .contenidoTablas(
                                                                            context),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Center(
                                                                  child: Text(
                                                                    '',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: globalUtility
                                                                        .contenidoTablas(
                                                                            context),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    IconButton(
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .download),
                                                                  onPressed:
                                                                      () async {
                                                                    SupabaseQueries.actualizarEstatus(
                                                                        listPagos[index]
                                                                            [6],
                                                                        2);

                                                                    initState();
                                                                  },
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  'Total: ',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: globalUtility
                                                                      .contenidoTablas(
                                                                          context),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Center(
                                                                  child: listPagos[index]
                                                                              [
                                                                              15] ==
                                                                          null
                                                                      ? Text(
                                                                          '-',
                                                                          textAlign:
                                                                              TextAlign.end,
                                                                          style:
                                                                              globalUtility.contenidoTablas(context),
                                                                        )
                                                                      : Text(
                                                                          '\$ ${moneyFormat(listPagos[index][15])}',
                                                                          textAlign:
                                                                              TextAlign.end,
                                                                          style:
                                                                              globalUtility.contenidoTablas(context),
                                                                        ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Center(
                                                                  child: listPagos[index]
                                                                              [
                                                                              1] ==
                                                                          null
                                                                      ? Text(
                                                                          '-',
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style:
                                                                              globalUtility.contenidoTablas(context),
                                                                        )
                                                                      : Text(
                                                                          listPagos[index][1]
                                                                              .toString(),
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style:
                                                                              globalUtility.contenidoTablas(context),
                                                                        ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Center(
                                                                  child: listPagos[index]
                                                                              [
                                                                              3] ==
                                                                          null
                                                                      ? Text(
                                                                          '-',
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style:
                                                                              globalUtility.contenidoTablas(context),
                                                                        )
                                                                      : Text(
                                                                          listPagos[index][3]
                                                                              .toString(),
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style:
                                                                              globalUtility.contenidoTablas(context),
                                                                        ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
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
