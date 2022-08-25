import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

import 'package:arux/helpers/global_utility.dart';
import 'package:arux/helpers/globals.dart';
import 'package:arux/models/get_proveedores_qt.dart';
import 'package:arux/models/get_sociedades_by_id_proveedor.dart';
import 'package:arux/pages/widgets/side_menu/side_menu.dart';
import 'package:arux/pages/widgets/top_menu/top_menu.dart';

class Proveedores extends StatefulWidget {
  const Proveedores({Key? key}) : super(key: key);

  @override
  State<Proveedores> createState() => _ProveedoresState();
}

class _ProveedoresState extends State<Proveedores> {
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

  List<List<dynamic>> listProveedores = [];
  String orden = "proveedor";
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

  ///////////////////////////////////////////////////////////////////////////////////

  @override
  void initState() {
    getProveedores();
    super.initState();
  }

  Future<void> getProveedores() async {
    try {
      dynamic response = await supabase
          .rpc('get_proveedores', params: {'busqueda': parametroBusqueda})
          .order(orden, ascending: asc)
          .range(0, countF)
          .execute();

      //// print("-----Error: ${response.error}");

      response = jsonEncode(response);

      // // print("-----Parametro de Busqueda: $parametro_busqueda");
      /* // print("-----Response: ");
      // print(response.toString()); */

      GetProveedoresQt getProveedoresQTResponse =
          getProveedoresQtFromMap(response);

      listProveedores = [];

      for (var i = 0; i < getProveedoresQTResponse.data.length; i++) {
        List<dynamic> localList = [];
        List<dynamic> localList_2 = [];

        localList.add(getProveedoresQTResponse.data[i].idProveedor);
        localList.add(getProveedoresQTResponse.data[i].proveedor);
        localList.add(getProveedoresQTResponse.data[i].cuentaSap);
        localList.add(getProveedoresQTResponse.data[i].esquema);
        localList.add(getProveedoresQTResponse.data[i].estado);

        dynamic response = await supabase
            .rpc('get_sociedades_by_id_proveedor', params: {
              'busqueda': getProveedoresQTResponse.data[i].idProveedor
            })
            .order(orden_2, ascending: asc_2)
            .execute();

        //// print("-----Error: ${response.error}");

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

        listProveedores.add(localList);

        //// print("Indice $i : ${list_proveedores[i]}");
        //// print("Longitud $i : ${list_proveedores[i].length}");
        //// print("Proveedor $i : ${list_proveedores[i][1]}");
        //// print("Sociedades $i : ${list_proveedores[i][5]}");
        //// print("Sociedad 0 $i : ${list_proveedores[i][5][0]}");
        //// print("idSociedad $i : ${list_proveedores[i][5][0][0]}");
      }

      //// print("Listas : ${list_proveedores.length}");

    } catch (e) {
      // print(e);
    }

    setState(() {});
  }

  ///////////////////////////////////////////////////////////////////////////////////

  // ignore: non_constant_identifier_names
  Future<void> getProveedoresBy__() async {
    try {
      dynamic response = await supabase
          .rpc('get_proveedores_by__', params: {
            'proveedor': parametroProveedor,
            'cuenta_sap': parametroCuentaSap,
            'esquema': parametroEsquema,
            'estado': parametroEstado
          })
          .order(orden, ascending: asc)
          .range(0, countF)
          .execute();

      response = jsonEncode(response);

      GetProveedoresQt getProveedoresQTResponse =
          getProveedoresQtFromMap(response);

      listProveedores = [];

      for (var i = 0; i < getProveedoresQTResponse.data.length; i++) {
        List<dynamic> localList = [];
        List<dynamic> localList_2 = [];

        localList.add(getProveedoresQTResponse.data[i].idProveedor);
        localList.add(getProveedoresQTResponse.data[i].proveedor);
        localList.add(getProveedoresQTResponse.data[i].cuentaSap);
        localList.add(getProveedoresQTResponse.data[i].esquema);
        localList.add(getProveedoresQTResponse.data[i].estado);

        dynamic response = await supabase
            .rpc('get_sociedades_by_id_proveedor', params: {
              'busqueda': getProveedoresQTResponse.data[i].idProveedor
            })
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

        listProveedores.add(localList);

        //// print("Indice $i : ${list_proveedores[i]}");
        //// print("Longitud $i : ${list_proveedores[i].length}");
        //// print("Proveedor $i : ${list_proveedores[i][1]}");
        //// print("Sociedades $i : ${list_proveedores[i][5]}");
        //// print("Sociedad 0 $i : ${list_proveedores[i][5][0]}");
        //// print("idSociedad $i : ${list_proveedores[i][5][0][0]}");
      }

      //// print("Listas : ${list_proveedores.length}");

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
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
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
                                      'Proveedores',
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
                                                                //etPartidasDif();
                                                                break;
                                                            }
                                                          } else {
                                                            getProveedores();
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
                                                            getProveedores();
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
                                                              getProveedores();
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
                                                                    getProveedores();
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
                                                    "Proveedor",
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
                                                    if (filtroSimple ==
                                                        false) {
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
                                                      controllerEsquema
                                                          .clear();
                                                      parametroEsquema = "";
                                                      controllerEstado.clear();
                                                      parametroEstado = "";
                                                    }
                                                    getProveedores();
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
                                                          // GetPartidasDif();
                                                          break;
                                                      }
                                                    } else if (filtroSimple) {
                                                      getProveedoresBy__();
                                                    } else {
                                                      getProveedores();
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
                                                    "Código\nAcreedor",
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
                                                    if (filtroSimple ==
                                                        false) {
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
                                                      controllerEsquema
                                                          .clear();
                                                      parametroEsquema = "";
                                                      controllerEstado.clear();
                                                      parametroEstado = "";
                                                    }
                                                    getProveedores();
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
                                                      getProveedoresBy__();
                                                    } else {
                                                      getProveedores();
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
                                                    if (filtroSimple ==
                                                        false) {
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
                                                      controllerEsquema
                                                          .clear();
                                                      parametroEsquema = "";
                                                      controllerEstado.clear();
                                                      parametroEstado = "";
                                                    }
                                                    getProveedores();
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
                                                          // GetPartidasMenor();
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
                                                      getProveedoresBy__();
                                                    } else {
                                                      getProveedores();
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
                                                    "Estado",
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
                                                    if (filtroSimple ==
                                                        false) {
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
                                                      controllerEsquema
                                                          .clear();
                                                      parametroEsquema = "";
                                                      controllerEstado.clear();
                                                      parametroEstado = "";
                                                    }
                                                    getProveedores();
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
                                                      getProveedoresBy__();
                                                    } else {
                                                      getProveedores();
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                "Acciones",
                                                textAlign: TextAlign.center,
                                                style: globalUtility
                                                    .encabezadoTablasOff(
                                                        context),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                "Bloqueo\n Temporal",
                                                textAlign: TextAlign.center,
                                                style: globalUtility
                                                    .encabezadoTablasOff(
                                                        context),
                                              ),
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
                                                            getProveedoresBy__();
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
                                                            getProveedoresBy__();
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
                                                            getProveedoresBy__();
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
                                                            getProveedoresBy__();
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const Expanded(
                                                    child: SizedBox()),
                                                const Expanded(
                                                    child: SizedBox()),
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
                                  itemCount: listProveedores.length,
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
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      listProveedores[index][1]
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: globalUtility
                                                          .contenidoTablas(
                                                              context),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Center(
                                                      child: Text(
                                                        listProveedores[index]
                                                                [2]
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: globalUtility
                                                            .contenidoTablas(
                                                                context),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Center(
                                                      child: Text(
                                                        listProveedores[index]
                                                                [3]
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: globalUtility
                                                            .contenidoTablas(
                                                                context),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Center(
                                                      child: Text(
                                                        listProveedores[index]
                                                                [4]
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: globalUtility
                                                            .contenidoTablas(
                                                                context),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Icon(
                                                      Icons.edit_outlined,
                                                      color: globalUtility
                                                          .secondary,
                                                      size: 30,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Icon(
                                                      Icons.toggle_off_outlined,
                                                      color: globalUtility
                                                          .secondary,
                                                      size: 30,
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
                                                          children: [
                                                            Expanded(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    "Sociedad",
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
                                                                    "Cuenta",
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
                                                                    "Nombre",
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
                                                                    "Telefono",
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
                                                              child: Center(
                                                                child: Text(
                                                                  "Contacto",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: globalUtility
                                                                      .encabezadoTablasOffAlt(
                                                                          context),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Center(
                                                                child: Text(
                                                                  "Con. Pago",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: globalUtility
                                                                      .encabezadoTablasOffAlt(
                                                                          context),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Center(
                                                                child: Text(
                                                                  "Tipo",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: globalUtility
                                                                      .encabezadoTablasOffAlt(
                                                                          context),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              ListView.builder(
                                                padding: EdgeInsets.zero,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount:
                                                    listProveedores[index][5]
                                                        .length,
                                                itemBuilder: (context, index2) {
                                                  return Padding(
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
                                                                    listProveedores[index][5]
                                                                            [
                                                                            index2][1]
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
                                                              Expanded(
                                                                child: Center(
                                                                  child: Text(
                                                                    listProveedores[index][5]
                                                                            [
                                                                            index2][2]
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
                                                              Expanded(
                                                                child: Text(
                                                                  listProveedores[index]
                                                                              [
                                                                              5]
                                                                          [
                                                                          index2][3]
                                                                      .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style: globalUtility
                                                                      .contenidoTablas(
                                                                          context),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  listProveedores[index]
                                                                              [
                                                                              5]
                                                                          [
                                                                          index2][4]
                                                                      .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: globalUtility
                                                                      .contenidoTablas(
                                                                          context),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  listProveedores[index]
                                                                              [
                                                                              5]
                                                                          [
                                                                          index2][5]
                                                                      .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style: globalUtility
                                                                      .contenidoTablas(
                                                                          context),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Center(
                                                                  child: Text(
                                                                    listProveedores[index][5]
                                                                            [
                                                                            index2][6]
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
                                                              Expanded(
                                                                child: Center(
                                                                  child: Text(
                                                                    listProveedores[index][5]
                                                                            [
                                                                            index2][7]
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
                                                  );
                                                },
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
