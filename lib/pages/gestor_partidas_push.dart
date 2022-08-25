import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:http/http.dart';

import 'package:data_table_2/data_table_2.dart';
import 'package:arux/helpers/constants.dart';
import 'package:arux/functions/money_format.dart';
import 'package:arux/helpers/global_utility.dart';
import 'package:arux/helpers/globals.dart';
import 'package:arux/models/get_gestor_partidas_qt.dart';
import 'package:arux/pages/widgets/side_menu/side_menu.dart';
import 'package:arux/pages/widgets/top_menu/top_menu.dart';

class GestorPartidasPush extends StatefulWidget {
  const GestorPartidasPush({Key? key}) : super(key: key);

  @override
  State<GestorPartidasPush> createState() => _GestorPartidasPushState();
}

class _GestorPartidasPushState extends State<GestorPartidasPush> {
  GlobalUtility globalUtility = GlobalUtility();

  final controllerBusqueda = TextEditingController();
  String parametroBusqueda = "";

  final controllerIdPartida = TextEditingController();
  String parametroIdPartida = "";
  final controllerProveedor = TextEditingController();
  String parametroProveedor = "";
  final controllerReferencia = TextEditingController();
  String parametroReferencia = "";
  final controllerImporte = TextEditingController();
  String parametroImporte = "";
  final controllerMoneda = TextEditingController();
  String parametroMoneda = "";
  bool filtroSimple = false;

  List<List<dynamic>> listPartidas = [];

  String orden = "id_partidas_pk";
  bool asc = true;
  int countI = 0;
  int countF = 5;

  List<String?> monedas = ["USD", "UYU"];
  String monedaSelec = "USD";

  bool popupRise = false;
  List<String?> listDDEnc = [
    "Registro SAP",
    "Proveedor",
    "Referencia",
    "Importe Factura",
    "Moneda",
    "Dias para aplicar pago",
    "%DPP",
    "\$DPP",
    "\$ Pronto Pago"
  ];
  List<String?> listDDOpe = ["=", ">", ">=", "<", "<=", "!="];
  List<String?> listDDCond = ["Y", "Ó"];

  List<String> selectedEnc = ["Registro SAP"];
  List<String> selectedOpe = ["="];
  List<String> selectedVal = [""];
  List<String> selectedCond = [];
  bool filtroAvanzado = false;
  String query = "";

  final controllerFondoDisp = TextEditingController();
  double fondoDisponible = 0;
  late int fondoRestante;
  List<dynamic> listCarrito = [];
  double sumaImporte = 0;
  double sumaPp = 0;
  double sumaDpp = 0;
  bool fondoInsuficientePopup = false;

  ///////////////////////////////////////////////////////////////////////////////////

  @override
  void initState() {
    getPartidasPush();
    super.initState();
  }

  Future<void> getPartidasPush() async {
    try {
      dynamic response = await supabase
          .rpc('get_gestor_partidas', params: {'busqueda': parametroBusqueda})
          .order(orden, ascending: asc)
          .execute();

      //// print("-----Error: ${response.error}");

      response = jsonEncode(response);

      /* // print("-----Parametro de Busqueda: $parametro_busqueda");
      // print("-----Response: ");
      // print(response.toString()); */

      GetGestorPartidasQt getGestorPartidasQtResponse =
          getGestorPartidasQtFromMap(response);

      listPartidas = [];

      for (var i = 0; i < getGestorPartidasQtResponse.data.length; i++) {
        List<dynamic> localList = [];

        localList.add(false);
        localList.add(getGestorPartidasQtResponse.data[i].idPartidasPk);
        localList.add(getGestorPartidasQtResponse.data[i].proveedor);
        localList.add(getGestorPartidasQtResponse.data[i].referencia);
        localList.add(double.parse(
            getGestorPartidasQtResponse.data[i].importe.toStringAsFixed(2)));
        localList.add(getGestorPartidasQtResponse.data[i].moneda);
        localList.add(getGestorPartidasQtResponse.data[i].importeUsd);
        localList.add(getGestorPartidasQtResponse.data[i].diasPago);
        localList.add(getGestorPartidasQtResponse.data[i].porcDpp);
        localList.add(double.parse(
            getGestorPartidasQtResponse.data[i].cantDpp.toStringAsFixed(2)));
        localList.add(double.parse(
            getGestorPartidasQtResponse.data[i].prontoPago.toStringAsFixed(2)));
        listPartidas.add(localList);

        //// print("Indice $i : ${list_partidas[i]}");
        //// print("Indice $i : ${list_partidas[i][1]}");
        //// print("Indice $i : ${list_partidas[i].length}");
      }

      //// print("Listas : ${list_partidas.length}");

    } catch (e) {
      // print(e);
    }
    setState(() {});
  }

  ///////////////////////////////////////////////////////////////////////////////////

  Future<void> getPartidasPushByFiltroSim() async {
    try {
      dynamic response = await supabase
          .rpc('get_gestor_partidas_push_by__', params: {
            'idpartida': parametroIdPartida,
            'proveedor': parametroProveedor,
            'referencia': parametroReferencia,
            'importe': parametroImporte,
            'moneda': parametroMoneda
          })
          .order(orden, ascending: asc)
          .execute();

      // print("-----Error: ${response.error}");

      response = jsonEncode(response);

      // // print("-----Parametro de Busqueda: $parametro_busqueda");
      /* // print("-----Response: ");
      // print(response.toString()); */

      GetGestorPartidasQt getGestorPartidasQtResponse =
          getGestorPartidasQtFromMap(response);

      listPartidas = [];

      for (var i = 0; i < getGestorPartidasQtResponse.data.length; i++) {
        List<dynamic> localList = [];

        localList.add(false);
        localList.add(getGestorPartidasQtResponse.data[i].idPartidasPk);
        localList.add(getGestorPartidasQtResponse.data[i].proveedor);
        localList.add(getGestorPartidasQtResponse.data[i].referencia);
        localList.add(getGestorPartidasQtResponse.data[i].importe);
        localList.add(getGestorPartidasQtResponse.data[i].moneda);
        localList.add("\$ ${getGestorPartidasQtResponse.data[i].importeUsd}");
        localList.add(getGestorPartidasQtResponse.data[i].diasPago);
        localList.add("${getGestorPartidasQtResponse.data[i].porcDpp} %");
        localList.add("\$ ${getGestorPartidasQtResponse.data[i].cantDpp}");
        localList.add("\$ ${getGestorPartidasQtResponse.data[i].prontoPago}");

        listPartidas.add(localList);

        //// print("Indice $i : ${list_partidas[i]}");
        //// print("Indice $i : ${list_partidas[i][1]}");
        //// print("Indice $i : ${list_partidas[i].length}");
      }

      //// print("Listas : ${list_partidas.length}");

    } catch (e) {
      // print(e);
    }

    setState(() {});
  }

  ///////////////////////////////////////////////////////////////////////////////////

  // ignore: non_constant_identifier_names
  Future<void> getPartidasPushBy__FiltroAva() async {
    try {
      query = "";

      for (var i = 0; i < selectedVal.length; i++) {
        String localEnc = "";
        String localVal = "";
        String localCond = "";
        switch (selectedEnc[i]) {
          case "Registro SAP":
            localEnc = "id_partidas_pk";
            localVal = selectedVal[i];
            break;
          case "Proveedor":
            localEnc = "proveedores.sociedad";
            localVal = "'${selectedVal[i]}'";
            break;
          case "Referencia":
            localEnc = "partidas_sap.no_doc_partida";
            localVal = "'${selectedVal[i]}'";
            break;
          case "Importe Factura":
            localEnc = "partidas_sap.importe_ml";
            localVal = selectedVal[i];
            break;
          case "Moneda":
            localEnc = "partidas_sap.ml";
            localVal = "'${selectedVal[i]}'";
            break;
          case "Dias para aplicar pago":
            localEnc = "partidas_sap.dias_pago";
            localVal = selectedVal[i];
            break;
          case "%DPP":
            localEnc = "partidas_sap.descuento_porc_pp";
            localVal = selectedVal[i];
            break;
          case "\$DPP":
            localEnc = "partidas_sap.descuento_cant_pp";
            localVal = selectedVal[i];
            break;
          case "\$ Pronto Pago":
            localEnc = "partidas_sap.pronto_pago";
            localVal = selectedVal[i];
            break;
        }
        if (i == selectedVal.length - 1) {
          query = ("$query $localEnc ${selectedOpe[i]} $localVal").toString();
        } else {
          query =
              ("$query $localEnc ${selectedOpe[i]} $localVal AND").toString();
        }
      }
      //// print("----Query: $query");
      dynamic response = await supabase
          .rpc('get_partidas_by_filtrado', params: {
            'query': queryPartidas + query,
          })
          .order(orden, ascending: asc)
          .execute();

      // print("-----Error: ${response.error}");

      response = jsonEncode(response);

      /* // print("-----Response: ");
      // print(response.toString()); */

      GetGestorPartidasQt getGestorPartidasQtResponse =
          getGestorPartidasQtFromMap(response);

      listPartidas = [];

      for (var i = 0; i < getGestorPartidasQtResponse.data.length; i++) {
        List<dynamic> localList = [];

        localList.add(false);
        localList.add(getGestorPartidasQtResponse.data[i].idPartidasPk);
        localList.add(getGestorPartidasQtResponse.data[i].proveedor);
        localList.add(getGestorPartidasQtResponse.data[i].referencia);
        localList.add(double.parse(
            getGestorPartidasQtResponse.data[i].importe.toStringAsFixed(2)));
        localList.add(getGestorPartidasQtResponse.data[i].moneda);
        localList.add(getGestorPartidasQtResponse.data[i].importeUsd);
        localList.add(getGestorPartidasQtResponse.data[i].diasPago);
        localList.add(getGestorPartidasQtResponse.data[i].porcDpp);
        localList.add(double.parse(
            getGestorPartidasQtResponse.data[i].cantDpp.toStringAsFixed(2)));
        localList.add(double.parse(
            getGestorPartidasQtResponse.data[i].prontoPago.toStringAsFixed(2)));
        listPartidas.add(localList);

        //// print("Indice $i : ${list_partidas[i]}");
        //// print("Indice $i : ${list_partidas[i][1]}");
        //// print("Indice $i : ${list_partidas[i].length}");
      }

      //// print(list_partidas);

      //// print("Listas : ${list_partidas.length}");

    } catch (e) {
      // print(e);
    }
    setState(() {});
  }

  ///////////////////////////////////////////////////////////////////////////////////

  Future<void> updatePartidasSolicitadas() async {
    try {
      for (var i = 0; i < listCarrito.length; i++) {
        dynamic response = await supabase.from('partidas_sap').update({
          'id_estatus_fk': 5,
          'fecha_base': DateTime.now().toString()
        }).match({'id_partidas_pk': '${listCarrito[i][0]}'}).execute();

        // print("-----Error: ${response.error}");
        /* // print("-----Response: ${response.toString()}");
        // print('Update realizado'); */

      }
      var postresponse = await post(
          Uri.parse('https://arux.cbluna-dev.com/arux/api'),
          body: json.encode({"action": "Ejecutar_Partidas"}));

      /* // print("-----PostResponseCode: " + postresponse.statusCode.toString());
      // print("-----PostResponseBody: " + postresponse.body); */

      const snackbarComplete = SnackBar(
        content: Text('Proceso Realizado con exito'),
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackbarComplete);
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(
        context,
        '/gestor-partidas-push',
      );
    } catch (e) {
      // print(e);
    }
  }

  ///////////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Column(
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
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 0, 20, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 30, 0),
                                        child: Icon(
                                          Icons.arrow_back_outlined,
                                          color: globalUtility.primary,
                                          size: 30,
                                        ),
                                      ),
                                      Text(
                                        'Gestor de Facturas Pull NC - Pago',
                                        style:
                                            globalUtility.tituloPagina(context),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 25, 0),
                                        child: InkWell(
                                          child: Tooltip(
                                            message: "Aplicar",
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
                                                  Icons.play_arrow_outlined,
                                                  color: globalUtility.primary,
                                                  size: 28,
                                                ),
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            if (listCarrito.isNotEmpty &&
                                                (fondoDisponible - sumaPp) >=
                                                    0) {
                                              updatePartidasSolicitadas();
                                            } else if (listCarrito.isEmpty) {
                                              const snackbarVacio = SnackBar(
                                                content: Text(
                                                    'Debe de seleccion por lo menos una partida para realizar este proceso'),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackbarVacio);
                                            } else if ((fondoDisponible -
                                                    sumaPp) <
                                                0) {
                                              fondoInsuficientePopup = false;
                                              setState(() {});
                                              /* const snackbarNegativo =
                                                  SnackBar(
                                                content: Text(
                                                    'El fondo disponible restante no debe ser menor a 0'),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                      snackbarNegativo); */
                                            }
                                          },
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
                                                        hintStyle: globalUtility
                                                            .hinttxt(context),
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
                                                        } else {
                                                          getPartidasPush();
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
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 15, 0),
                                        child: Container(
                                          width: 150,
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
                                                            getPartidasPush();
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
                                                              getPartidasPush();
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
                                                          width: 50,
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
                                                                  /* // print(
                                                                      "---Valor: ${value.toString()}"); */
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
                                                                    getPartidasPush();
                                                                    setState(
                                                                        () {});
                                                                  }
                                                                } catch (e) {
                                                                  /* // print("---Error: $e"); */
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
                                      ),
                                      Container(
                                        width: 150,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: globalUtility.primaryBg,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          border: Border.all(
                                            color: globalUtility.primary,
                                            width: 1.5,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: InkWell(
                                            child: Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                    "Filtrar",
                                                    style: globalUtility
                                                        .encabezadoTablasOffAlt(
                                                            context),
                                                  ),
                                                  Icon(
                                                      Icons.filter_alt_outlined,
                                                      color:
                                                          globalUtility.primary)
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              popupRise = true;
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ),
                                      /*  Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 0, 5, 0),
                                                child: IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(Icons.arrow_back,
                                                      color: globalUtility
                                                          .primary),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 0, 5, 0),
                                                child: IconButton(
                                                  onPressed: () {
                                                    if (count_i < 5) {
                                                      count_i = 0;
                                                      count_f = 5;
                                                    } else {
                                                      count_i = count_i - 5;
                                                      count_f = count_f - 5;
                                                    }
                                                    setState(() {});
                                                  },
                                                  icon: Icon(
                                                      Icons.arrow_back_ios,
                                                      color: globalUtility
                                                          .primary),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 0, 5, 0),
                                                child: Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        globalUtility.primary,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: globalUtility
                                                          .primary,
                                                      width: 2,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text('1',
                                                          style: globalUtility
                                                              .encabezadoTablasOffAlt(
                                                                  context)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 0, 5, 0),
                                                child: Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: globalUtility
                                                          .primary,
                                                      width: 2,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text('1',
                                                          style: globalUtility
                                                              .encabezadoTablasOffAlt(
                                                                  context)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 0, 5, 0),
                                                child: Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: globalUtility
                                                          .primary,
                                                      width: 2,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text('1',
                                                          style: globalUtility
                                                              .encabezadoTablasOffAlt(
                                                                  context)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Text('...',
                                                  style: globalUtility
                                                      .encabezadoTablasOffAlt(
                                                          context)),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(5, 0, 5, 0),
                                                child: Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: globalUtility
                                                          .primary,
                                                      width: 2,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text('1',
                                                          style: globalUtility
                                                              .encabezadoTablasOffAlt(
                                                                  context)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(5, 0, 0, 0),
                                                child: IconButton(
                                                    onPressed: () {
                                                      count_i = count_i + 5;
                                                      count_f = count_f + 5;
                                                      setState(() {});
                                                    },
                                                    icon: Icon(
                                                        Icons
                                                            .arrow_forward_ios,
                                                        color: globalUtility
                                                            .primary)),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(5, 0, 0, 0),
                                                child: IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                        Icons.arrow_forward,
                                                        color: globalUtility
                                                            .primary)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                     */
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 20, 0, 20),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 20, 0),
                                      child: Container(
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: globalUtility.primary,
                                            width: 1.5,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(10, 0, 20, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            0, 0, 10, 0),
                                                    child: Text(
                                                        'Fondo Disponible ',
                                                        style: globalUtility
                                                            .label(context)),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            0, 0, 15, 0),
                                                    child: Container(
                                                      width: 220,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        border: Border.all(
                                                          color: globalUtility
                                                              .primary,
                                                          width: 1.5,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20),
                                                          child: SizedBox(
                                                            width: 170,
                                                            height: 50,
                                                            child: TextField(
                                                              controller:
                                                                  controllerFondoDisp,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintStyle:
                                                                    globalUtility
                                                                        .hinttxt(
                                                                            context),
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hintText:
                                                                    "Ingrese una cantidad",
                                                              ),
                                                              onChanged:
                                                                  (value) {
                                                                fondoDisponible =
                                                                    double.parse(
                                                                        value);
                                                                setState(() {});
                                                              },
                                                            ),
                                                          )),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 100,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      border: Border.all(
                                                        color: globalUtility
                                                            .primary,
                                                        width: 1.5,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 20),
                                                      child:
                                                          DropdownButtonHideUnderline(
                                                        child: DropdownButton<
                                                            String>(
                                                          isExpanded: true,
                                                          value: monedas[0],
                                                          items: <String>[
                                                            "USD",
                                                            //"UYU",
                                                          ]
                                                              .map((item) =>
                                                                  DropdownMenuItem<
                                                                      String>(
                                                                    value: item,
                                                                    child: Text(
                                                                        item),
                                                                  ))
                                                              .toList(),
                                                          onChanged: (item) {
                                                            monedaSelec =
                                                                item.toString();
                                                            setState(() =>
                                                                monedas[0] =
                                                                    item);
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            30, 0, 0, 0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                            'FONDO DISPONIBLE RESTANTE',
                                                            style: globalUtility
                                                                .textoIgual2(
                                                                    context)),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                  0, 10, 0, 0),
                                                          child: Text(
                                                            '\$ ${moneyFormat(fondoDisponible - sumaPp)}',
                                                            style: (fondoDisponible -
                                                                        sumaPp) <
                                                                    0
                                                                ? globalUtility
                                                                    .textoError2(
                                                                        context)
                                                                : globalUtility
                                                                    .textoA2(
                                                                        context),
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
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              10, 0, 0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: globalUtility.primary,
                                                width: 1.5,
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(20, 0, 20, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            10, 0, 10, 0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                  0, 0, 50, 0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                  'TOTAL A PAGAR',
                                                                  style: globalUtility
                                                                      .textoIgual2(
                                                                          context)),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                        0,
                                                                        10,
                                                                        0,
                                                                        0),
                                                                child: Text(
                                                                  '\$ ${moneyFormat(sumaImporte - sumaDpp)}',
                                                                  style: globalUtility
                                                                      .textoA(
                                                                          context),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsetsDirectional
                                                                              .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          10,
                                                                          0),
                                                                  child: Text(
                                                                      'Selección de pagos:',
                                                                      style: globalUtility
                                                                          .label(
                                                                              context)),
                                                                ),
                                                                Text(
                                                                  '\$ ${moneyFormat(sumaImporte)}',
                                                                  style: globalUtility
                                                                      .textoA(
                                                                          context),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsetsDirectional
                                                                              .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          10,
                                                                          0),
                                                                  child: Text(
                                                                      ' Beneficio  DPP  . . .  :',
                                                                      style: globalUtility
                                                                          .label(
                                                                              context)),
                                                                ),
                                                                Text(
                                                                  '\$ ${moneyFormat(sumaDpp)}',
                                                                  style: globalUtility
                                                                      .textoA(
                                                                          context),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
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
                                    ),
                                  ],
                                ),
                              ),
                              listPartidas.isEmpty
                                  ? const CircularProgressIndicator()
                                  : Flexible(
                                      child: DataTable2(
                                        showCheckboxColumn: true,
                                        columnSpacing: 20,
                                        horizontalMargin: 10,
                                        minWidth: 100,
                                        onSelectAll: (value) {
                                          final isCheck =
                                              value != null && value;
                                          List<dynamic> tempList = [];
                                          if (isCheck) {
                                            for (var i = countI;
                                                i < listPartidas.length;
                                                i++) {
                                              listPartidas[i][0] = true;
                                              tempList.add(listPartidas[i][1]);
                                              tempList.add(listPartidas[i][2]);
                                              tempList.add(listPartidas[i][3]);
                                              tempList.add(listPartidas[i][4]);
                                              tempList.add(listPartidas[i][5]);
                                              tempList.add(listPartidas[i][6]);
                                              tempList.add(listPartidas[i][7]);
                                              tempList.add(listPartidas[i][8]);
                                              tempList.add(listPartidas[i][9]);
                                              tempList.add(listPartidas[i][10]);
                                              listCarrito.removeWhere((item) {
                                                return item[1].toString() ==
                                                        tempList[1]
                                                            .toString() &&
                                                    item[2].toString() ==
                                                        tempList[2].toString();
                                              });
                                              listCarrito.add(tempList);
                                              tempList = [];
                                            }
                                          } else {
                                            for (var i = countI;
                                                i < listPartidas.length;
                                                i++) {
                                              listPartidas[i][0] = false;
                                              listCarrito.removeWhere((item) {
                                                return item[0].toString() ==
                                                    listPartidas[i][1]
                                                        .toString();
                                              });
                                            }
                                            tempList.clear();
                                          }
                                          if (listCarrito.isNotEmpty) {
                                            sumaImporte = 0;
                                            sumaDpp = 0;
                                            sumaPp = 0;
                                            for (var i = 0;
                                                i < listCarrito.length;
                                                i++) {
                                              sumaImporte = sumaImporte +
                                                  listCarrito[i][5];
                                              sumaDpp =
                                                  sumaDpp + listCarrito[i][8];
                                              sumaPp =
                                                  sumaPp + listCarrito[i][9];
                                            }
                                          } else {
                                            sumaImporte = 0;
                                            sumaDpp = 0;
                                            sumaPp = 0;
                                          }
                                          setState(() {});
                                        },
                                        columns: [
                                          DataColumn2(
                                            size: ColumnSize.M,
                                            label: Text(
                                              'Registro SAP',
                                              textAlign: TextAlign.center,
                                              style: globalUtility
                                                  .encabezadoTablasOffAlt(
                                                      context),
                                            ),
                                          ),
                                          DataColumn2(
                                            size: ColumnSize.L,
                                            label: Text(
                                              'Proveedor',
                                              textAlign: TextAlign.center,
                                              style: globalUtility
                                                  .encabezadoTablasOffAlt(
                                                      context),
                                            ),
                                          ),
                                          DataColumn2(
                                            numeric: true,
                                            size: ColumnSize.M,
                                            label: Center(
                                              child: Text(
                                                'Referencia',
                                                style: globalUtility
                                                    .encabezadoTablasOffAlt(
                                                        context),
                                              ),
                                            ),
                                          ),
                                          DataColumn2(
                                            numeric: true,
                                            size: ColumnSize.M,
                                            label: Text(
                                              'Importe\nFactura',
                                              textAlign: TextAlign.center,
                                              style: globalUtility
                                                  .encabezadoTablasOffAlt(
                                                      context),
                                            ),
                                          ),
                                          DataColumn2(
                                            size: ColumnSize.S,
                                            label: Center(
                                              child: Text(
                                                'Moneda',
                                                style: globalUtility
                                                    .encabezadoTablasOffAlt(
                                                        context),
                                              ),
                                            ),
                                          ),
                                          DataColumn2(
                                            size: ColumnSize.M,
                                            numeric: true,
                                            label: Text(
                                              '\$ Importe\n$monedaSelec',
                                              textAlign: TextAlign.center,
                                              style: globalUtility
                                                  .encabezadoTablasOffAlt(
                                                      context),
                                            ),
                                          ),
                                          DataColumn2(
                                            size: ColumnSize.M,
                                            label: Text(
                                              'Días para\n Aplicar Pago',
                                              textAlign: TextAlign.center,
                                              style: globalUtility
                                                  .encabezadoTablasOffAlt(
                                                      context),
                                            ),
                                            numeric: true,
                                          ),
                                          DataColumn2(
                                            size: ColumnSize.S,
                                            numeric: true,
                                            label: Text(
                                              '%DPP',
                                              textAlign: TextAlign.center,
                                              style: globalUtility
                                                  .encabezadoTablasOffAlt(
                                                      context),
                                            ),
                                          ),
                                          DataColumn2(
                                            size: ColumnSize.M,
                                            numeric: true,
                                            label: Text(
                                              '\$DPP',
                                              textAlign: TextAlign.center,
                                              style: globalUtility
                                                  .encabezadoTablasOffAlt(
                                                      context),
                                            ),
                                          ),
                                          DataColumn2(
                                            size: ColumnSize.M,
                                            numeric: true,
                                            label: Text(
                                              '\$ Pronto\nPago',
                                              textAlign: TextAlign.center,
                                              style: globalUtility
                                                  .encabezadoTablasOffAlt(
                                                      context),
                                            ),
                                          ),
                                        ],
                                        rows: List<DataRow>.generate(
                                          listPartidas.length,
                                          (index) => DataRow(
                                            selected:
                                                listPartidas[index + countI][0],
                                            onSelectChanged: (value) =>
                                                setState(
                                              () {
                                                final isCheck =
                                                    value != null && value;
                                                final List<dynamic> tempList =
                                                    [];

                                                if (isCheck) {
                                                  listPartidas[index + countI]
                                                      [0] = true;
                                                  tempList.add(listPartidas[
                                                      index + countI][1]);
                                                  tempList.add(listPartidas[
                                                      index + countI][2]);
                                                  tempList.add(listPartidas[
                                                      index + countI][3]);
                                                  tempList.add(listPartidas[
                                                      index + countI][4]);
                                                  tempList.add(listPartidas[
                                                      index + countI][5]);
                                                  tempList.add(listPartidas[
                                                      index + countI][6]);
                                                  tempList.add(listPartidas[
                                                      index + countI][7]);
                                                  tempList.add(listPartidas[
                                                      index + countI][8]);
                                                  tempList.add(listPartidas[
                                                      index + countI][9]);
                                                  tempList.add(listPartidas[
                                                      index + countI][10]);
                                                  listCarrito.add(tempList);
                                                } else {
                                                  listPartidas[index + countI]
                                                      [0] = false;
                                                  tempList.add(listPartidas[
                                                      index + countI][1]);
                                                  tempList.add(listPartidas[
                                                      index + countI][2]);
                                                  tempList.add(listPartidas[
                                                      index + countI][3]);
                                                  tempList.add(listPartidas[
                                                      index + countI][4]);
                                                  tempList.add(listPartidas[
                                                      index + countI][5]);
                                                  tempList.add(listPartidas[
                                                      index + countI][6]);
                                                  tempList.add(listPartidas[
                                                      index + countI][7]);
                                                  tempList.add(listPartidas[
                                                      index + countI][8]);
                                                  tempList.add(listPartidas[
                                                      index + countI][9]);
                                                  tempList.add(listPartidas[
                                                      index + countI][10]);
                                                  listCarrito
                                                      .removeWhere((item) {
                                                    return item[1].toString() ==
                                                            tempList[1]
                                                                .toString() &&
                                                        item[2].toString() ==
                                                            tempList[2]
                                                                .toString();
                                                  });
                                                }
                                                sumaImporte = 0;
                                                sumaDpp = 0;
                                                sumaPp = 0;
                                                for (var i = 0;
                                                    i < listCarrito.length;
                                                    i++) {
                                                  sumaImporte = sumaImporte +
                                                      listCarrito[i][5];
                                                  sumaDpp = sumaDpp +
                                                      listCarrito[i][8];
                                                  sumaPp = sumaPp +
                                                      listCarrito[i][9];
                                                }
                                              },
                                            ),
                                            cells: [
                                              DataCell(
                                                Text(
                                                  listPartidas[index + countI]
                                                          [1]
                                                      .toString(),
                                                  style: globalUtility
                                                      .contenidoTablas(context),
                                                ),
                                              ),
                                              DataCell(
                                                Text(
                                                  listPartidas[index + countI]
                                                          [2]
                                                      .toString(),
                                                  style: globalUtility
                                                      .contenidoTablas(context),
                                                ),
                                              ),
                                              DataCell(
                                                Center(
                                                  child: Text(
                                                    listPartidas[index + countI]
                                                            [3]
                                                        .toString(),
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                Text(
                                                  '\$ ${moneyFormat(listPartidas[index + countI][4])}',
                                                  style: globalUtility
                                                      .contenidoTablas(context),
                                                ),
                                              ),
                                              DataCell(
                                                Center(
                                                  child: Text(
                                                    listPartidas[index + countI]
                                                            [5]
                                                        .toString(),
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                Text(
                                                  '\$ ${moneyFormat(listPartidas[index + countI][6])}',
                                                  style: globalUtility
                                                      .contenidoTablas(context),
                                                ),
                                              ),
                                              DataCell(
                                                Text(
                                                  listPartidas[index + countI]
                                                          [7]
                                                      .toString(),
                                                  style: globalUtility
                                                      .contenidoTablas(context),
                                                ),
                                              ),
                                              DataCell(
                                                Text(
                                                  '${listPartidas[index + countI][8]} %',
                                                  style: globalUtility
                                                      .contenidoTablas(context),
                                                ),
                                              ),
                                              DataCell(
                                                Text(
                                                  '\$ ${moneyFormat(listPartidas[index + countI][9])}',
                                                  style: globalUtility
                                                      .contenidoTablas(context),
                                                ),
                                              ),
                                              DataCell(
                                                Text(
                                                  '\$ ${moneyFormat(listPartidas[index + countI][10])}',
                                                  style: globalUtility
                                                      .contenidoTablas(context),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                              const SizedBox(
                                height: 20,
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
            popupRise
                ? Stack(
                    children: [
                      InkWell(
                        child: Container(
                          color: globalUtility.popubBgFade,
                        ),
                        onTap: () {
                          popupRise = false;
                          setState(() {});
                        },
                      ),
                      Center(
                        child: Material(
                          color: Colors.transparent,
                          elevation: 50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            decoration: BoxDecoration(
                              color: globalUtility.primaryBg,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, 10),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Material(
                                            color: Colors.transparent,
                                            elevation: 5,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(0),
                                                bottomRight: Radius.circular(0),
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15),
                                              ),
                                            ),
                                            child: Container(
                                              width: 400,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF09A963),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color:
                                                        globalUtility.primary,
                                                  )
                                                ],
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  topRight: Radius.circular(15),
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                        10, 10, 10, 10),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                  'Filtro Avanzado',
                                                                  style: globalUtility
                                                                      .tituloPopUp(
                                                                          context)),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: const [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      0, 10, 0),
                                                          child: Icon(
                                                            Icons.close,
                                                            color: Colors.white,
                                                            size: 24,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: selectedEnc.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 10, 0, 10),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            0, 0, 15, 0),
                                                    child: Text('¿Dónde?',
                                                        style: globalUtility
                                                            .textoIgual(
                                                                context)),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            0, 0, 15, 0),
                                                    child: Container(
                                                      width: 250,
                                                      height: 51,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.transparent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        border: Border.all(
                                                          color: globalUtility
                                                              .primary,
                                                          width: 1.5,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 20),
                                                        child:
                                                            DropdownButtonHideUnderline(
                                                          child: DropdownButton<
                                                              String>(
                                                            isExpanded: true,
                                                            value: selectedEnc[
                                                                index],
                                                            items: <String>[
                                                              "Registro SAP",
                                                              "Proveedor",
                                                              "Referencia",
                                                              "Importe Factura",
                                                              "Moneda",
                                                              "Dias para aplicar pago",
                                                              "%DPP",
                                                              "\$DPP",
                                                              "\$ Pronto Pago"
                                                            ]
                                                                .map((item) =>
                                                                    DropdownMenuItem<
                                                                        String>(
                                                                      value:
                                                                          item,
                                                                      child: Text(
                                                                          item),
                                                                    ))
                                                                .toList(),
                                                            onChanged: (item) {
                                                              selectedEnc[
                                                                      index] =
                                                                  item.toString();
                                                              setState(() {});
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            0, 0, 15, 0),
                                                    child: Container(
                                                      width: 90,
                                                      height: 51,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.transparent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        border: Border.all(
                                                          color: globalUtility
                                                              .primary,
                                                          width: 1.5,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 20),
                                                        child:
                                                            DropdownButtonHideUnderline(
                                                          child: DropdownButton<
                                                              String>(
                                                            isExpanded: true,
                                                            value: selectedOpe[
                                                                index],
                                                            items: <String>[
                                                              "=",
                                                              "!=",
                                                              "<",
                                                              "<=",
                                                              ">",
                                                              ">=",
                                                            ]
                                                                .map((item) =>
                                                                    DropdownMenuItem<
                                                                        String>(
                                                                      value:
                                                                          item,
                                                                      child: Text(
                                                                          item),
                                                                    ))
                                                                .toList(),
                                                            onChanged: (item) {
                                                              selectedOpe[
                                                                      index] =
                                                                  item.toString();
                                                              // print(index);
                                                              setState(() {});
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            0, 0, 15, 0),
                                                    child: Container(
                                                      width: 250,
                                                      height: 51,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.transparent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        border: Border.all(
                                                          color: globalUtility
                                                              .primary,
                                                          width: 1.5,
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                width: 200,
                                                                decoration:
                                                                    const BoxDecoration(),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsetsDirectional
                                                                              .fromSTEB(
                                                                          10,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child:
                                                                      TextFormField(
                                                                    initialValue:
                                                                        selectedVal[
                                                                            index],
                                                                    autofocus:
                                                                        true,
                                                                    obscureText:
                                                                        false,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      hintText:
                                                                          'Valor',
                                                                      hintStyle:
                                                                          globalUtility
                                                                              .hinttxt(context),
                                                                      enabledBorder:
                                                                          const UnderlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              Color(0x00000000),
                                                                          width:
                                                                              1,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.only(
                                                                          topLeft:
                                                                              Radius.circular(4.0),
                                                                          topRight:
                                                                              Radius.circular(4.0),
                                                                        ),
                                                                      ),
                                                                      focusedBorder:
                                                                          const UnderlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              Color(0x00000000),
                                                                          width:
                                                                              1,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.only(
                                                                          topLeft:
                                                                              Radius.circular(4.0),
                                                                          topRight:
                                                                              Radius.circular(4.0),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    style: globalUtility
                                                                        .label(
                                                                            context),
                                                                    onChanged:
                                                                        (value) {
                                                                      selectedVal[
                                                                              index] =
                                                                          value;
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 20, 0, 5),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 0, 15, 0),
                                                child: Text(
                                                    'Añadir filtro nuevo',
                                                    style: globalUtility
                                                        .label(context)),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 0, 15, 0),
                                                child: InkWell(
                                                  child: Container(
                                                    width: 50,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color: globalUtility
                                                            .primary,
                                                        width: 2,
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.add,
                                                          color: globalUtility
                                                              .primary,
                                                          size: 24,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    selectedEnc
                                                        .add("Registro SAP");
                                                    selectedOpe.add("=");
                                                    selectedVal.add("");
                                                    setState(() {});
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 0, 15, 0),
                                                child: InkWell(
                                                  child: Container(
                                                    width: 50,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          globalUtility.primary,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.check,
                                                          color: globalUtility
                                                              .primaryBg,
                                                          size: 24,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    popupRise = false;
                                                    getPartidasPushBy__FiltroAva();
                                                    setState(() {});
                                                  },
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
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
            (fondoDisponible - sumaPp) < 0 && fondoInsuficientePopup == false
                ? Stack(
                    children: [
                      Container(
                        color: globalUtility.popubBgFade,
                      ),
                      Center(
                        child: Material(
                          color: Colors.transparent,
                          elevation: 50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.47,
                            decoration: BoxDecoration(
                              color: globalUtility.primaryBg,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, 10),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Material(
                                            color: Colors.transparent,
                                            elevation: 5,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(0),
                                                bottomRight: Radius.circular(0),
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15),
                                              ),
                                            ),
                                            child: Container(
                                              width: 400,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF09A963),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color:
                                                        globalUtility.primary,
                                                  )
                                                ],
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(0),
                                                  bottomRight:
                                                      Radius.circular(0),
                                                  topLeft: Radius.circular(15),
                                                  topRight: Radius.circular(15),
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                        10, 10, 10, 10),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                'Fondo Insuficiente',
                                                                style: globalUtility
                                                                    .tituloPopUp(
                                                                        context),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: const [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      0, 10, 0),
                                                          child: Icon(
                                                            Icons.close,
                                                            color: Colors.white,
                                                            size: 24,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 20, 0, 0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.transparent,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(40, 0, 40, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            0, 0, 10, 20),
                                                    child: AutoSizeText(
                                                      'Para cubir el pago de las facturas seleccionadas es necesario un fondo adicional \nde \$ ${moneyFormat((fondoDisponible - sumaPp) * -1)}',
                                                      maxLines: 2,
                                                      style: globalUtility
                                                          .label(context),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            0, 0, 10, 0),
                                                    child: Text(
                                                      'Fondo total necesario:',
                                                      style: globalUtility
                                                          .label(context),
                                                    ),
                                                  ),
                                                  Text(
                                                    '\$ ${moneyFormat(fondoDisponible + ((fondoDisponible - sumaPp) * -1))}',
                                                    style: globalUtility
                                                        .textoA2(context),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 20, 0, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              0, 0, 10, 0),
                                                      child: Text(
                                                        '¿Deseas Continuar?',
                                                        style: globalUtility
                                                            .textoA(context),
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
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 15, 0, 20),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 0, 50, 0),
                                            child: InkWell(
                                              child: Container(
                                                width: 60,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  color: globalUtility
                                                      .secondaryText,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.close,
                                                      color: globalUtility
                                                          .primaryBg,
                                                      size: 30,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              onTap: () {
                                                fondoInsuficientePopup = true;
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                          InkWell(
                                            child: Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                color: globalUtility.primary,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.check_outlined,
                                                    color:
                                                        globalUtility.primaryBg,
                                                    size: 30,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              controllerFondoDisp.text =
                                                  (fondoDisponible +
                                                          ((fondoDisponible -
                                                                  sumaPp) *
                                                              -1))
                                                      .toString();
                                              fondoDisponible = double.parse(
                                                  controllerFondoDisp.text);
                                              setState(() {});
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
