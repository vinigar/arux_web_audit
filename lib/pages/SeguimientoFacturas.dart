import 'dart:convert';

import 'package:arux/helpers/globalUtility.dart';
import 'package:arux/helpers/globals.dart';
import 'package:arux/models/GET_Gestor_Partidas_QT.dart';
import 'package:arux/models/GET_Seguimiento_Facturas_QT.dart';
import 'package:arux/pages/pages.dart';
import 'package:arux/pages/widgets/menuButton.dart';
import 'package:flutter/material.dart';

class SeguimientoDeFacturas extends StatefulWidget {
  const SeguimientoDeFacturas({Key? key}) : super(key: key);

  @override
  State<SeguimientoDeFacturas> createState() => _SeguimientoDeFacturasState();
}

class _SeguimientoDeFacturasState extends State<SeguimientoDeFacturas> {
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
    GetFacturas();
    super.initState();
  }

  Future<void> GetFacturas() async {
    try {
      dynamic response = await supabase
          .rpc('get_seguimiento_factura',
              params: {'busqueda': parametro_busqueda})
          .order(orden, ascending: asc)
          .range(0, count_f)
          .execute();

      print("-----Error: ${response.error}");

      response = jsonEncode(response);

      //print("-----Parametro de Busqueda: $parametro_busqueda");
      /* print("-----Response: ");
      print(response.toString()); */

      GetSeguimientoFacturasQt getSeguimientoFacturasQt =
          getSeguimientoFacturasQtFromMap(response);

      list_facturas = [];

      for (var i = 0; i < getSeguimientoFacturasQt.data.length; i++) {
        List<dynamic> local_list = [];

        local_list.add(getSeguimientoFacturasQt.data[i].idddu);
        local_list.add(getSeguimientoFacturasQt.data[i].proveedor);
        local_list.add(getSeguimientoFacturasQt.data[i].factura);
        local_list.add(getSeguimientoFacturasQt.data[i].esquema);
        local_list.add(getSeguimientoFacturasQt.data[i].moneda);
        local_list.add(getSeguimientoFacturasQt.data[i].fechaDocumento);
        if (getSeguimientoFacturasQt.data[i].fechaInicio == null) {
          local_list.add("-");
        } else {
          local_list.add(getSeguimientoFacturasQt.data[i].fechaInicio);
        }
        if (getSeguimientoFacturasQt.data[i].fechaLimite == null) {
          local_list.add("-");
        } else {
          local_list.add(getSeguimientoFacturasQt.data[i].fechaLimite);
        }
        if (getSeguimientoFacturasQt.data[i].fechaPago == null) {
          local_list.add("-");
        } else {
          local_list.add(getSeguimientoFacturasQt.data[i].fechaPago);
        }

        local_list.add(getSeguimientoFacturasQt.data[i].estatus);

        list_facturas.add(local_list);

        //print("Indice $i : ${list_facturas[i]}");
        //print("Indice $i : ${list_facturas[i][1]}");
        //print("Indice $i : ${list_facturas[i].length}");
      }

      //print("Listas : ${list_facturas.length}");

    } catch (e) {
      print(e);
    }

    setState(() {});
  }

  ///////////////////////////////////////////////////////////////////////////////////

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
        List<dynamic> local_list = [];

        local_list.add(getSeguimientoFacturasQt.data[i].idPartidasPk);
        local_list.add(getSeguimientoFacturasQt.data[i].proveedor);
        local_list.add(getSeguimientoFacturasQt.data[i].referencia);
        local_list.add("\$ ${getSeguimientoFacturasQt.data[i].importe}");
        local_list.add(getSeguimientoFacturasQt.data[i].moneda);
        local_list.add("\$ ${getSeguimientoFacturasQt.data[i].importeUsd}");
        local_list.add(getSeguimientoFacturasQt.data[i].diasPago);
        local_list.add("${getSeguimientoFacturasQt.data[i].porcDpp} %");
        local_list.add("\$ ${getSeguimientoFacturasQt.data[i].cantDpp}");
        local_list.add("\$ ${getSeguimientoFacturasQt.data[i].prontoPago}");

        list_facturas.add(local_list);

        //print("Indice $i : ${list_facturas[i]}");
        //print("Indice $i : ${list_facturas[i][1]}");
        //print("Indice $i : ${list_facturas[i].length}");
      }

      //print("Listas : ${list_facturas.length}");

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
            SizedBox(
              height: 85,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(50, 0, 50, 0),
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 20, 0),
                                child: Icon(
                                  Icons.power_off_outlined,
                                  color: globalUtility.primary,
                                  size: 24,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
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
                                    alignment: const AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 50, 0),
                                      child: Text(
                                        'Luis L.',
                                        style:
                                            globalUtility.textoIgual(context),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const GestorPartidasPull()),
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ReporteSeguimientoDeFacturas()),
                              );
                            }),
                        InkWell(
                          child: MenuButton(
                            icono: Icons.person_add_outlined,
                            color: globalUtility.primary,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Proveedores()),
                            );
                          },
                        ),
                        MenuButton(
                          icono: Icons.group_outlined,
                          color: globalUtility.primary,
                        ),
                        const MenuButton(
                          icono: Icons.power_settings_new_outlined,
                          color: Color(0xFFFF0003),
                        ),
                      ],
                    ),
                  ),
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
                                      'Seguimiento de Facturas',
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
                                                Icons.grid_view,
                                                color: globalUtility.primary,
                                                size: 28,
                                              ),
                                            ),
                                          ),
                                        ),
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
                                                Icons.download_outlined,
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
                                                            controller_busqueda,
                                                        autofocus: true,
                                                        obscureText: false,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText: 'Buscar',
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
                                                            .textoA(context),
                                                        onChanged: (value) {
                                                          parametro_busqueda =
                                                              value;
                                                          if (filtro_avanzado) {
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
                                                            GetFacturas();
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
                                                  mainAxisSize:
                                                      MainAxisSize.min,
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
                                                              color:
                                                                  globalUtility
                                                                      .primary,
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            0),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        30),
                                                                topRight: Radius
                                                                    .circular(
                                                                        0),
                                                              ),
                                                            ),
                                                            child: const Icon(
                                                              Icons
                                                                  .arrow_drop_up_sharp,
                                                              color:
                                                                  Colors.white,
                                                              size: 18,
                                                            ),
                                                          ),
                                                          onTap: () {
                                                            if (filtro_simple ==
                                                                    false ||
                                                                filtro_avanzado ==
                                                                    false) {
                                                              count_f++;
                                                              GetFacturas();
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
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        30),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            0),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        0),
                                                              ),
                                                            ),
                                                            child: const Icon(
                                                              Icons
                                                                  .arrow_drop_down_sharp,
                                                              color:
                                                                  Colors.white,
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
                                                                GetFacturas();
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
                                                  mainAxisSize:
                                                      MainAxisSize.max,
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
                                                                    if (value
                                                                            .isNotEmpty ||
                                                                        value !=
                                                                            "0") {
                                                                      count_f =
                                                                          int.parse(
                                                                              value.toString());
                                                                      count_f =
                                                                          count_f -
                                                                              1;
                                                                      GetFacturas();
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
                                                        DropdownMenuItem<
                                                            String>(
                                                          value: item,
                                                          child: Text(item),
                                                        ))
                                                    .toList(),
                                                onChanged: (item) => setState(
                                                    () => selectedDDEnc[0] =
                                                        item),
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
                                                    GetFacturas();
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
                                                      GetFacturas();
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
                                                    GetFacturas();
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
                                                      GetFacturas();
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
                                                    GetFacturas();
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
                                                      GetFacturas();
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
                                                    GetFacturas();
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
                                                      GetFacturas();
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
                                                    GetFacturas();
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
                                                      GetFacturas();
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
                                                    GetFacturas();
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
                                                      GetFacturas();
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
                                                    GetFacturas();
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
                                                      GetFacturas();
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
                                                    GetFacturas();
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
                                                      GetFacturas();
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
                                                    GetFacturas();
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
                                                      GetFacturas();
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
                                                    GetFacturas();
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
                                                      GetFacturas();
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
                                                    list_facturas[index][0]
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    list_facturas[index][1]
                                                        .toString(),
                                                    textAlign: TextAlign.start,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    list_facturas[index][2]
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    list_facturas[index][3]
                                                        .toString(),
                                                    textAlign: TextAlign.end,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    list_facturas[index][4]
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    list_facturas[index][5]
                                                        .toString(),
                                                    textAlign: TextAlign.end,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    list_facturas[index][6]
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.circle,
                                                  color: list_facturas[index]
                                                                  [7] !=
                                                              "-" &&
                                                          list_facturas[index]
                                                                  [6] !=
                                                              "-"
                                                      ? Colors.green
                                                      : Colors.red,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    list_facturas[index][7]
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    list_facturas[index][8]
                                                        .toString(),
                                                    textAlign: TextAlign.end,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    list_facturas[index][9]
                                                        .toString(),
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
                                                      Icon(
                                                        Icons.description,
                                                        color: globalUtility
                                                            .secondary,
                                                        size: 30,
                                                      ),
                                                      Icon(
                                                        Icons.visibility,
                                                        color: globalUtility
                                                            .secondary,
                                                        size: 30,
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
