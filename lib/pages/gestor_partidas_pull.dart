import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:arux/helpers/global_utility.dart';
import 'package:arux/helpers/globals.dart';
import 'package:arux/models/get_gestor_partidas_qt.dart';
import 'package:arux/pages/widgets/side_menu/side_menu.dart';
import 'package:arux/pages/widgets/top_menu/top_menu.dart';

class GestorPartidasPull extends StatefulWidget {
  const GestorPartidasPull({Key? key}) : super(key: key);

  @override
  State<GestorPartidasPull> createState() => _GestorPartidasPullState();
}

class _GestorPartidasPullState extends State<GestorPartidasPull> {
  GlobalUtility globalUtility = GlobalUtility();

  final controllerbusqueda = TextEditingController();
  String parametrobusqueda = "";

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

  List<List<dynamic>> listPartidas = [];
  String orden = "id_partidas_pk";
  bool asc = true;
  int countI = 0;
  int countF = 19;

  bool popupRise = false;
  List<String?> selectedDDEnc = ["Registro SAP"];
  List<String?> selectedDDEnctransf = [""];
  List<String?> selectedDDOpe = ["="];
  List<String?> parametroFilt = [""];
  final controllerbusquedafiltro = TextEditingController();

  bool filtroAvanzado = false;
  bool filtroSimple = false;

  ///////////////////////////////////////////////////////////////////////////////////

  @override
  void initState() {
    getPartidas();
    super.initState();
  }

  Future<void> getPartidas() async {
    try {
      dynamic response = await supabase
          .rpc('get_gestor_partidas_pull',
              params: {'busqueda': parametrobusqueda})
          .order(orden, ascending: asc)
          .range(0, countF)
          .execute();

      //// print("-----Error: ${response.error}");

      response = jsonEncode(response);

      /* // print("-----Parametro de Busqueda: $parametrobusqueda");
      // print("-----Response: ");
      // print(response.toString()); */

      GetGestorPartidasQt getGestorPartidasQtResponse =
          getGestorPartidasQtFromMap(response);

      listPartidas = [];

      for (var i = 0; i < getGestorPartidasQtResponse.data.length; i++) {
        List<dynamic> localList = [];

        localList.add(getGestorPartidasQtResponse.data[i].idPartidasPk);
        localList.add(getGestorPartidasQtResponse.data[i].proveedor);
        localList.add(getGestorPartidasQtResponse.data[i].referencia);
        localList.add("\$ ${getGestorPartidasQtResponse.data[i].importe}");
        localList.add(getGestorPartidasQtResponse.data[i].moneda);
        localList.add("\$ ${getGestorPartidasQtResponse.data[i].importeUsd}");
        localList.add(getGestorPartidasQtResponse.data[i].diasPago);
        localList.add("${getGestorPartidasQtResponse.data[i].porcDpp} %");
        localList.add("\$ ${getGestorPartidasQtResponse.data[i].cantDpp}");
        localList.add("\$ ${getGestorPartidasQtResponse.data[i].prontoPago}");

        listPartidas.add(localList);

        //// print("Indice $i : ${listPartidas[i]}");
        //// print("Indice $i : ${listPartidas[i][1]}");
        //// print("Indice $i : ${listPartidas[i].length}");
      }

      //// print("Listas : ${listPartidas.length}");

    } catch (e) {
      //// print(e);
    }

    setState(() {});
  }

  ///////////////////////////////////////////////////////////////////////////////////

  // ignore: non_constant_identifier_names
  Future<void> getPartidasBy__() async {
    try {
      dynamic response = await supabase
          .rpc('get_gestor_partidas_pull_by__', params: {
            'idpartida': parametroIdPartida,
            'proveedor': parametroProveedor,
            'referencia': parametroReferencia,
            'importe': parametroImporte,
            'moneda': parametroMoneda
          })
          .order(orden, ascending: asc)
          .execute();

      //// print("-----Error: ${response.error}");

      response = jsonEncode(response);

      /* // print("-----Parametro de Busqueda: $parametrobusqueda");
      // print("-----Response: ");
      // print(response.toString()); */

      GetGestorPartidasQt getGestorPartidasQtResponse =
          getGestorPartidasQtFromMap(response);

      listPartidas = [];

      for (var i = 0; i < getGestorPartidasQtResponse.data.length; i++) {
        List<dynamic> localList = [];

        localList.add(getGestorPartidasQtResponse.data[i].idPartidasPk);
        localList.add(getGestorPartidasQtResponse.data[i].proveedor);
        localList.add(getGestorPartidasQtResponse.data[i].referencia);
        localList.add("\$ ${getGestorPartidasQtResponse.data[i].importe}");
        localList.add(getGestorPartidasQtResponse.data[i].moneda);
        localList.add("\$ ${getGestorPartidasQtResponse.data[i].importeUsd}");
        localList.add(getGestorPartidasQtResponse.data[i].diasPago);
        localList.add("${getGestorPartidasQtResponse.data[i].porcDpp} %");
        localList.add("\$ ${getGestorPartidasQtResponse.data[i].cantDpp}");
        localList.add("\$ ${getGestorPartidasQtResponse.data[i].prontoPago}");

        listPartidas.add(localList);

        //// print("Indice $i : ${listPartidas[i]}");
        //// print("Indice $i : ${listPartidas[i][1]}");
        //// print("Indice $i : ${listPartidas[i].length}");
      }

      //// print("Listas : ${listPartidas.length}");

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
                                    'Gestor de Facturas\nPull NC - Pago',
                                    style: globalUtility.tituloPagina(context),
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
                                                          controllerbusqueda,
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
                                                        parametrobusqueda =
                                                            value;
                                                        if (filtroAvanzado) {
                                                          switch (selectedDDOpe[
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
                                                          getPartidas();
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
                                                            getPartidas();
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
                                                              getPartidas();
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
                                                                    getPartidas();
                                                                    setState(
                                                                        () {});
                                                                  }
                                                                } catch (e) {
                                                                  // print( "---Error: $e");
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
                                                  () =>
                                                      selectedDDEnc[0] = item),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(top: 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 10, 0),
                                  child: Text(
                                    'Fondo Disponible ',
                                    style: globalUtility.textoIgual(context),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 15, 0),
                                  child: Container(
                                    width: 200,
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
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              10, 0, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 0, 10, 0),
                                            child: Text(
                                              '\$24,000,000.00',
                                              style:
                                                  globalUtility.textoA(context),
                                            ),
                                          ),
                                        ],
                                      ),
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
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Selección de pagos: ',
                                            style: globalUtility
                                                .textoIgual(context),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(10, 0, 0, 0),
                                            child: Text(
                                              '\$24,945,056.50',
                                              style:
                                                  globalUtility.textoA(context),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 10, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Beneficio DPP: ',
                                              style: globalUtility
                                                  .textoIgual(context),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(10, 0, 0, 0),
                                              child: Text(
                                                '\$24,945,056.50',
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
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 10, 0),
                                child: Text(
                                  'Fondo Disponible Restante: ',
                                  style: globalUtility.textoIgual(context),
                                ),
                              ),
                              Text(
                                '\$1,045,236.45',
                                style: globalUtility.textoA(context),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 350,
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
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(10, 0, 10, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              'TOTAL A PAGAR: ',
                                              style: globalUtility
                                                  .textoIgual(context),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(10, 0, 0, 0),
                                              child: Text(
                                                '\$24,000,000.00',
                                                style: globalUtility
                                                    .textoA(context),
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
                                            child: Text(
                                              'Aplicar',
                                              textAlign: TextAlign.center,
                                              style: globalUtility
                                                  .encabezadoTablasOff(context),
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    "Registro\nSAP",
                                                    textAlign: TextAlign.center,
                                                    style: parametroIdPartida
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
                                                      controllerIdPartida
                                                          .clear();
                                                      parametroIdPartida = "";
                                                      controllerProveedor
                                                          .clear();
                                                      parametroProveedor = "";
                                                      controllerReferencia
                                                          .clear();
                                                      parametroReferencia = "";
                                                      controllerImporte.clear();
                                                      parametroImporte = "";
                                                      controllerMoneda.clear();
                                                      parametroMoneda = "";
                                                    }
                                                    getPartidas();
                                                    setState(() {});
                                                  },
                                                ),
                                                InkWell(
                                                  child: Icon(
                                                      orden == "id_partidas_pk"
                                                          ? asc == true
                                                              ? Icons
                                                                  .arrow_drop_down
                                                              : Icons
                                                                  .arrow_drop_up
                                                          : Icons
                                                              .arrow_drop_down,
                                                      color: orden ==
                                                              "id_partidas_pk"
                                                          ? globalUtility
                                                              .primaryBg
                                                          : globalUtility
                                                              .secondary),
                                                  onTap: () {
                                                    if (orden !=
                                                        "id_partidas_pk") {
                                                      orden = "id_partidas_pk";
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
                                                      getPartidasBy__();
                                                    } else {
                                                      getPartidas();
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
                                                      controllerIdPartida
                                                          .clear();
                                                      parametroIdPartida = "";
                                                      controllerProveedor
                                                          .clear();
                                                      parametroProveedor = "";
                                                      controllerReferencia
                                                          .clear();
                                                      parametroReferencia = "";
                                                      controllerImporte.clear();
                                                      parametroImporte = "";
                                                      controllerMoneda.clear();
                                                      parametroMoneda = "";
                                                    }
                                                    getPartidas();
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
                                                      getPartidasBy__();
                                                    } else {
                                                      getPartidas();
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
                                                    "Referencia",
                                                    textAlign: TextAlign.center,
                                                    style: parametroReferencia
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
                                                      controllerIdPartida
                                                          .clear();
                                                      parametroIdPartida = "";
                                                      controllerProveedor
                                                          .clear();
                                                      parametroProveedor = "";
                                                      controllerReferencia
                                                          .clear();
                                                      parametroReferencia = "";
                                                      controllerImporte.clear();
                                                      parametroImporte = "";
                                                      controllerMoneda.clear();
                                                      parametroMoneda = "";
                                                    }
                                                    getPartidas();
                                                    setState(() {});
                                                  },
                                                ),
                                                InkWell(
                                                  child: Icon(
                                                      orden == "referencia"
                                                          ? asc == true
                                                              ? Icons
                                                                  .arrow_drop_down
                                                              : Icons
                                                                  .arrow_drop_up
                                                          : Icons
                                                              .arrow_drop_down,
                                                      color:
                                                          orden == "referencia"
                                                              ? globalUtility
                                                                  .primaryBg
                                                              : globalUtility
                                                                  .secondary),
                                                  onTap: () {
                                                    if (orden != "referencia") {
                                                      orden = "referencia";
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
                                                      getPartidasBy__();
                                                    } else {
                                                      getPartidas();
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
                                                    "Importe\nFactura",
                                                    textAlign: TextAlign.center,
                                                    style: parametroImporte
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
                                                      controllerIdPartida
                                                          .clear();
                                                      parametroIdPartida = "";
                                                      controllerProveedor
                                                          .clear();
                                                      parametroProveedor = "";
                                                      controllerReferencia
                                                          .clear();
                                                      parametroReferencia = "";
                                                      controllerImporte.clear();
                                                      parametroImporte = "";
                                                      controllerMoneda.clear();
                                                      parametroMoneda = "";
                                                    }
                                                    getPartidas();
                                                    setState(() {});
                                                  },
                                                ),
                                                InkWell(
                                                  child: Icon(
                                                      orden == "importe"
                                                          ? asc == true
                                                              ? Icons
                                                                  .arrow_drop_down
                                                              : Icons
                                                                  .arrow_drop_up
                                                          : Icons
                                                              .arrow_drop_down,
                                                      color: orden == "importe"
                                                          ? globalUtility
                                                              .primaryBg
                                                          : globalUtility
                                                              .secondary),
                                                  onTap: () {
                                                    if (orden != "importe") {
                                                      orden = "importe";
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
                                                      getPartidasBy__();
                                                    } else {
                                                      getPartidas();
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
                                                    style: parametroMoneda
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
                                                      controllerIdPartida
                                                          .clear();
                                                      parametroIdPartida = "";
                                                      controllerProveedor
                                                          .clear();
                                                      parametroProveedor = "";
                                                      controllerReferencia
                                                          .clear();
                                                      parametroReferencia = "";
                                                      controllerImporte.clear();
                                                      parametroImporte = "";
                                                      controllerMoneda.clear();
                                                      parametroMoneda = "";
                                                    }
                                                    getPartidas();
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
                                                      getPartidasBy__();
                                                    } else {
                                                      getPartidas();
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
                                                    "\$ Importe\nUSD",
                                                    textAlign: TextAlign.center,
                                                    style: globalUtility
                                                        .encabezadoTablasOff(
                                                            context),
                                                  ),
                                                  onTap: () {
                                                    if (filtroSimple == false) {
                                                      filtroAvanzado = false;
                                                      filtroSimple = true;
                                                    } else {
                                                      filtroSimple = false;
                                                      controllerIdPartida
                                                          .clear();
                                                      parametroIdPartida = "";
                                                      controllerProveedor
                                                          .clear();
                                                      parametroProveedor = "";
                                                      controllerReferencia
                                                          .clear();
                                                      parametroReferencia = "";
                                                      controllerImporte.clear();
                                                      parametroImporte = "";
                                                      controllerMoneda.clear();
                                                      parametroMoneda = "";
                                                    }
                                                    getPartidas();
                                                    setState(() {});
                                                  },
                                                ),
                                                InkWell(
                                                  child: Icon(
                                                      orden == "importe"
                                                          ? asc == true
                                                              ? Icons
                                                                  .arrow_drop_down
                                                              : Icons
                                                                  .arrow_drop_up
                                                          : Icons
                                                              .arrow_drop_down,
                                                      color: orden == "importe"
                                                          ? globalUtility
                                                              .primaryBg
                                                          : globalUtility
                                                              .secondary),
                                                  onTap: () {
                                                    if (orden != "importe") {
                                                      orden = "importe";
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
                                                      getPartidasBy__();
                                                    } else {
                                                      getPartidas();
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
                                                    "Días para\n aplicar Pago",
                                                    textAlign: TextAlign.center,
                                                    style: globalUtility
                                                        .encabezadoTablasOff(
                                                            context),
                                                  ),
                                                  onTap: () {
                                                    if (filtroSimple == false) {
                                                      filtroAvanzado = false;
                                                      filtroSimple = true;
                                                    } else {
                                                      filtroSimple = false;
                                                      controllerIdPartida
                                                          .clear();
                                                      parametroIdPartida = "";
                                                      controllerProveedor
                                                          .clear();
                                                      parametroProveedor = "";
                                                      controllerReferencia
                                                          .clear();
                                                      parametroReferencia = "";
                                                      controllerImporte.clear();
                                                      parametroImporte = "";
                                                      controllerMoneda.clear();
                                                      parametroMoneda = "";
                                                    }
                                                    getPartidas();
                                                    setState(() {});
                                                  },
                                                ),
                                                InkWell(
                                                  child: Icon(
                                                      orden == "dias_pago"
                                                          ? asc == true
                                                              ? Icons
                                                                  .arrow_drop_down
                                                              : Icons
                                                                  .arrow_drop_up
                                                          : Icons
                                                              .arrow_drop_down,
                                                      color:
                                                          orden == "dias_pago"
                                                              ? globalUtility
                                                                  .primaryBg
                                                              : globalUtility
                                                                  .secondary),
                                                  onTap: () {
                                                    if (orden != "dias_pago") {
                                                      orden = "dias_pago";
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
                                                      getPartidasBy__();
                                                    } else {
                                                      getPartidas();
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
                                                    "%DPP",
                                                    textAlign: TextAlign.center,
                                                    style: globalUtility
                                                        .encabezadoTablasOff(
                                                            context),
                                                  ),
                                                  onTap: () {
                                                    if (filtroSimple == false) {
                                                      filtroAvanzado = false;
                                                      filtroSimple = true;
                                                    } else {
                                                      filtroSimple = false;
                                                      controllerIdPartida
                                                          .clear();
                                                      parametroIdPartida = "";
                                                      controllerProveedor
                                                          .clear();
                                                      parametroProveedor = "";
                                                      controllerReferencia
                                                          .clear();
                                                      parametroReferencia = "";
                                                      controllerImporte.clear();
                                                      parametroImporte = "";
                                                      controllerMoneda.clear();
                                                      parametroMoneda = "";
                                                    }
                                                    getPartidas();
                                                    setState(() {});
                                                  },
                                                ),
                                                InkWell(
                                                  child: Icon(
                                                      orden == "porc_dpp"
                                                          ? asc == true
                                                              ? Icons
                                                                  .arrow_drop_down
                                                              : Icons
                                                                  .arrow_drop_up
                                                          : Icons
                                                              .arrow_drop_down,
                                                      color: orden == "porc_dpp"
                                                          ? globalUtility
                                                              .primaryBg
                                                          : globalUtility
                                                              .secondary),
                                                  onTap: () {
                                                    if (orden != "porc_dpp") {
                                                      orden = "porc_dpp";
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
                                                      getPartidasBy__();
                                                    } else {
                                                      getPartidas();
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
                                                    "\$DPP",
                                                    textAlign: TextAlign.center,
                                                    style: globalUtility
                                                        .encabezadoTablasOff(
                                                            context),
                                                  ),
                                                  onTap: () {
                                                    if (filtroSimple == false) {
                                                      filtroAvanzado = false;
                                                      filtroSimple = true;
                                                    } else {
                                                      filtroSimple = false;
                                                      controllerIdPartida
                                                          .clear();
                                                      parametroIdPartida = "";
                                                      controllerProveedor
                                                          .clear();
                                                      parametroProveedor = "";
                                                      controllerReferencia
                                                          .clear();
                                                      parametroReferencia = "";
                                                      controllerImporte.clear();
                                                      parametroImporte = "";
                                                      controllerMoneda.clear();
                                                      parametroMoneda = "";
                                                    }
                                                    getPartidas();
                                                    setState(() {});
                                                  },
                                                ),
                                                InkWell(
                                                  child: Icon(
                                                      orden == "cant_dpp"
                                                          ? asc == true
                                                              ? Icons
                                                                  .arrow_drop_down
                                                              : Icons
                                                                  .arrow_drop_up
                                                          : Icons
                                                              .arrow_drop_down,
                                                      color: orden == "cant_dpp"
                                                          ? globalUtility
                                                              .primaryBg
                                                          : globalUtility
                                                              .secondary),
                                                  onTap: () {
                                                    if (orden != "cant_dpp") {
                                                      orden = "cant_dpp";
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
                                                      getPartidasBy__();
                                                    } else {
                                                      getPartidas();
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
                                                    "\$ Pronto\nPago",
                                                    textAlign: TextAlign.center,
                                                    style: globalUtility
                                                        .encabezadoTablasOff(
                                                            context),
                                                  ),
                                                  onTap: () {
                                                    if (filtroSimple == false) {
                                                      filtroAvanzado = false;
                                                      filtroSimple = true;
                                                    } else {
                                                      filtroSimple = false;
                                                      controllerIdPartida
                                                          .clear();
                                                      parametroIdPartida = "";
                                                      controllerProveedor
                                                          .clear();
                                                      parametroProveedor = "";
                                                      controllerReferencia
                                                          .clear();
                                                      parametroReferencia = "";
                                                      controllerImporte.clear();
                                                      parametroImporte = "";
                                                      controllerMoneda.clear();
                                                      parametroMoneda = "";
                                                    }
                                                    getPartidas();
                                                    setState(() {});
                                                  },
                                                ),
                                                InkWell(
                                                  child: Icon(
                                                      orden == "pronto_pago"
                                                          ? asc == true
                                                              ? Icons
                                                                  .arrow_drop_down
                                                              : Icons
                                                                  .arrow_drop_up
                                                          : Icons
                                                              .arrow_drop_down,
                                                      color:
                                                          orden == "pronto_pago"
                                                              ? globalUtility
                                                                  .primaryBg
                                                              : globalUtility
                                                                  .secondary),
                                                  onTap: () {
                                                    if (orden !=
                                                        "pronto_pago") {
                                                      orden = "pronto_pago";
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
                                                      getPartidasBy__();
                                                    } else {
                                                      getPartidas();
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
                                                const Expanded(
                                                    child: SizedBox()),
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
                                                              controllerIdPartida,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                          onChanged: (value) {
                                                            parametroIdPartida =
                                                                value
                                                                    .toString();
                                                            getPartidasBy__();
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
                                                            getPartidasBy__();
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
                                                              controllerReferencia,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                          onChanged: (value) {
                                                            parametroReferencia =
                                                                value
                                                                    .toString();
                                                            getPartidasBy__();
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
                                                              controllerImporte,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                          onChanged: (value) {
                                                            parametroImporte =
                                                                value
                                                                    .toString();
                                                            getPartidasBy__();
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
                                                              controllerMoneda,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                          onChanged: (value) {
                                                            parametroMoneda =
                                                                value
                                                                    .toString();
                                                            getPartidasBy__();
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
                                                const Expanded(
                                                    child: SizedBox()),
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
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: SingleChildScrollView(
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: listPartidas.length,
                                  itemBuilder: (context, index) {
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
                                                  child: Icon(
                                                    Icons
                                                        .check_box_outline_blank_outlined,
                                                    color:
                                                        globalUtility.secondary,
                                                    size: 30,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    listPartidas[index][0]
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    listPartidas[index][1]
                                                        .toString(),
                                                    textAlign: TextAlign.start,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    listPartidas[index][2]
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    listPartidas[index][3]
                                                        .toString(),
                                                    textAlign: TextAlign.end,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    listPartidas[index][4]
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    listPartidas[index][5]
                                                        .toString(),
                                                    textAlign: TextAlign.end,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    listPartidas[index][6]
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    listPartidas[index][7]
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    listPartidas[index][8]
                                                        .toString(),
                                                    textAlign: TextAlign.end,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    listPartidas[index][9]
                                                        .toString(),
                                                    textAlign: TextAlign.end,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
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
