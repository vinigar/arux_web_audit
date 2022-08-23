import 'dart:convert';
import 'dart:io';

import 'package:arux/helpers/globalUtility.dart';
import 'package:arux/helpers/globals.dart';
import 'package:arux/models/GET_Gestor_Partidas_QT.dart';
import 'package:arux/pages/widgets/side_menu/side_menu.dart';
import 'package:arux/pages/widgets/top_menu/top_menu.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart';

import '../functions/money_format.dart';
import 'widgets/side_menu/widgets/menu_button.dart';

class GestorPartidasPush extends StatefulWidget {
  const GestorPartidasPush({Key? key}) : super(key: key);

  @override
  State<GestorPartidasPush> createState() => _GestorPartidasPushState();
}

class _GestorPartidasPushState extends State<GestorPartidasPush> {
  GlobalUtility globalUtility = GlobalUtility();

  final controller_busqueda = TextEditingController();
  String parametro_busqueda = "";

  final controller_idpartida = TextEditingController();
  String parametro_idpartida = "";
  final controller_proveedor = TextEditingController();
  String parametro_proveedor = "";
  final controller_referencia = TextEditingController();
  String parametro_referencia = "";
  final controller_importe = TextEditingController();
  String parametro_importe = "";
  final controller_moneda = TextEditingController();
  String parametro_moneda = "";
  bool filtro_simple = false;

  List<List<dynamic>> list_partidas = [];

  String orden = "id_partidas_pk";
  bool asc = true;
  int count_i = 0;
  int count_f = 5;

  List<String?> monedas = ["USD", "UYU"];
  String moneda_selec = "USD";

  bool popup_rise = false;
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

  List<String> selected_Enc = ["Registro SAP"];
  List<String> selected_Ope = ["="];
  List<String> selected_Val = [];
  List<String> selected_Cond = [];
  bool filtro_avanzado = false;
  String query = "";

  final controller_fondo_disp = TextEditingController();
  double fondo_disponible = 0;
  late int fondo_restante;
  List<dynamic> list_carrito = [];
  double suma_importe = 0;
  double suma_pp = 0;
  double suma_dpp = 0;
  bool fondo_insuficiente_popup = false;

  ///////////////////////////////////////////////////////////////////////////////////

  @override
  void initState() {
    GetPartidasPush();
    super.initState();
  }

  Future<void> GetPartidasPush() async {
    try {
      dynamic response = await supabase
          .rpc('get_gestor_partidas', params: {'busqueda': parametro_busqueda})
          .order(orden, ascending: asc)
          .execute();

      //print("-----Error: ${response.error}");

      response = jsonEncode(response);

      /* print("-----Parametro de Busqueda: $parametro_busqueda");
      print("-----Response: ");
      print(response.toString()); */

      GetGestorPartidasQt getGestorPartidasQTResponse =
          getGestorPartidasQtFromMap(response);

      list_partidas = [];

      for (var i = 0; i < getGestorPartidasQTResponse.data.length; i++) {
        List<dynamic> local_list = [];

        local_list.add(false);
        local_list.add(getGestorPartidasQTResponse.data[i].idPartidasPk);
        local_list.add(getGestorPartidasQTResponse.data[i].proveedor);
        local_list.add(getGestorPartidasQTResponse.data[i].referencia);
        local_list.add(double.parse(
            getGestorPartidasQTResponse.data[i].importe.toStringAsFixed(2)));
        local_list.add(getGestorPartidasQTResponse.data[i].moneda);
        local_list.add(getGestorPartidasQTResponse.data[i].importeUsd);
        local_list.add(getGestorPartidasQTResponse.data[i].diasPago);
        local_list.add(getGestorPartidasQTResponse.data[i].porcDpp);
        local_list.add(double.parse(
            getGestorPartidasQTResponse.data[i].cantDpp.toStringAsFixed(2)));
        local_list.add(double.parse(
            getGestorPartidasQTResponse.data[i].prontoPago.toStringAsFixed(2)));
        list_partidas.add(local_list);

        //print("Indice $i : ${list_partidas[i]}");
        //print("Indice $i : ${list_partidas[i][1]}");
        //print("Indice $i : ${list_partidas[i].length}");
      }

      //print("Listas : ${list_partidas.length}");

    } catch (e) {
      print(e);
    }
    setState(() {});
  }

  ///////////////////////////////////////////////////////////////////////////////////

  Future<void> GetPartidasPushBy__Filtro_Sim() async {
    try {
      dynamic response = await supabase
          .rpc('get_gestor_partidas_push_by__', params: {
            'idpartida': parametro_idpartida,
            'proveedor': parametro_proveedor,
            'referencia': parametro_referencia,
            'importe': parametro_importe,
            'moneda': parametro_moneda
          })
          .order(orden, ascending: asc)
          .execute();

      print("-----Error: ${response.error}");

      response = jsonEncode(response);

      // print("-----Parametro de Busqueda: $parametro_busqueda");
      /* print("-----Response: ");
      print(response.toString()); */

      GetGestorPartidasQt getGestorPartidasQTResponse =
          getGestorPartidasQtFromMap(response);

      list_partidas = [];

      for (var i = 0; i < getGestorPartidasQTResponse.data.length; i++) {
        List<dynamic> local_list = [];

        local_list.add(false);
        local_list.add(getGestorPartidasQTResponse.data[i].idPartidasPk);
        local_list.add(getGestorPartidasQTResponse.data[i].proveedor);
        local_list.add(getGestorPartidasQTResponse.data[i].referencia);
        local_list.add(getGestorPartidasQTResponse.data[i].importe);
        local_list.add(getGestorPartidasQTResponse.data[i].moneda);
        local_list.add("\$ ${getGestorPartidasQTResponse.data[i].importeUsd}");
        local_list.add(getGestorPartidasQTResponse.data[i].diasPago);
        local_list.add("${getGestorPartidasQTResponse.data[i].porcDpp} %");
        local_list.add("\$ ${getGestorPartidasQTResponse.data[i].cantDpp}");
        local_list.add("\$ ${getGestorPartidasQTResponse.data[i].prontoPago}");

        list_partidas.add(local_list);

        //print("Indice $i : ${list_partidas[i]}");
        //print("Indice $i : ${list_partidas[i][1]}");
        //print("Indice $i : ${list_partidas[i].length}");
      }

      //print("Listas : ${list_partidas.length}");

    } catch (e) {
      print(e);
    }

    setState(() {});
  }

  ///////////////////////////////////////////////////////////////////////////////////

  Future<void> GetPartidasPushBy__Filtro_Ava() async {
    try {
      query = "";
      for (var i = 0; i < selected_Enc.length; i++) {
        String _local_enc = "";
        String _local_cond = "";
        switch (selected_Enc[i]) {
          case "Registro SAP":
            _local_enc = "id_partidas_pk";
            break;
          case "Proveedor":
            _local_enc = "proveedores.sociedad";
            break;
          case "Referencia":
            _local_enc = "partidas_sap.referencia";
            break;
          case "Importe Factura":
            _local_enc = "partidas_sap.importe_ml";
            break;
          case "Moneda":
            _local_enc = "partidas_sap.ml";
            break;
          case "Dias para aplicar pago":
            _local_enc = "partidas_sap.dias_pago";
            break;
          case "%DPP":
            _local_enc = "partidas_sap.descuento_porc_pp";
            break;
          case "\$DPP":
            _local_enc = "partidas_sap.descuento_cant_pp";
            break;
          case "\$ Pronto Pago":
            _local_enc = "partidas_sap.pronto_pago";
            break;
        }
        query = (query + " " + selected_Enc[i]).toString();
      }

      /* dynamic response = await supabase
          .rpc('get_partidas_by_filtrado', params: {
            'query': query,
          })
          .order(orden, ascending: asc)
          .execute();

      print("-----Error: ${response.error}");

      response = jsonEncode(response);

      /* print("-----Response: ");
      print(response.toString()); */

      GetGestorPartidasQt getGestorPartidasQTResponse =
          getGestorPartidasQtFromMap(response);

      list_partidas = [];

      for (var i = 0; i < getGestorPartidasQTResponse.data.length; i++) {
        List<dynamic> local_list = [];

        local_list.add(false);
        local_list.add(getGestorPartidasQTResponse.data[i].idPartidasPk);
        local_list.add(getGestorPartidasQTResponse.data[i].proveedor);
        local_list.add(getGestorPartidasQTResponse.data[i].referencia);
        local_list.add(getGestorPartidasQTResponse.data[i].importe);
        local_list.add(getGestorPartidasQTResponse.data[i].moneda);
        local_list.add("\$ ${getGestorPartidasQTResponse.data[i].importeUsd}");
        local_list.add(getGestorPartidasQTResponse.data[i].diasPago);
        local_list.add("${getGestorPartidasQTResponse.data[i].porcDpp} %");
        local_list.add("\$ ${getGestorPartidasQTResponse.data[i].cantDpp}");
        local_list.add("\$ ${getGestorPartidasQTResponse.data[i].prontoPago}");

        list_partidas.add(local_list);

        //print("Indice $i : ${list_partidas[i]}");
        //print("Indice $i : ${list_partidas[i][1]}");
        //print("Indice $i : ${list_partidas[i].length}");
      }

      //print("Listas : ${list_partidas.length}"); */

    } catch (e) {
      print(e);
    }

    setState(() {});
  }

  ///////////////////////////////////////////////////////////////////////////////////

  Future<void> UpdatePartidas_Solicitadas() async {
    try {
      for (var i = 0; i < list_carrito.length; i++) {
        dynamic response = await supabase
            .from('partidas_sap')
            .update({'id_estatus_fk': 5}).match(
                {'id_partidas_pk': '${list_carrito[i][0]}'}).execute();

        print("-----Error: ${response.error}");
        /* print("-----Response: ${response.toString()}");
        print('Update realizado'); */

      }
      var postresponse = await post(
          Uri.parse('https://arux.cbluna-dev.com/arux/api'),
          body: json.encode({"action": "Ejecutar_Partidas"}));
/* 
      print("-----PostResponseCode: " + postresponse.statusCode.toString());
      print("-----PostResponseBody: " + postresponse.body); */

      const snackbarComplete = SnackBar(
        content: Text('Proceso Realizado con exito'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbarComplete);
      Navigator.pushNamed(
        context,
        '/gestor-partidas-push',
      );
    } catch (e) {
      print(e);
    }
  }

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
                                      /* Padding(
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
                                              Icons.grid_view,
                                              color: globalUtility.primary,
                                              size: 28,
                                            ),
                                          ),
                                        ),
                                      ), */
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
                                            if (list_carrito.isNotEmpty &&
                                                (fondo_disponible - suma_pp) >=
                                                    0) {
                                              UpdatePartidas_Solicitadas();
                                            } else if (list_carrito.isEmpty) {
                                              const snackbarVacio = SnackBar(
                                                content: Text(
                                                    'Debe de seleccion por lo menos una partida para realizar este proceso'),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackbarVacio);
                                            } else if ((fondo_disponible -
                                                    suma_pp) <
                                                0) {
                                              fondo_insuficiente_popup = false;
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
                                                          controller_busqueda,
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
                                                        parametro_busqueda =
                                                            value;
                                                        if (filtro_avanzado) {
                                                        } else {
                                                          GetPartidasPush();
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
                                                          if (filtro_simple ==
                                                                  false ||
                                                              filtro_avanzado ==
                                                                  false) {
                                                            count_f++;
                                                            GetPartidasPush();
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
                                                            color: count_f == 0
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
                                                          if (filtro_simple ==
                                                                  false ||
                                                              filtro_avanzado ==
                                                                  false) {
                                                            if (count_f >= 1) {
                                                              count_f--;
                                                              GetPartidasPush();
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
                                                                  print(
                                                                      "---Valor: ${value.toString()}");
                                                                  if (value
                                                                          .isNotEmpty ||
                                                                      value !=
                                                                          "0") {
                                                                    count_f = int
                                                                        .parse(value
                                                                            .toString());
                                                                    count_f =
                                                                        count_f -
                                                                            1;
                                                                    GetPartidasPush();
                                                                    setState(
                                                                        () {});
                                                                  }
                                                                } catch (e) {
                                                                  print(
                                                                      "---Error: $e");
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
                                      /* Container(
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
                                              popup_rise = true;
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ), */
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
                                                                  controller_fondo_disp,
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
                                                                fondo_disponible =
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
                                                            moneda_selec =
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
                                                            '\$ ${moneyFormat(fondo_disponible - suma_pp)}',
                                                            style: (fondo_disponible -
                                                                        suma_pp) <
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
                                                                  '\$ ${moneyFormat(suma_importe - suma_dpp)}',
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
                                                                  '\$ ${moneyFormat(suma_importe)}',
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
                                                                  '\$ ${moneyFormat(suma_dpp)}',
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
                              list_partidas.isEmpty
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
                                          List<dynamic> _temp_list = [];
                                          if (isCheck) {
                                            for (var i = count_i;
                                                i < list_partidas.length;
                                                i++) {
                                              list_partidas[i][0] = true;
                                              _temp_list
                                                  .add(list_partidas[i][1]);
                                              _temp_list
                                                  .add(list_partidas[i][2]);
                                              _temp_list
                                                  .add(list_partidas[i][3]);
                                              _temp_list
                                                  .add(list_partidas[i][4]);
                                              _temp_list
                                                  .add(list_partidas[i][5]);
                                              _temp_list
                                                  .add(list_partidas[i][6]);
                                              _temp_list
                                                  .add(list_partidas[i][7]);
                                              _temp_list
                                                  .add(list_partidas[i][8]);
                                              _temp_list
                                                  .add(list_partidas[i][9]);
                                              _temp_list
                                                  .add(list_partidas[i][10]);
                                              list_carrito.removeWhere((item) {
                                                return item[1].toString() ==
                                                        _temp_list[1]
                                                            .toString() &&
                                                    item[2].toString() ==
                                                        _temp_list[2]
                                                            .toString();
                                              });
                                              list_carrito.add(_temp_list);
                                              _temp_list = [];
                                            }
                                          } else {
                                            for (var i = count_i;
                                                i < list_partidas.length;
                                                i++) {
                                              list_partidas[i][0] = false;
                                              list_carrito.removeWhere((item) {
                                                return item[0].toString() ==
                                                    list_partidas[i][1]
                                                        .toString();
                                              });
                                            }
                                            _temp_list.clear();
                                          }
                                          if (list_carrito.isNotEmpty) {
                                            suma_importe = 0;
                                            suma_dpp = 0;
                                            suma_pp = 0;
                                            for (var i = 0;
                                                i < list_carrito.length;
                                                i++) {
                                              suma_importe = suma_importe +
                                                  list_carrito[i][5];
                                              suma_dpp =
                                                  suma_dpp + list_carrito[i][8];
                                              suma_pp =
                                                  suma_pp + list_carrito[i][9];
                                            }
                                          } else {
                                            suma_importe = 0;
                                            suma_dpp = 0;
                                            suma_pp = 0;
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
                                              '\$ Importe\n$moneda_selec',
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
                                          list_partidas.length,
                                          (index) => DataRow(
                                            selected:
                                                list_partidas[index + count_i]
                                                    [0],
                                            onSelectChanged: (value) =>
                                                setState(
                                              () {
                                                final isCheck =
                                                    value != null && value;
                                                final List<dynamic> _temp_list =
                                                    [];

                                                if (isCheck) {
                                                  list_partidas[index + count_i]
                                                      [0] = true;
                                                  _temp_list.add(list_partidas[
                                                      index + count_i][1]);
                                                  _temp_list.add(list_partidas[
                                                      index + count_i][2]);
                                                  _temp_list.add(list_partidas[
                                                      index + count_i][3]);
                                                  _temp_list.add(list_partidas[
                                                      index + count_i][4]);
                                                  _temp_list.add(list_partidas[
                                                      index + count_i][5]);
                                                  _temp_list.add(list_partidas[
                                                      index + count_i][6]);
                                                  _temp_list.add(list_partidas[
                                                      index + count_i][7]);
                                                  _temp_list.add(list_partidas[
                                                      index + count_i][8]);
                                                  _temp_list.add(list_partidas[
                                                      index + count_i][9]);
                                                  _temp_list.add(list_partidas[
                                                      index + count_i][10]);
                                                  list_carrito.add(_temp_list);
                                                } else {
                                                  list_partidas[index + count_i]
                                                      [0] = false;
                                                  _temp_list.add(list_partidas[
                                                      index + count_i][1]);
                                                  _temp_list.add(list_partidas[
                                                      index + count_i][2]);
                                                  _temp_list.add(list_partidas[
                                                      index + count_i][3]);
                                                  _temp_list.add(list_partidas[
                                                      index + count_i][4]);
                                                  _temp_list.add(list_partidas[
                                                      index + count_i][5]);
                                                  _temp_list.add(list_partidas[
                                                      index + count_i][6]);
                                                  _temp_list.add(list_partidas[
                                                      index + count_i][7]);
                                                  _temp_list.add(list_partidas[
                                                      index + count_i][8]);
                                                  _temp_list.add(list_partidas[
                                                      index + count_i][9]);
                                                  _temp_list.add(list_partidas[
                                                      index + count_i][10]);
                                                  list_carrito
                                                      .removeWhere((item) {
                                                    return item[1].toString() ==
                                                            _temp_list[1]
                                                                .toString() &&
                                                        item[2].toString() ==
                                                            _temp_list[2]
                                                                .toString();
                                                  });
                                                }
                                                suma_importe = 0;
                                                suma_dpp = 0;
                                                suma_pp = 0;
                                                for (var i = 0;
                                                    i < list_carrito.length;
                                                    i++) {
                                                  suma_importe = suma_importe +
                                                      list_carrito[i][5];
                                                  suma_dpp = suma_dpp +
                                                      list_carrito[i][8];
                                                  suma_pp = suma_pp +
                                                      list_carrito[i][9];
                                                }
                                              },
                                            ),
                                            cells: [
                                              DataCell(
                                                Text(
                                                  list_partidas[index + count_i]
                                                          [1]
                                                      .toString(),
                                                  style: globalUtility
                                                      .contenidoTablas(context),
                                                ),
                                              ),
                                              DataCell(
                                                Text(
                                                  list_partidas[index + count_i]
                                                          [2]
                                                      .toString(),
                                                  style: globalUtility
                                                      .contenidoTablas(context),
                                                ),
                                              ),
                                              DataCell(
                                                Center(
                                                  child: Text(
                                                    list_partidas[
                                                            index + count_i][3]
                                                        .toString(),
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                Text(
                                                  '\$ ${moneyFormat(list_partidas[index + count_i][4])}',
                                                  style: globalUtility
                                                      .contenidoTablas(context),
                                                ),
                                              ),
                                              DataCell(
                                                Center(
                                                  child: Text(
                                                    list_partidas[
                                                            index + count_i][5]
                                                        .toString(),
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                Text(
                                                  '\$ ${moneyFormat(list_partidas[index + count_i][6])}',
                                                  style: globalUtility
                                                      .contenidoTablas(context),
                                                ),
                                              ),
                                              DataCell(
                                                Text(
                                                  list_partidas[index + count_i]
                                                          [7]
                                                      .toString(),
                                                  style: globalUtility
                                                      .contenidoTablas(context),
                                                ),
                                              ),
                                              DataCell(
                                                Text(
                                                  '${list_partidas[index + count_i][8]} %',
                                                  style: globalUtility
                                                      .contenidoTablas(context),
                                                ),
                                              ),
                                              DataCell(
                                                Text(
                                                  '\$ ${moneyFormat(list_partidas[index + count_i][9])}',
                                                  style: globalUtility
                                                      .contenidoTablas(context),
                                                ),
                                              ),
                                              DataCell(
                                                Text(
                                                  '\$ ${moneyFormat(list_partidas[index + count_i][10])}',
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
            popup_rise
                ? Stack(
                    children: [
                      InkWell(
                        child: Container(
                          color: globalUtility.popubBgFade,
                        ),
                        onTap: () {
                          popup_rise = false;
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
                                          itemCount: selected_Enc.length,
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
                                                            value: selected_Enc[
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
                                                              selected_Enc[
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
                                                            value: selected_Ope[
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
                                                              selected_Ope[
                                                                      index] =
                                                                  item.toString();
                                                              print(index);
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
                                                                      selected_Val[
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
                                                    selected_Enc
                                                        .add("Registro SAP");
                                                    selected_Ope.add("=");
                                                    selected_Val.add("");
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
            (fondo_disponible - suma_pp) < 0 &&
                    fondo_insuficiente_popup == false
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
                                                      children: [
                                                        const Padding(
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
                                                      'Para cubir el pago de las facturas seleccionadas es necesario un fondo adicional \nde \$ ${moneyFormat((fondo_disponible - suma_pp) * -1)}',
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
                                                    '\$ ${moneyFormat(fondo_disponible + ((fondo_disponible - suma_pp) * -1))}',
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
                                                fondo_insuficiente_popup = true;
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
                                              controller_fondo_disp.text =
                                                  (fondo_disponible +
                                                          ((fondo_disponible -
                                                                  suma_pp) *
                                                              -1))
                                                      .toString();
                                              fondo_disponible = double.parse(
                                                  controller_fondo_disp.text);
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
