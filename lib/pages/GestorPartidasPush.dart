import 'dart:convert';

import 'package:arux/helpers/globalUtility.dart';
import 'package:arux/helpers/globals.dart';
import 'package:arux/models/GET_Gestor_Partidas_QT.dart';
import 'package:arux/pages/widgets/side_menu/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

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
  int count_f = 19;

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
  List<String?> listDOpe = ["=", ">", ">=", "<", "<=", "!="];
  List<String?> listDDCond = ["Y", "Ó"];
  List<String?> selected_Enc = ["Registro SAP"];
  List<String?> selected_Ope = ["="];
  List<String?> selected_Val = [];
  List<String?> selected_Cond = [];
  bool filtro_avanzado = false;
  String query = "";

  ///////////////////////////////////////////////////////////////////////////////////

  @override
  void initState() {
    GetPartidasPush();
    super.initState();
  }

  Future<void> GetPartidasPush() async {
    try {
      dynamic response = await supabase
          .rpc('get_gestor_partidas_push',
              params: {'busqueda': parametro_busqueda})
          .order(orden, ascending: asc)
          .range(0, count_f)
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

        local_list.add(getGestorPartidasQTResponse.data[i].idPartidasPk);
        local_list.add(getGestorPartidasQTResponse.data[i].proveedor);
        local_list.add(getGestorPartidasQTResponse.data[i].referencia);
        local_list.add("\$ ${getGestorPartidasQTResponse.data[i].importe}");
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

  Future<void> GetPartidasBy__() async {
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
      print("-----Response: ");
      print(response.toString());

      GetGestorPartidasQt getGestorPartidasQTResponse =
          getGestorPartidasQtFromMap(response);

      list_partidas = [];

      for (var i = 0; i < getGestorPartidasQTResponse.data.length; i++) {
        List<dynamic> local_list = [];

        local_list.add(getGestorPartidasQTResponse.data[i].idPartidasPk);
        local_list.add(getGestorPartidasQTResponse.data[i].proveedor);
        local_list.add(getGestorPartidasQTResponse.data[i].referencia);
        local_list.add("\$ ${getGestorPartidasQTResponse.data[i].importe}");
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

  Future<void> GetPartidasBy__Filtro_Ava() async {
    try {
      dynamic response = await supabase
          .rpc('get_partidas_by_filtrado', params: {
            'query': query,
          })
          .order(orden, ascending: asc)
          .execute();

      print("-----Error: ${response.error}");

      response = jsonEncode(response);

      print("-----Response: ");
      print(response.toString());

      GetGestorPartidasQt getGestorPartidasQTResponse =
          getGestorPartidasQtFromMap(response);

      list_partidas = [];

      for (var i = 0; i < getGestorPartidasQTResponse.data.length; i++) {
        List<dynamic> local_list = [];

        local_list.add(getGestorPartidasQTResponse.data[i].idPartidasPk);
        local_list.add(getGestorPartidasQTResponse.data[i].proveedor);
        local_list.add(getGestorPartidasQTResponse.data[i].referencia);
        local_list.add("\$ ${getGestorPartidasQTResponse.data[i].importe}");
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
                SizedBox(
                  height: 85,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              50, 0, 50, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (Theme.of(context).brightness ==
                                      Brightness.light)
                                    Image.asset(
                                      'assets/images/AruxColor.png',
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  if (Theme.of(context).brightness ==
                                      Brightness.dark)
                                    Image.asset(
                                      'assets/images/AruxBlanco.png',
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                ],
                              ),
                              Expanded(child: SizedBox()),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 20, 0),
                                    child: Icon(
                                      Icons.power_off_outlined,
                                      color: globalUtility.primary,
                                      size: 24,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 15, 0),
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                        'https://picsum.photos/seed/607/600',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 0, 50, 0),
                                          child: Text(
                                            'Luis L.',
                                            style: globalUtility
                                                .textoIgual(context),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    50, 10, 50, 0),
                                child: Container(
                                  width: 100,
                                  height: 2,
                                  decoration: BoxDecoration(
                                    color: globalUtility.secondaryBg,
                                    border: Border.all(
                                      color: const Color(0xFFB7B7B7),
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
<<<<<<< HEAD
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MenuButton(
                              icono: Icons.home_outlined,
                              color: globalUtility.primary,
                            ),
                            MenuButton(
                              icono: Icons.notifications_outlined,
                              color: globalUtility.primary,
                            ),
                            InkWell(
                              child: MenuButton(
                                icono: Icons.subtitles_outlined,
                                color: globalUtility.primary,
                              ),
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/gestor-partidas-pull',
                                );
                              },
                            ),
                            MenuButton(
                              icono: Icons.podcasts,
                              color: globalUtility.primary,
                            ),
                            MenuButton(
                              icono: Icons.receipt_long_sharp,
                              color: globalUtility.primary,
                            ),
                            InkWell(
                              child: MenuButton(
                                icono: Icons.bar_chart_rounded,
                                color: globalUtility.primary,
                              ),
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/reporte-seguimiento-facturas',
                                );
                              },
                            ),
                            InkWell(
                              child: MenuButton(
                                icono: Icons.person_add_outlined,
                                color: globalUtility.primary,
                              ),
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/proveedores',
                                );
                              },
                            ),
                            InkWell(
                              child: MenuButton(
                                icono: Icons.group_outlined,
                                color: globalUtility.primary,
                              ),
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/usuarios',
                                );
                              },
                            ),
                            const MenuButton(
                              icono: Icons.power_settings_new_outlined,
                              color: Color(0xFFFF0003),
                            ),
                          ],
                        ),
                      ),
=======
                      const SideMenuWidget(),
>>>>>>> bec96b887b7d907a7fbc5248c18ca8ab88325ca5
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 0, 20, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 30, 0, 0),
                                child: Row(
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
                                          'Gestor de Facturas\nPush NC - Pago',
                                          style: globalUtility
                                              .tituloPagina(context),
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
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 25, 0),
                                              child: Container(
                                                width: 45,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  color:
                                                      globalUtility.primaryBg,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color:
                                                        globalUtility.primary,
                                                    width: 2,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.grid_view,
                                                    color:
                                                        globalUtility.primary,
                                                    size: 28,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 25, 0),
                                              child: Container(
                                                width: 45,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  color:
                                                      globalUtility.primaryBg,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color:
                                                        globalUtility.primary,
                                                    width: 2,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.person_add_outlined,
                                                    color:
                                                        globalUtility.primary,
                                                    size: 28,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 15, 0),
                                              child: Container(
                                                width: 250,
                                                height: 51,
                                                decoration: BoxDecoration(
                                                  color:
                                                      globalUtility.primaryBg,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  border: Border.all(
                                                    color:
                                                        globalUtility.primary,
                                                    width: 1.5,
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              10, 0, 0, 0),
                                                      child: Icon(
                                                        Icons.search,
                                                        color: globalUtility
                                                            .primary,
                                                        size: 24,
                                                      ),
                                                    ),
                                                    Center(
                                                      child: SizedBox(
                                                        width: 200,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
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
                                                              hintText:
                                                                  'Buscar',
                                                              hintStyle:
                                                                  globalUtility
                                                                      .hinttxt(
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
                                                                .textoA(
                                                                    context),
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
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 15, 0),
                                              child: Container(
                                                width: 250,
                                                height: 51,
                                                decoration: BoxDecoration(
                                                  color:
                                                      globalUtility.primaryBg,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  border: Border.all(
                                                    color:
                                                        globalUtility.primary,
                                                    width: 1.5,
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
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
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            0),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            0),
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            30),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            0),
                                                                  ),
                                                                ),
                                                                child:
                                                                    const Icon(
                                                                  Icons
                                                                      .arrow_drop_up_sharp,
                                                                  color: Colors
                                                                      .white,
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
                                                                  color: count_f ==
                                                                          0
                                                                      ? globalUtility
                                                                          .secondary
                                                                      : globalUtility
                                                                          .primary,
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .only(
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            30),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            0),
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            0),
                                                                  ),
                                                                ),
                                                                child:
                                                                    const Icon(
                                                                  Icons
                                                                      .arrow_drop_down_sharp,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 18,
                                                                ),
                                                              ),
                                                              onTap: () {
                                                                if (filtro_simple ==
                                                                        false ||
                                                                    filtro_avanzado ==
                                                                        false) {
                                                                  if (count_f >=
                                                                      1) {
                                                                    count_f--;
                                                                    GetPartidasPush();
                                                                    setState(
                                                                        () {});
                                                                  }
                                                                }
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .only(
                                                                  start: 10),
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
                                                                  padding: const EdgeInsets
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
                                                                    decoration:
                                                                        const InputDecoration(
                                                                            border:
                                                                                InputBorder.none),
                                                                    onChanged:
                                                                        (value) {
                                                                      try {
                                                                        print(
                                                                            "---Valor: ${value.toString()}");
                                                                        if (value.isNotEmpty ||
                                                                            value !=
                                                                                "0") {
                                                                          count_f =
                                                                              int.parse(value.toString());
                                                                          count_f =
                                                                              count_f - 1;
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
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                                                              Icons
                                                                  .filter_alt_outlined,
                                                              color:
                                                                  globalUtility
                                                                      .primary)
                                                        ],
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      filtro_avanzado = true;
                                                      setState(() {});
                                                    }),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 20, 0, 5),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 10, 0),
                                      child: Text(
                                        'Fondo Disponible ',
                                        style:
                                            globalUtility.textoIgual(context),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 15, 0),
                                      child: Container(
                                        width: 200,
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
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(10, 0, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 0, 10, 0),
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
                                            value: listDDEnc[0],
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
                                                () => listDDEnc[0] = item),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
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
                                                              .fromSTEB(
                                                          10, 0, 0, 0),
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
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: 350,
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
                                                              .fromSTEB(
                                                          10, 0, 0, 0),
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
                                padding:
                                    const EdgeInsetsDirectional.only(top: 20),
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
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
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
                                                      .encabezadoTablasOff(
                                                          context),
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
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: parametro_idpartida
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
                                                          filtro_avanzado =
                                                              false;
                                                          filtro_simple = true;
                                                        } else {
                                                          filtro_simple = false;
                                                          controller_idpartida
                                                              .clear();
                                                          parametro_idpartida =
                                                              "";
                                                          controller_proveedor
                                                              .clear();
                                                          parametro_proveedor =
                                                              "";
                                                          controller_referencia
                                                              .clear();
                                                          parametro_referencia =
                                                              "";
                                                          controller_importe
                                                              .clear();
                                                          parametro_importe =
                                                              "";
                                                          controller_moneda
                                                              .clear();
                                                          parametro_moneda = "";
                                                        }
                                                        GetPartidasPush();
                                                        setState(() {});
                                                      },
                                                    ),
                                                    InkWell(
                                                      child: Icon(
                                                          orden ==
                                                                  "id_partidas_pk"
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
                                                          orden =
                                                              "id_partidas_pk";
                                                          asc = true;
                                                        } else {
                                                          asc == true
                                                              ? asc = false
                                                              : asc = true;
                                                        }
                                                        if (filtro_avanzado) {
                                                        } else if (filtro_simple) {
                                                          GetPartidasBy__();
                                                        } else {
                                                          GetPartidasPush();
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
                                                        textAlign:
                                                            TextAlign.center,
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
                                                          filtro_avanzado =
                                                              false;
                                                          filtro_simple = true;
                                                        } else {
                                                          filtro_simple = false;
                                                          controller_idpartida
                                                              .clear();
                                                          parametro_idpartida =
                                                              "";
                                                          controller_proveedor
                                                              .clear();
                                                          parametro_proveedor =
                                                              "";
                                                          controller_referencia
                                                              .clear();
                                                          parametro_referencia =
                                                              "";
                                                          controller_importe
                                                              .clear();
                                                          parametro_importe =
                                                              "";
                                                          controller_moneda
                                                              .clear();
                                                          parametro_moneda = "";
                                                        }
                                                        GetPartidasPush();
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
                                                          color: orden ==
                                                                  "proveedor"
                                                              ? globalUtility
                                                                  .primaryBg
                                                              : globalUtility
                                                                  .secondary),
                                                      onTap: () {
                                                        if (orden !=
                                                            "proveedor") {
                                                          orden = "proveedor";
                                                          asc = true;
                                                        } else {
                                                          asc == true
                                                              ? asc = false
                                                              : asc = true;
                                                        }
                                                        if (filtro_avanzado) {
                                                        } else if (filtro_simple) {
                                                          GetPartidasBy__();
                                                        } else {
                                                          GetPartidasPush();
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
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: parametro_referencia
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
                                                          filtro_avanzado =
                                                              false;
                                                          filtro_simple = true;
                                                        } else {
                                                          filtro_simple = false;
                                                          controller_idpartida
                                                              .clear();
                                                          parametro_idpartida =
                                                              "";
                                                          controller_proveedor
                                                              .clear();
                                                          parametro_proveedor =
                                                              "";
                                                          controller_referencia
                                                              .clear();
                                                          parametro_referencia =
                                                              "";
                                                          controller_importe
                                                              .clear();
                                                          parametro_importe =
                                                              "";
                                                          controller_moneda
                                                              .clear();
                                                          parametro_moneda = "";
                                                        }
                                                        GetPartidasPush();
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
                                                          color: orden ==
                                                                  "referencia"
                                                              ? globalUtility
                                                                  .primaryBg
                                                              : globalUtility
                                                                  .secondary),
                                                      onTap: () {
                                                        if (orden !=
                                                            "referencia") {
                                                          orden = "referencia";
                                                          asc = true;
                                                        } else {
                                                          asc == true
                                                              ? asc = false
                                                              : asc = true;
                                                        }
                                                        if (filtro_avanzado) {
                                                        } else if (filtro_simple) {
                                                          GetPartidasBy__();
                                                        } else {
                                                          GetPartidasPush();
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
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: parametro_importe
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
                                                          filtro_avanzado =
                                                              false;
                                                          filtro_simple = true;
                                                        } else {
                                                          filtro_simple = false;
                                                          controller_idpartida
                                                              .clear();
                                                          parametro_idpartida =
                                                              "";
                                                          controller_proveedor
                                                              .clear();
                                                          parametro_proveedor =
                                                              "";
                                                          controller_referencia
                                                              .clear();
                                                          parametro_referencia =
                                                              "";
                                                          controller_importe
                                                              .clear();
                                                          parametro_importe =
                                                              "";
                                                          controller_moneda
                                                              .clear();
                                                          parametro_moneda = "";
                                                        }
                                                        GetPartidasPush();
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
                                                          color: orden ==
                                                                  "importe"
                                                              ? globalUtility
                                                                  .primaryBg
                                                              : globalUtility
                                                                  .secondary),
                                                      onTap: () {
                                                        if (orden !=
                                                            "importe") {
                                                          orden = "importe";
                                                          asc = true;
                                                        } else {
                                                          asc == true
                                                              ? asc = false
                                                              : asc = true;
                                                        }
                                                        if (filtro_avanzado) {
                                                        } else if (filtro_simple) {
                                                          GetPartidasBy__();
                                                        } else {
                                                          GetPartidasPush();
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
                                                        textAlign:
                                                            TextAlign.center,
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
                                                          filtro_avanzado =
                                                              false;
                                                          filtro_simple = true;
                                                        } else {
                                                          filtro_simple = false;
                                                          controller_idpartida
                                                              .clear();
                                                          parametro_idpartida =
                                                              "";
                                                          controller_proveedor
                                                              .clear();
                                                          parametro_proveedor =
                                                              "";
                                                          controller_referencia
                                                              .clear();
                                                          parametro_referencia =
                                                              "";
                                                          controller_importe
                                                              .clear();
                                                          parametro_importe =
                                                              "";
                                                          controller_moneda
                                                              .clear();
                                                          parametro_moneda = "";
                                                        }
                                                        GetPartidasPush();
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
                                                          color: orden ==
                                                                  "moneda"
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
                                                        } else if (filtro_simple) {
                                                          GetPartidasBy__();
                                                        } else {
                                                          GetPartidasPush();
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
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: globalUtility
                                                            .encabezadoTablasOff(
                                                                context),
                                                      ),
                                                      onTap: () {
                                                        if (filtro_simple ==
                                                            false) {
                                                          filtro_avanzado =
                                                              false;
                                                          filtro_simple = true;
                                                        } else {
                                                          filtro_simple = false;
                                                          controller_idpartida
                                                              .clear();
                                                          parametro_idpartida =
                                                              "";
                                                          controller_proveedor
                                                              .clear();
                                                          parametro_proveedor =
                                                              "";
                                                          controller_referencia
                                                              .clear();
                                                          parametro_referencia =
                                                              "";
                                                          controller_importe
                                                              .clear();
                                                          parametro_importe =
                                                              "";
                                                          controller_moneda
                                                              .clear();
                                                          parametro_moneda = "";
                                                        }
                                                        GetPartidasPush();
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
                                                          color: orden ==
                                                                  "importe"
                                                              ? globalUtility
                                                                  .primaryBg
                                                              : globalUtility
                                                                  .secondary),
                                                      onTap: () {
                                                        if (orden !=
                                                            "importe") {
                                                          orden = "importe";
                                                          asc = true;
                                                        } else {
                                                          asc == true
                                                              ? asc = false
                                                              : asc = true;
                                                        }
                                                        if (filtro_avanzado) {
                                                        } else if (filtro_simple) {
                                                          GetPartidasBy__();
                                                        } else {
                                                          GetPartidasPush();
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
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: globalUtility
                                                            .encabezadoTablasOff(
                                                                context),
                                                      ),
                                                      onTap: () {
                                                        if (filtro_simple ==
                                                            false) {
                                                          filtro_avanzado =
                                                              false;
                                                          filtro_simple = true;
                                                        } else {
                                                          filtro_simple = false;
                                                          controller_idpartida
                                                              .clear();
                                                          parametro_idpartida =
                                                              "";
                                                          controller_proveedor
                                                              .clear();
                                                          parametro_proveedor =
                                                              "";
                                                          controller_referencia
                                                              .clear();
                                                          parametro_referencia =
                                                              "";
                                                          controller_importe
                                                              .clear();
                                                          parametro_importe =
                                                              "";
                                                          controller_moneda
                                                              .clear();
                                                          parametro_moneda = "";
                                                        }
                                                        GetPartidasPush();
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
                                                          color: orden ==
                                                                  "dias_pago"
                                                              ? globalUtility
                                                                  .primaryBg
                                                              : globalUtility
                                                                  .secondary),
                                                      onTap: () {
                                                        if (orden !=
                                                            "dias_pago") {
                                                          orden = "dias_pago";
                                                          asc = true;
                                                        } else {
                                                          asc == true
                                                              ? asc = false
                                                              : asc = true;
                                                        }
                                                        if (filtro_avanzado) {
                                                        } else if (filtro_simple) {
                                                          GetPartidasBy__();
                                                        } else {
                                                          GetPartidasPush();
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
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: globalUtility
                                                            .encabezadoTablasOff(
                                                                context),
                                                      ),
                                                      onTap: () {
                                                        if (filtro_simple ==
                                                            false) {
                                                          filtro_avanzado =
                                                              false;
                                                          filtro_simple = true;
                                                        } else {
                                                          filtro_simple = false;
                                                          controller_idpartida
                                                              .clear();
                                                          parametro_idpartida =
                                                              "";
                                                          controller_proveedor
                                                              .clear();
                                                          parametro_proveedor =
                                                              "";
                                                          controller_referencia
                                                              .clear();
                                                          parametro_referencia =
                                                              "";
                                                          controller_importe
                                                              .clear();
                                                          parametro_importe =
                                                              "";
                                                          controller_moneda
                                                              .clear();
                                                          parametro_moneda = "";
                                                        }
                                                        GetPartidasPush();
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
                                                          color: orden ==
                                                                  "porc_dpp"
                                                              ? globalUtility
                                                                  .primaryBg
                                                              : globalUtility
                                                                  .secondary),
                                                      onTap: () {
                                                        if (orden !=
                                                            "porc_dpp") {
                                                          orden = "porc_dpp";
                                                          asc = true;
                                                        } else {
                                                          asc == true
                                                              ? asc = false
                                                              : asc = true;
                                                        }
                                                        if (filtro_avanzado) {
                                                        } else if (filtro_simple) {
                                                          GetPartidasBy__();
                                                        } else {
                                                          GetPartidasPush();
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
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: globalUtility
                                                            .encabezadoTablasOff(
                                                                context),
                                                      ),
                                                      onTap: () {
                                                        if (filtro_simple ==
                                                            false) {
                                                          filtro_avanzado =
                                                              false;
                                                          filtro_simple = true;
                                                        } else {
                                                          filtro_simple = false;
                                                          controller_idpartida
                                                              .clear();
                                                          parametro_idpartida =
                                                              "";
                                                          controller_proveedor
                                                              .clear();
                                                          parametro_proveedor =
                                                              "";
                                                          controller_referencia
                                                              .clear();
                                                          parametro_referencia =
                                                              "";
                                                          controller_importe
                                                              .clear();
                                                          parametro_importe =
                                                              "";
                                                          controller_moneda
                                                              .clear();
                                                          parametro_moneda = "";
                                                        }
                                                        GetPartidasPush();
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
                                                          color: orden ==
                                                                  "cant_dpp"
                                                              ? globalUtility
                                                                  .primaryBg
                                                              : globalUtility
                                                                  .secondary),
                                                      onTap: () {
                                                        if (orden !=
                                                            "cant_dpp") {
                                                          orden = "cant_dpp";
                                                          asc = true;
                                                        } else {
                                                          asc == true
                                                              ? asc = false
                                                              : asc = true;
                                                        }
                                                        if (filtro_avanzado) {
                                                        } else if (filtro_simple) {
                                                          GetPartidasBy__();
                                                        } else {
                                                          GetPartidasPush();
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
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: globalUtility
                                                            .encabezadoTablasOff(
                                                                context),
                                                      ),
                                                      onTap: () {
                                                        if (filtro_simple ==
                                                            false) {
                                                          filtro_avanzado =
                                                              false;
                                                          filtro_simple = true;
                                                        } else {
                                                          filtro_simple = false;
                                                          controller_idpartida
                                                              .clear();
                                                          parametro_idpartida =
                                                              "";
                                                          controller_proveedor
                                                              .clear();
                                                          parametro_proveedor =
                                                              "";
                                                          controller_referencia
                                                              .clear();
                                                          parametro_referencia =
                                                              "";
                                                          controller_importe
                                                              .clear();
                                                          parametro_importe =
                                                              "";
                                                          controller_moneda
                                                              .clear();
                                                          parametro_moneda = "";
                                                        }
                                                        GetPartidasPush();
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
                                                          color: orden == "pronto_pago"
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
                                                        if (filtro_avanzado) {
                                                        } else if (filtro_simple) {
                                                          GetPartidasBy__();
                                                        } else {
                                                          GetPartidasPush();
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          filtro_simple == true
                                              ? Row(
                                                  children: [
                                                    const Expanded(
                                                        child: SizedBox()),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Container(
                                                          height: 30,
                                                          width: 85,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            border: Border.all(
                                                              color:
                                                                  globalUtility
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
                                                                  controller_idpartida,
                                                              decoration: const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                              onChanged:
                                                                  (value) {
                                                                parametro_idpartida =
                                                                    value
                                                                        .toString();
                                                                GetPartidasBy__();
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Container(
                                                          height: 30,
                                                          width: 85,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            border: Border.all(
                                                              color:
                                                                  globalUtility
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
                                                              decoration: const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                              onChanged:
                                                                  (value) {
                                                                parametro_proveedor =
                                                                    value
                                                                        .toString();
                                                                GetPartidasBy__();
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Container(
                                                          height: 30,
                                                          width: 85,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            border: Border.all(
                                                              color:
                                                                  globalUtility
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
                                                                  controller_referencia,
                                                              decoration: const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                              onChanged:
                                                                  (value) {
                                                                parametro_referencia =
                                                                    value
                                                                        .toString();
                                                                GetPartidasBy__();
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Container(
                                                          height: 30,
                                                          width: 85,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            border: Border.all(
                                                              color:
                                                                  globalUtility
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
                                                                  controller_importe,
                                                              decoration: const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                              onChanged:
                                                                  (value) {
                                                                parametro_importe =
                                                                    value
                                                                        .toString();
                                                                GetPartidasBy__();
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Container(
                                                          height: 30,
                                                          width: 85,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            border: Border.all(
                                                              color:
                                                                  globalUtility
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
                                                              decoration: const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                              onChanged:
                                                                  (value) {
                                                                parametro_moneda =
                                                                    value
                                                                        .toString();
                                                                GetPartidasBy__();
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
                                  padding: const EdgeInsetsDirectional.only(
                                      bottom: 20),
                                  child: SingleChildScrollView(
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: list_partidas.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 10, 0, 0),
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
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(5, 5, 5, 5),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Icon(
                                                        Icons
                                                            .check_box_outline_blank_outlined,
                                                        color: globalUtility
                                                            .secondary,
                                                        size: 30,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        list_partidas[index][0]
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: globalUtility
                                                            .contenidoTablas(
                                                                context),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        list_partidas[index][1]
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: globalUtility
                                                            .contenidoTablas(
                                                                context),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        list_partidas[index][2]
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: globalUtility
                                                            .contenidoTablas(
                                                                context),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        list_partidas[index][3]
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: globalUtility
                                                            .contenidoTablas(
                                                                context),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        list_partidas[index][4]
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: globalUtility
                                                            .contenidoTablas(
                                                                context),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        list_partidas[index][5]
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: globalUtility
                                                            .contenidoTablas(
                                                                context),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        list_partidas[index][6]
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: globalUtility
                                                            .contenidoTablas(
                                                                context),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        list_partidas[index][7]
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: globalUtility
                                                            .contenidoTablas(
                                                                context),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        list_partidas[index][8]
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: globalUtility
                                                            .contenidoTablas(
                                                                context),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        list_partidas[index][9]
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.end,
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
            filtro_avanzado
                ? Expanded(
                    child: Stack(
                      children: [
                        InkWell(
                          child: Container(
                            color: globalUtility.popubBgFade,
                          ),
                          onTap: () {
                            filtro_avanzado = false;
                            setState(() {});
                          },
                        ),
                        Center(
                          child: Container(
                            height: 600,
                            width: 600,
                            decoration: BoxDecoration(
                              color: globalUtility.primaryBg,
                              border: Border.all(
                                color: globalUtility.primary,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListView.builder(
                              itemCount: selected_Enc.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            width: 200,
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton<String>(
                                                  isExpanded: true,
                                                  value: selected_Enc[index],
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
                                                          DropdownMenuItem<
                                                              String>(
                                                            value: item,
                                                            child: Text(
                                                              item,
                                                              style: globalUtility
                                                                  .textoIgual(
                                                                      context),
                                                            ),
                                                          ))
                                                      .toList(),
                                                  onChanged: (item) => setState(
                                                      () =>
                                                          selected_Enc[index] =
                                                              item),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 80,
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton<String>(
                                                  isExpanded: true,
                                                  value: selected_Ope[index],
                                                  items: <String>[
                                                    "=",
                                                    ">",
                                                    ">=",
                                                    "<",
                                                    "<=",
                                                    "!="
                                                  ]
                                                      .map((item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                            value: item,
                                                            child: Text(
                                                              item,
                                                              style: globalUtility
                                                                  .textoIgual(
                                                                      context),
                                                            ),
                                                          ))
                                                      .toList(),
                                                  onChanged: (item) => setState(
                                                      () =>
                                                          selected_Ope[index] =
                                                              item),
                                                ),
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
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10,
                                              ),
                                              child: TextFormField(
                                                controller: controller_busqueda,
                                                autofocus: true,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  hintText: 'Parametro',
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
                                                  } else {
                                                    GetPartidasPush();
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            InkWell(
                                              child: Container(
                                                height: 40,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  color: globalUtility.primary,
                                                  border: Border.all(
                                                      color: globalUtility
                                                          .primary),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Y",
                                                    style: globalUtility
                                                        .encabezadoTablasOff(
                                                            context),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              child: Container(
                                                height: 40,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  color: globalUtility.primary,
                                                  border: Border.all(
                                                      color: globalUtility
                                                          .primary),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Ó",
                                                    style: globalUtility
                                                        .encabezadoTablasOff(
                                                            context),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
