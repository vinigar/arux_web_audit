import 'dart:convert';

import 'package:arux/helpers/globalUtility.dart';
import 'package:arux/helpers/globals.dart';
import 'package:arux/models/GET_Gestor_Partidas_QT.dart';
import 'package:arux/models/GET_Proveedores_QT.dart';
import 'package:arux/models/GET_Sociedades_By_ID_Proveedor.dart';
import 'package:arux/models/Get_Pagos_QT.dart';
import 'package:arux/pages/widgets/side_menu/side_menu.dart';
import 'package:arux/pages/widgets/side_menu/widgets/menu_button.dart';
import 'package:arux/pages/widgets/top_menu/top_menu.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../functions/date_format.dart';
import '../functions/money_format.dart';

class Pagos extends StatefulWidget {
  const Pagos({Key? key}) : super(key: key);

  @override
  State<Pagos> createState() => _PagosState();
}

class _PagosState extends State<Pagos> {
  GlobalUtility globalUtility = GlobalUtility();

  final controller_busqueda = TextEditingController();
  String parametro_busqueda = "";

  final controller_proveedor = TextEditingController();
  String parametro_proveedor = "";
  final controller_cuenta_sap = TextEditingController();
  String parametro_cuenta_sap = "";
  final controller_esquema = TextEditingController();
  String parametro_esquema = "";
  final controller_estado = TextEditingController();
  String parametro_estado = "";

  List<List<dynamic>> list_Pagos = [];
  String orden = "fecha_extraccion";
  String orden_2 = "sociedad";
  bool asc = true;
  bool asc_2 = true;
  final controller_count = TextEditingController();
  int count_i = 0;
  int count_f = 19;

  bool popup_rise = false;
  List<String?> selectedDDEnc = ["Registro SAP"];
  List<String?> selectedDDEnc_transf = [""];
  List<String?> selectedDDOpe = ["="];
  List<String?> parametro_filt = [""];
  final controller_busqueda_filtro = TextEditingController();

  bool filtro_avanzado = false;
  bool filtro_simple = false;

  ///////////////////////////////////////////////////////////////////////////////////

  @override
  void initState() {
    GetPagos();
    super.initState();
  }

  Future<void> GetPagos() async {
    try {
      dynamic response = await supabase
          .rpc('get_pagos', params: {'busqueda': parametro_busqueda})
          .order(orden, ascending: asc)
          .execute();

      print("-----Error: ${response.error}");

      response = jsonEncode(response);

      // print("-----Parametro de Busqueda: $parametro_busqueda");
      print("-----Response: ");
      print(response.toString());

      GetPagosQt getPagosQTResponse = getPagosQtFromMap(response);

      list_Pagos = [];

      for (var i = 0; i < getPagosQTResponse.data.length; i++) {
        List<dynamic> local_list = [];

        local_list.add(dateFormat(getPagosQTResponse.data[i].fechaExtraccion));
        local_list.add(getPagosQTResponse.data[i].moneda);
        local_list.add(getPagosQTResponse.data[i].esquema);
        local_list.add(getPagosQTResponse.data[i].estatus);
        local_list.add(getPagosQTResponse.data[i].acreedor);
        local_list.add(getPagosQTResponse.data[i].proveedor);
        local_list.add(getPagosQTResponse.data[i].idPartida);
        local_list.add(getPagosQTResponse.data[i].noDocPartida);
        local_list.add(getPagosQTResponse.data[i].referenciaPartida);
        local_list.add(getPagosQTResponse.data[i].importePartida);
        local_list.add(getPagosQTResponse.data[i].idNc);
        local_list.add(getPagosQTResponse.data[i].noDocNc);
        local_list.add(getPagosQTResponse.data[i].referenciaNc);
        local_list.add(getPagosQTResponse.data[i].descuentoProveedor);
        local_list.add(getPagosQTResponse.data[i].dpp);
        local_list.add(getPagosQTResponse.data[i].total);
        list_Pagos.add(local_list);
      }

      //print("Listas : ${list_Pagos.length}");

    } catch (e) {
      print(e);
    }

    setState(() {});
  }

  Future<void> GetPartidasMenor() async {
    try {
      list_Pagos = [];

      dynamic response = await supabase
          .rpc('get_gestor_partidas', params: {'busqueda': parametro_busqueda})
          .lt('${selectedDDEnc_transf[0]}', '${parametro_filt[0]}')
          .order(orden, ascending: asc)
          .execute();

      print("-----Error: ${response.error}");

      response = jsonEncode(response);

      print("-----Parametro de Busqueda: $parametro_busqueda");
      print("-----Response: ");
      print(response.toString());

      GetGestorPartidasQt getPagosQTResponse =
          getGestorPartidasQtFromMap(response);

      for (var i = 0; i < getPagosQTResponse.data.length; i++) {
        List<dynamic> local_list = [];

        local_list.add(getPagosQTResponse.data[i].idPartidasPk);
        local_list.add(getPagosQTResponse.data[i].proveedor);
        local_list.add(getPagosQTResponse.data[i].referencia);
        local_list.add("\$ ${getPagosQTResponse.data[i].importe}");
        local_list.add(getPagosQTResponse.data[i].moneda);
        local_list.add("\$ ${getPagosQTResponse.data[i].importeUsd}");
        local_list.add(getPagosQTResponse.data[i].diasPago);
        local_list.add("${getPagosQTResponse.data[i].porcDpp} %");
        local_list.add("${getPagosQTResponse.data[i].cantDpp}");
        local_list.add("\$ ${getPagosQTResponse.data[i].prontoPago}");

        list_Pagos.add(local_list);

        //print("Indice $i : ${list_Pagos[i]}");
        //print("Indice $i : ${list_Pagos[i][1]}");
        //print("Indice $i : ${list_Pagos[i].length}");
      }

      //print("Listas : ${list_Pagos.length}");

    } catch (e) {
      print(e);
    }

    setState(() {});
  }

  Future<void> GetPartidasMenorI() async {
    try {
      list_Pagos = [];
      dynamic response = await supabase
          .rpc('get_gestor_partidas', params: {'busqueda': parametro_busqueda})
          .lte('${selectedDDEnc_transf[0]}', '${parametro_filt[0]}')
          .order(orden, ascending: asc)
          .execute();

      print("-----Error: ${response.error}");

      response = jsonEncode(response);

      print("-----Parametro de Busqueda: $parametro_busqueda");
      print("-----Response: ");
      print(response.toString());

      GetGestorPartidasQt getPagosQTResponse =
          getGestorPartidasQtFromMap(response);

      for (var i = 0; i < getPagosQTResponse.data.length; i++) {
        List<dynamic> local_list = [];

        local_list.add(getPagosQTResponse.data[i].idPartidasPk);
        local_list.add(getPagosQTResponse.data[i].proveedor);
        local_list.add(getPagosQTResponse.data[i].referencia);
        local_list.add("\$ ${getPagosQTResponse.data[i].importe}");
        local_list.add(getPagosQTResponse.data[i].moneda);
        local_list.add("\$ ${getPagosQTResponse.data[i].importeUsd}");
        local_list.add(getPagosQTResponse.data[i].diasPago);
        local_list.add("${getPagosQTResponse.data[i].porcDpp} %");
        local_list.add("${getPagosQTResponse.data[i].cantDpp}");
        local_list.add("\$ ${getPagosQTResponse.data[i].prontoPago}");

        list_Pagos.add(local_list);

        //print("Indice $i : ${list_Pagos[i]}");
        //print("Indice $i : ${list_Pagos[i][1]}");
        //print("Indice $i : ${list_Pagos[i].length}");
      }

      //print("Listas : ${list_Pagos.length}");

    } catch (e) {
      print(e);
    }

    setState(() {});
  }

  Future<void> GetPartidasIgual() async {
    try {
      list_Pagos = [];

      dynamic response = await supabase
          .rpc('get_gestor_partidas', params: {'busqueda': parametro_busqueda})
          .match({'${selectedDDEnc_transf[0]}': '${parametro_filt[0]}'})
          .order(orden, ascending: asc)
          .execute();

      print("-----Error: ${response.error}");

      response = jsonEncode(response);

      print("-----Parametro de Busqueda: $parametro_busqueda");
      print("-----Response: ");
      print(response.toString());

      GetGestorPartidasQt getPagosQTResponse =
          getGestorPartidasQtFromMap(response);

      for (var i = 0; i < getPagosQTResponse.data.length; i++) {
        List<dynamic> local_list = [];

        local_list.add(getPagosQTResponse.data[i].idPartidasPk);
        local_list.add(getPagosQTResponse.data[i].proveedor);
        local_list.add(getPagosQTResponse.data[i].referencia);
        local_list.add("\$ ${getPagosQTResponse.data[i].importe}");
        local_list.add(getPagosQTResponse.data[i].moneda);
        local_list.add("\$ ${getPagosQTResponse.data[i].importeUsd}");
        local_list.add(getPagosQTResponse.data[i].diasPago);
        local_list.add("${getPagosQTResponse.data[i].porcDpp} %");
        local_list.add("${getPagosQTResponse.data[i].cantDpp}");
        local_list.add("\$ ${getPagosQTResponse.data[i].prontoPago}");

        list_Pagos.add(local_list);

        //print("Indice $i : ${list_Pagos[i]}");
        //print("Indice $i : ${list_Pagos[i][1]}");
        //print("Indice $i : ${list_Pagos[i].length}");
      }

      //print("Listas : ${list_Pagos.length}");

    } catch (e) {
      print(e);
    }

    setState(() {});
  }

  Future<void> GetPartidasMayor() async {
    try {
      list_Pagos = [];

      dynamic response = await supabase
          .rpc('get_gestor_partidas', params: {'busqueda': parametro_busqueda})
          .gt('${selectedDDEnc_transf[0]}', '${parametro_filt[0]}')
          .order(orden, ascending: asc)
          .execute();

      print("-----Error: ${response.error}");

      response = jsonEncode(response);

      print("-----Parametro de Busqueda: $parametro_busqueda");
      print("-----Response: ");
      print(response.toString());

      GetGestorPartidasQt getPagosQTResponse =
          getGestorPartidasQtFromMap(response);

      for (var i = 0; i < getPagosQTResponse.data.length; i++) {
        List<dynamic> local_list = [];

        local_list.add(getPagosQTResponse.data[i].idPartidasPk);
        local_list.add(getPagosQTResponse.data[i].proveedor);
        local_list.add(getPagosQTResponse.data[i].referencia);
        local_list.add("\$ ${getPagosQTResponse.data[i].importe}");
        local_list.add(getPagosQTResponse.data[i].moneda);
        local_list.add("\$ ${getPagosQTResponse.data[i].importeUsd}");
        local_list.add(getPagosQTResponse.data[i].diasPago);
        local_list.add("${getPagosQTResponse.data[i].porcDpp} %");
        local_list.add("${getPagosQTResponse.data[i].cantDpp}");
        local_list.add("\$ ${getPagosQTResponse.data[i].prontoPago}");

        list_Pagos.add(local_list);

        //print("Indice $i : ${list_Pagos[i]}");
        //print("Indice $i : ${list_Pagos[i][1]}");
        //print("Indice $i : ${list_Pagos[i].length}");
      }

      //print("Listas : ${list_Pagos.length}");

    } catch (e) {
      print(e);
    }

    setState(() {});
  }

  Future<void> GetPartidasMayorI() async {
    try {
      list_Pagos = [];

      dynamic response = await supabase
          .rpc('get_gestor_partidas', params: {'busqueda': parametro_busqueda})
          .gte('${selectedDDEnc_transf[0]}', '${parametro_filt[0]}')
          .order(orden, ascending: asc)
          .execute();

      print("-----Error: ${response.error}");

      response = jsonEncode(response);

      print("-----Parametro de Busqueda: $parametro_busqueda");
      print("-----Response: ");
      print(response.toString());

      GetGestorPartidasQt getPagosQTResponse =
          getGestorPartidasQtFromMap(response);

      for (var i = 0; i < getPagosQTResponse.data.length; i++) {
        List<dynamic> local_list = [];

        local_list.add(getPagosQTResponse.data[i].idPartidasPk);
        local_list.add(getPagosQTResponse.data[i].proveedor);
        local_list.add(getPagosQTResponse.data[i].referencia);
        local_list.add("\$ ${getPagosQTResponse.data[i].importe}");
        local_list.add(getPagosQTResponse.data[i].moneda);
        local_list.add("\$ ${getPagosQTResponse.data[i].importeUsd}");
        local_list.add(getPagosQTResponse.data[i].diasPago);
        local_list.add("${getPagosQTResponse.data[i].porcDpp} %");
        local_list.add("${getPagosQTResponse.data[i].cantDpp}");
        local_list.add("\$ ${getPagosQTResponse.data[i].prontoPago}");

        list_Pagos.add(local_list);

        //print("Indice $i : ${list_Pagos[i]}");
        //print("Indice $i : ${list_Pagos[i][1]}");
        //print("Indice $i : ${list_Pagos[i].length}");
      }

      //print("Listas : ${list_Pagos.length}");

    } catch (e) {
      print(e);
    }

    setState(() {});
  }

  Future<void> GetPartidasDif() async {
    try {
      list_Pagos = [];
      dynamic response = await supabase
          .rpc('get_gestor_partidas', params: {'busqueda': parametro_busqueda})
          .gt('${selectedDDEnc_transf[0]}', '${parametro_filt[0]}')
          .order(orden, ascending: asc)
          .execute();

      print("-----Error: ${response.error}");

      response = jsonEncode(response);

      print("-----Parametro de Busqueda: $parametro_busqueda");
      print("-----Response: ");
      print(response.toString());

      GetGestorPartidasQt getPagosQTResponse =
          getGestorPartidasQtFromMap(response);

      for (var i = 0; i < getPagosQTResponse.data.length; i++) {
        List<dynamic> local_list = [];

        local_list.add(getPagosQTResponse.data[i].idPartidasPk);
        local_list.add(getPagosQTResponse.data[i].proveedor);
        local_list.add(getPagosQTResponse.data[i].referencia);
        local_list.add("\$ ${getPagosQTResponse.data[i].importe}");
        local_list.add(getPagosQTResponse.data[i].moneda);
        local_list.add("\$ ${getPagosQTResponse.data[i].importeUsd}");
        local_list.add(getPagosQTResponse.data[i].diasPago);
        local_list.add("${getPagosQTResponse.data[i].porcDpp} %");
        local_list.add("${getPagosQTResponse.data[i].cantDpp}");
        local_list.add("\$ ${getPagosQTResponse.data[i].prontoPago}");

        list_Pagos.add(local_list);

        //print("Indice $i : ${list_Pagos[i]}");
        //print("Indice $i : ${list_Pagos[i][1]}");
        //print("Indice $i : ${list_Pagos[i].length}");
      }

      //print("Listas : ${list_Pagos.length}");

    } catch (e) {
      print(e);
    }

    setState(() {});
  }

  ///////////////////////////////////////////////////////////////////////////////////

  Future<void> GetPagosBy__() async {
    try {
      dynamic response = await supabase
          .rpc('get_Pagos_by__', params: {
            'proveedor': parametro_proveedor,
            'cuenta_sap': parametro_cuenta_sap,
            'esquema': parametro_esquema,
            'estado': parametro_estado
          })
          .order(orden, ascending: asc)
          .range(0, count_f)
          .execute();

      //print("-----Error: ${response.error}");

      response = jsonEncode(response);

      // print("-----Parametro de Busqueda: $parametro_busqueda");
      /* print("-----Response: ");
      print(response.toString()); */

      GetProveedoresQt getPagosQTResponse = getProveedoresQtFromMap(response);

      list_Pagos = [];

      for (var i = 0; i < getPagosQTResponse.data.length; i++) {
        List<dynamic> local_list = [];
        List<dynamic> local_list_2 = [];

        local_list.add(getPagosQTResponse.data[i].idProveedor);
        local_list.add(getPagosQTResponse.data[i].proveedor);
        local_list.add(getPagosQTResponse.data[i].cuentaSap);
        local_list.add(getPagosQTResponse.data[i].esquema);
        local_list.add(getPagosQTResponse.data[i].estado);

        dynamic response = await supabase
            .rpc('get_sociedades_by_id_proveedor',
                params: {'busqueda': getPagosQTResponse.data[i].idProveedor})
            .order(orden_2, ascending: asc_2)
            .execute();

        print("-----Error: ${response.error}");

        response = jsonEncode(response);

        /* print("-----Response: ");
        print(response.toString()); */

        GetSociedadesByIdProveedorQt getSociedadesByIdProveedorQt =
            getSociedadesByIdProveedorQtFromMap(response);

        for (var j = 0; j < getSociedadesByIdProveedorQt.data.length; j++) {
          List<dynamic> local_list_3 = [];

          local_list_3.add(getSociedadesByIdProveedorQt.data[j].idsociedad);
          local_list_3.add(getSociedadesByIdProveedorQt.data[j].categoria);
          local_list_3.add(getSociedadesByIdProveedorQt.data[j].cuenta);
          local_list_3.add(getSociedadesByIdProveedorQt.data[j].sociedad);
          local_list_3.add(getSociedadesByIdProveedorQt.data[j].telefono);
          local_list_3.add(getSociedadesByIdProveedorQt.data[j].contacto);
          local_list_3.add(getSociedadesByIdProveedorQt.data[j].diasPago);
          local_list_3.add(getSociedadesByIdProveedorQt.data[j].tipo);
          local_list_3.add(getSociedadesByIdProveedorQt.data[j].idproveedor);

          local_list_2.add(local_list_3);
        }

        if (local_list_2.isNotEmpty) {
          local_list.add(local_list_2);
        } else {
          local_list.add("Proveedor Sin Sociedad");
        }

        list_Pagos.add(local_list);

        //print("Indice $i : ${list_Pagos[i]}");
        //print("Longitud $i : ${list_Pagos[i].length}");
        //print("Proveedor $i : ${list_Pagos[i][1]}");
        //print("Sociedades $i : ${list_Pagos[i][5]}");
        //print("Sociedad 0 $i : ${list_Pagos[i][5][0]}");
        //print("idSociedad $i : ${list_Pagos[i][5][0][0]}");
      }

      //print("Listas : ${list_Pagos.length}");

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
                  /* Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MenuButton(
                          icon: Icons.home_outlined,
                          fillColor: globalUtility.primary,
                          onPressed: () {},
                        ),
                        MenuButton(
                          icon: Icons.notifications_outlined,
                          fillColor: globalUtility.primary,
                          onPressed: () {},
                        ),
                        MenuButton(
                          icon: Icons.subtitles_outlined,
                          fillColor: globalUtility.primary,
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/gestor-partidas-push',
                            );
                          },
                        ),
                        MenuButton(
                          icon: Icons.podcasts,
                          fillColor: globalUtility.primary,
                          onPressed: () {},
                        ),
                        MenuButton(
                          icon: Icons.receipt_long_sharp,
                          fillColor: globalUtility.primary,
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/pagos',
                            );
                          },
                        ),
                        MenuButton(
                          icon: Icons.bar_chart_rounded,
                          fillColor: globalUtility.primary,
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/reporte-seguimiento-facturas',
                            );
                          },
                        ),
                        MenuButton(
                            icon: Icons.person_add_outlined,
                            fillColor: globalUtility.primary,
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/Pagos',
                              );
                            }),
                        MenuButton(
                          icon: Icons.group_outlined,
                          fillColor: globalUtility.primary,
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/usuarios',
                            );
                          },
                        ),
                        MenuButton(
                          icon: Icons.power_settings_new_outlined,
                          fillColor: Color(0xFFFF0003),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ), */
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
                                                          controller_busqueda,
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
                                                        parametro_busqueda =
                                                            value;
                                                        if (filtro_avanzado) {
                                                          switch (
                                                              selectedDDOpe[
                                                                  0]) {
                                                            case "=":
                                                              GetPartidasIgual();
                                                              break;
                                                            case "<":
                                                              GetPartidasMenor();
                                                              break;
                                                            case "<=":
                                                              GetPartidasMenorI();
                                                              break;
                                                            case ">":
                                                              GetPartidasMayor();
                                                              break;
                                                            case ">=":
                                                              GetPartidasMayorI();
                                                              break;
                                                            case "!=":
                                                              GetPartidasDif();
                                                              break;
                                                          }
                                                        } else {
                                                          GetPagos();
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
                                                        if (filtro_simple ==
                                                                false ||
                                                            filtro_avanzado ==
                                                                false) {
                                                          count_f++;
                                                          GetPagos();
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
                                                            GetPagos();
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
                                                                  GetPagos();
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
                                    ],
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
                                                    "Fecha de Extración",
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
                                                      controller_proveedor
                                                          .clear();
                                                      parametro_proveedor = "";
                                                      controller_cuenta_sap
                                                          .clear();
                                                      parametro_cuenta_sap = "";
                                                      controller_esquema
                                                          .clear();
                                                      parametro_esquema = "";
                                                      controller_estado.clear();
                                                      parametro_estado = "";
                                                    }
                                                    GetPagos();
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
                                                          GetPartidasIgual();
                                                          break;
                                                        case "<":
                                                          GetPartidasMenor();
                                                          break;
                                                        case "<=":
                                                          GetPartidasMenorI();
                                                          break;
                                                        case ">":
                                                          GetPartidasMayor();
                                                          break;
                                                        case ">=":
                                                          GetPartidasMayorI();
                                                          break;
                                                        case "!=":
                                                          GetPartidasDif();
                                                          break;
                                                      }
                                                    } else if (filtro_simple) {
                                                      GetPagosBy__();
                                                    } else {
                                                      GetPagos();
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
                                                    style: parametro_cuenta_sap
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
                                                      controller_proveedor
                                                          .clear();
                                                      parametro_proveedor = "";
                                                      controller_cuenta_sap
                                                          .clear();
                                                      parametro_cuenta_sap = "";
                                                      controller_esquema
                                                          .clear();
                                                      parametro_esquema = "";
                                                      controller_estado.clear();
                                                      parametro_estado = "";
                                                    }
                                                    GetPagos();
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
                                                    if (filtro_avanzado) {
                                                      switch (
                                                          selectedDDOpe[0]) {
                                                        case "=":
                                                          GetPartidasIgual();
                                                          break;
                                                        case "<":
                                                          GetPartidasMenor();
                                                          break;
                                                        case "<=":
                                                          GetPartidasMenorI();
                                                          break;
                                                        case ">":
                                                          GetPartidasMayor();
                                                          break;
                                                        case ">=":
                                                          GetPartidasMayorI();
                                                          break;
                                                        case "!=":
                                                          GetPartidasDif();
                                                          break;
                                                      }
                                                    } else if (filtro_simple) {
                                                      GetPagosBy__();
                                                    } else {
                                                      GetPagos();
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
                                                    style: parametro_cuenta_sap
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
                                                      controller_proveedor
                                                          .clear();
                                                      parametro_proveedor = "";
                                                      controller_cuenta_sap
                                                          .clear();
                                                      parametro_cuenta_sap = "";
                                                      controller_esquema
                                                          .clear();
                                                      parametro_esquema = "";
                                                      controller_estado.clear();
                                                      parametro_estado = "";
                                                    }
                                                    GetPagos();
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
                                                    if (filtro_avanzado) {
                                                      switch (
                                                          selectedDDOpe[0]) {
                                                        case "=":
                                                          GetPartidasIgual();
                                                          break;
                                                        case "<":
                                                          GetPartidasMenor();
                                                          break;
                                                        case "<=":
                                                          GetPartidasMenorI();
                                                          break;
                                                        case ">":
                                                          GetPartidasMayor();
                                                          break;
                                                        case ">=":
                                                          GetPartidasMayorI();
                                                          break;
                                                        case "!=":
                                                          GetPartidasDif();
                                                          break;
                                                      }
                                                    } else if (filtro_simple) {
                                                      GetPagosBy__();
                                                    } else {
                                                      GetPagos();
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
                                                      controller_proveedor
                                                          .clear();
                                                      parametro_proveedor = "";
                                                      controller_cuenta_sap
                                                          .clear();
                                                      parametro_cuenta_sap = "";
                                                      controller_esquema
                                                          .clear();
                                                      parametro_esquema = "";
                                                      controller_estado.clear();
                                                      parametro_estado = "";
                                                    }
                                                    GetPagos();
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
                                                          GetPartidasIgual();
                                                          break;
                                                        case "<":
                                                          GetPartidasMenor();
                                                          break;
                                                        case "<=":
                                                          GetPartidasMenorI();
                                                          break;
                                                        case ">":
                                                          GetPartidasMayor();
                                                          break;
                                                        case ">=":
                                                          GetPartidasMayorI();
                                                          break;
                                                        case "!=":
                                                          GetPartidasDif();
                                                          break;
                                                      }
                                                    } else if (filtro_simple) {
                                                      GetPagosBy__();
                                                    } else {
                                                      GetPagos();
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
                                                    style: parametro_estado
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
                                                      controller_proveedor
                                                          .clear();
                                                      parametro_proveedor = "";
                                                      controller_cuenta_sap
                                                          .clear();
                                                      parametro_cuenta_sap = "";
                                                      controller_esquema
                                                          .clear();
                                                      parametro_esquema = "";
                                                      controller_estado.clear();
                                                      parametro_estado = "";
                                                    }
                                                    GetPagos();
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
                                                    if (filtro_avanzado) {
                                                      switch (
                                                          selectedDDOpe[0]) {
                                                        case "=":
                                                          GetPartidasIgual();
                                                          break;
                                                        case "<":
                                                          GetPartidasMenor();
                                                          break;
                                                        case "<=":
                                                          GetPartidasMenorI();
                                                          break;
                                                        case ">":
                                                          GetPartidasMayor();
                                                          break;
                                                        case ">=":
                                                          GetPartidasMayorI();
                                                          break;
                                                        case "!=":
                                                          GetPartidasDif();
                                                          break;
                                                      }
                                                    } else if (filtro_simple) {
                                                      GetPagosBy__();
                                                    } else {
                                                      GetPagos();
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
                                                            GetPagosBy__();
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
                                                              controller_cuenta_sap,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                          onChanged: (value) {
                                                            parametro_cuenta_sap =
                                                                value
                                                                    .toString();
                                                            GetPagosBy__();
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
                                                            GetPagosBy__();
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
                                                              controller_estado,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                          onChanged: (value) {
                                                            parametro_estado =
                                                                value
                                                                    .toString();
                                                            GetPagosBy__();
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
                                  itemCount: list_Pagos.length,
                                  itemBuilder: (context, index) {
                                    bool expanded = false;
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
                                                      child: list_Pagos[index]
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
                                                              list_Pagos[index]
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
                                                    child: list_Pagos[index]
                                                                [5] ==
                                                            null
                                                        ? Text(
                                                            '-',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: globalUtility
                                                                .contenidoTablas(
                                                                    context),
                                                          )
                                                        : Text(
                                                            list_Pagos[index][5]
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
                                                      child: list_Pagos[index]
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
                                                              list_Pagos[index]
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
                                                      child: list_Pagos[index]
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
                                                              list_Pagos[index]
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
                                                      child: list_Pagos[index]
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
                                                              list_Pagos[index]
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
                                                                  child: list_Pagos[index]
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
                                                                          list_Pagos[index][8]
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
                                                                  child: list_Pagos[index]
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
                                                                          list_Pagos[index][4]
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
                                                                  child: list_Pagos[index]
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
                                                                          list_Pagos[index][5]
                                                                              .toString(),
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style:
                                                                              globalUtility.contenidoTablas(context),
                                                                        ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: list_Pagos[index]
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
                                                                        list_Pagos[index][7]
                                                                            .toString(),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: globalUtility
                                                                            .contenidoTablas(context),
                                                                      ),
                                                              ),
                                                              Expanded(
                                                                child: Center(
                                                                  child: list_Pagos[index]
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
                                                                          '\$ ${moneyFormat(list_Pagos[index][9])}',
                                                                          textAlign:
                                                                              TextAlign.end,
                                                                          style:
                                                                              globalUtility.contenidoTablas(context),
                                                                        ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Center(
                                                                  child: list_Pagos[index]
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
                                                                          list_Pagos[index][1]
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
                                                                child: list_Pagos[index]
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
                                                                        list_Pagos[index][3]
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
                                                                  child: list_Pagos[index]
                                                                              [
                                                                              11] ==
                                                                          null
                                                                      ? Text(
                                                                          '-',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              globalUtility.contenidoTablas(context),
                                                                        )
                                                                      : Text(
                                                                          list_Pagos[index][11]
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
                                                                  child: list_Pagos[index]
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
                                                                          list_Pagos[index][4]
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
                                                                  child: list_Pagos[index]
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
                                                                          list_Pagos[index][5]
                                                                              .toString(),
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style:
                                                                              globalUtility.contenidoTablas(context),
                                                                        ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: list_Pagos[index]
                                                                            [
                                                                            12] ==
                                                                        null
                                                                    ? Text(
                                                                        '-',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: globalUtility
                                                                            .contenidoTablas(context),
                                                                      )
                                                                    : Text(
                                                                        list_Pagos[index][12]
                                                                            .toString(),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: globalUtility
                                                                            .contenidoTablas(context),
                                                                      ),
                                                              ),
                                                              Expanded(
                                                                child: Center(
                                                                  child: list_Pagos[index]
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
                                                                          '\$ ${moneyFormat(list_Pagos[index][14])}',
                                                                          textAlign:
                                                                              TextAlign.end,
                                                                          style:
                                                                              globalUtility.contenidoTablas(context),
                                                                        ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Center(
                                                                  child: list_Pagos[index]
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
                                                                          list_Pagos[index][1]
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
                                                                child: list_Pagos[index]
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
                                                                        list_Pagos[index][3]
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
                                                                  child: list_Pagos[index]
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
                                                                          '\$ ${moneyFormat(list_Pagos[index][15])}',
                                                                          textAlign:
                                                                              TextAlign.end,
                                                                          style:
                                                                              globalUtility.contenidoTablas(context),
                                                                        ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Center(
                                                                  child: list_Pagos[index]
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
                                                                          list_Pagos[index][1]
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
                                                                  child: list_Pagos[index]
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
                                                                          list_Pagos[index][3]
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
