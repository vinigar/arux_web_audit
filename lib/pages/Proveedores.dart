import 'dart:convert';

import 'package:arux/helpers/globalUtility.dart';
import 'package:arux/helpers/globals.dart';
import 'package:arux/models/GET_Gestor_Partidas_QT.dart';
import 'package:arux/models/GET_Proveedores_QT.dart';
import 'package:arux/models/GET_Sociedades_By_ID_Proveedor.dart';
import 'package:arux/pages/widgets/side_menu/side_menu.dart';
import 'package:arux/pages/widgets/side_menu/widgets/menu_button.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class Proveedores extends StatefulWidget {
  const Proveedores({Key? key}) : super(key: key);

  @override
  State<Proveedores> createState() => _ProveedoresState();
}

class _ProveedoresState extends State<Proveedores> {
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

  List<List<dynamic>> list_proveedores = [];
  String orden = "proveedor";
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
    GetProveedores();
    super.initState();
  }

  Future<void> GetProveedores() async {
    try {
      dynamic response = await supabase
          .rpc('get_proveedores', params: {'busqueda': parametro_busqueda})
          .order(orden, ascending: asc)
          .range(0, count_f)
          .execute();

      //print("-----Error: ${response.error}");

      response = jsonEncode(response);

      // print("-----Parametro de Busqueda: $parametro_busqueda");
      /* print("-----Response: ");
      print(response.toString()); */

      GetProveedoresQt getProveedoresQTResponse =
          getProveedoresQtFromMap(response);

      list_proveedores = [];

      for (var i = 0; i < getProveedoresQTResponse.data.length; i++) {
        List<dynamic> local_list = [];
        List<dynamic> local_list_2 = [];

        local_list.add(getProveedoresQTResponse.data[i].idProveedor);
        local_list.add(getProveedoresQTResponse.data[i].proveedor);
        local_list.add(getProveedoresQTResponse.data[i].cuentaSap);
        local_list.add(getProveedoresQTResponse.data[i].esquema);
        local_list.add(getProveedoresQTResponse.data[i].estado);

        dynamic response = await supabase
            .rpc('get_sociedades_by_id_proveedor', params: {
              'busqueda': getProveedoresQTResponse.data[i].idProveedor
            })
            .order(orden_2, ascending: asc_2)
            .execute();

        //print("-----Error: ${response.error}");

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

        list_proveedores.add(local_list);

        //print("Indice $i : ${list_proveedores[i]}");
        //print("Longitud $i : ${list_proveedores[i].length}");
        //print("Proveedor $i : ${list_proveedores[i][1]}");
        //print("Sociedades $i : ${list_proveedores[i][5]}");
        //print("Sociedad 0 $i : ${list_proveedores[i][5][0]}");
        //print("idSociedad $i : ${list_proveedores[i][5][0][0]}");
      }

      //print("Listas : ${list_proveedores.length}");

    } catch (e) {
      print(e);
    }

    setState(() {});
  }

  Future<void> GetPartidasMenor() async {
    try {
      list_proveedores = [];

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

      GetGestorPartidasQt getProveedoresQTResponse =
          getGestorPartidasQtFromMap(response);

      for (var i = 0; i < getProveedoresQTResponse.data.length; i++) {
        List<dynamic> local_list = [];

        local_list.add(getProveedoresQTResponse.data[i].idPartidasPk);
        local_list.add(getProveedoresQTResponse.data[i].proveedor);
        local_list.add(getProveedoresQTResponse.data[i].referencia);
        local_list.add("\$ ${getProveedoresQTResponse.data[i].importe}");
        local_list.add(getProveedoresQTResponse.data[i].moneda);
        local_list.add("\$ ${getProveedoresQTResponse.data[i].importeUsd}");
        local_list.add(getProveedoresQTResponse.data[i].diasPago);
        local_list.add("${getProveedoresQTResponse.data[i].porcDpp} %");
        local_list.add("${getProveedoresQTResponse.data[i].cantDpp}");
        local_list.add("\$ ${getProveedoresQTResponse.data[i].prontoPago}");

        list_proveedores.add(local_list);

        //print("Indice $i : ${list_proveedores[i]}");
        //print("Indice $i : ${list_proveedores[i][1]}");
        //print("Indice $i : ${list_proveedores[i].length}");
      }

      //print("Listas : ${list_proveedores.length}");

    } catch (e) {
      print(e);
    }

    setState(() {});
  }

  Future<void> GetPartidasMenorI() async {
    try {
      list_proveedores = [];
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

      GetGestorPartidasQt getProveedoresQTResponse =
          getGestorPartidasQtFromMap(response);

      for (var i = 0; i < getProveedoresQTResponse.data.length; i++) {
        List<dynamic> local_list = [];

        local_list.add(getProveedoresQTResponse.data[i].idPartidasPk);
        local_list.add(getProveedoresQTResponse.data[i].proveedor);
        local_list.add(getProveedoresQTResponse.data[i].referencia);
        local_list.add("\$ ${getProveedoresQTResponse.data[i].importe}");
        local_list.add(getProveedoresQTResponse.data[i].moneda);
        local_list.add("\$ ${getProveedoresQTResponse.data[i].importeUsd}");
        local_list.add(getProveedoresQTResponse.data[i].diasPago);
        local_list.add("${getProveedoresQTResponse.data[i].porcDpp} %");
        local_list.add("${getProveedoresQTResponse.data[i].cantDpp}");
        local_list.add("\$ ${getProveedoresQTResponse.data[i].prontoPago}");

        list_proveedores.add(local_list);

        //print("Indice $i : ${list_proveedores[i]}");
        //print("Indice $i : ${list_proveedores[i][1]}");
        //print("Indice $i : ${list_proveedores[i].length}");
      }

      //print("Listas : ${list_proveedores.length}");

    } catch (e) {
      print(e);
    }

    setState(() {});
  }

  Future<void> GetPartidasIgual() async {
    try {
      list_proveedores = [];

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

      GetGestorPartidasQt getProveedoresQTResponse =
          getGestorPartidasQtFromMap(response);

      for (var i = 0; i < getProveedoresQTResponse.data.length; i++) {
        List<dynamic> local_list = [];

        local_list.add(getProveedoresQTResponse.data[i].idPartidasPk);
        local_list.add(getProveedoresQTResponse.data[i].proveedor);
        local_list.add(getProveedoresQTResponse.data[i].referencia);
        local_list.add("\$ ${getProveedoresQTResponse.data[i].importe}");
        local_list.add(getProveedoresQTResponse.data[i].moneda);
        local_list.add("\$ ${getProveedoresQTResponse.data[i].importeUsd}");
        local_list.add(getProveedoresQTResponse.data[i].diasPago);
        local_list.add("${getProveedoresQTResponse.data[i].porcDpp} %");
        local_list.add("${getProveedoresQTResponse.data[i].cantDpp}");
        local_list.add("\$ ${getProveedoresQTResponse.data[i].prontoPago}");

        list_proveedores.add(local_list);

        //print("Indice $i : ${list_proveedores[i]}");
        //print("Indice $i : ${list_proveedores[i][1]}");
        //print("Indice $i : ${list_proveedores[i].length}");
      }

      //print("Listas : ${list_proveedores.length}");

    } catch (e) {
      print(e);
    }

    setState(() {});
  }

  Future<void> GetPartidasMayor() async {
    try {
      list_proveedores = [];

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

      GetGestorPartidasQt getProveedoresQTResponse =
          getGestorPartidasQtFromMap(response);

      for (var i = 0; i < getProveedoresQTResponse.data.length; i++) {
        List<dynamic> local_list = [];

        local_list.add(getProveedoresQTResponse.data[i].idPartidasPk);
        local_list.add(getProveedoresQTResponse.data[i].proveedor);
        local_list.add(getProveedoresQTResponse.data[i].referencia);
        local_list.add("\$ ${getProveedoresQTResponse.data[i].importe}");
        local_list.add(getProveedoresQTResponse.data[i].moneda);
        local_list.add("\$ ${getProveedoresQTResponse.data[i].importeUsd}");
        local_list.add(getProveedoresQTResponse.data[i].diasPago);
        local_list.add("${getProveedoresQTResponse.data[i].porcDpp} %");
        local_list.add("${getProveedoresQTResponse.data[i].cantDpp}");
        local_list.add("\$ ${getProveedoresQTResponse.data[i].prontoPago}");

        list_proveedores.add(local_list);

        //print("Indice $i : ${list_proveedores[i]}");
        //print("Indice $i : ${list_proveedores[i][1]}");
        //print("Indice $i : ${list_proveedores[i].length}");
      }

      //print("Listas : ${list_proveedores.length}");

    } catch (e) {
      print(e);
    }

    setState(() {});
  }

  Future<void> GetPartidasMayorI() async {
    try {
      list_proveedores = [];

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

      GetGestorPartidasQt getProveedoresQTResponse =
          getGestorPartidasQtFromMap(response);

      for (var i = 0; i < getProveedoresQTResponse.data.length; i++) {
        List<dynamic> local_list = [];

        local_list.add(getProveedoresQTResponse.data[i].idPartidasPk);
        local_list.add(getProveedoresQTResponse.data[i].proveedor);
        local_list.add(getProveedoresQTResponse.data[i].referencia);
        local_list.add("\$ ${getProveedoresQTResponse.data[i].importe}");
        local_list.add(getProveedoresQTResponse.data[i].moneda);
        local_list.add("\$ ${getProveedoresQTResponse.data[i].importeUsd}");
        local_list.add(getProveedoresQTResponse.data[i].diasPago);
        local_list.add("${getProveedoresQTResponse.data[i].porcDpp} %");
        local_list.add("${getProveedoresQTResponse.data[i].cantDpp}");
        local_list.add("\$ ${getProveedoresQTResponse.data[i].prontoPago}");

        list_proveedores.add(local_list);

        //print("Indice $i : ${list_proveedores[i]}");
        //print("Indice $i : ${list_proveedores[i][1]}");
        //print("Indice $i : ${list_proveedores[i].length}");
      }

      //print("Listas : ${list_proveedores.length}");

    } catch (e) {
      print(e);
    }

    setState(() {});
  }

  Future<void> GetPartidasDif() async {
    try {
      list_proveedores = [];
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

      GetGestorPartidasQt getProveedoresQTResponse =
          getGestorPartidasQtFromMap(response);

      for (var i = 0; i < getProveedoresQTResponse.data.length; i++) {
        List<dynamic> local_list = [];

        local_list.add(getProveedoresQTResponse.data[i].idPartidasPk);
        local_list.add(getProveedoresQTResponse.data[i].proveedor);
        local_list.add(getProveedoresQTResponse.data[i].referencia);
        local_list.add("\$ ${getProveedoresQTResponse.data[i].importe}");
        local_list.add(getProveedoresQTResponse.data[i].moneda);
        local_list.add("\$ ${getProveedoresQTResponse.data[i].importeUsd}");
        local_list.add(getProveedoresQTResponse.data[i].diasPago);
        local_list.add("${getProveedoresQTResponse.data[i].porcDpp} %");
        local_list.add("${getProveedoresQTResponse.data[i].cantDpp}");
        local_list.add("\$ ${getProveedoresQTResponse.data[i].prontoPago}");

        list_proveedores.add(local_list);

        //print("Indice $i : ${list_proveedores[i]}");
        //print("Indice $i : ${list_proveedores[i][1]}");
        //print("Indice $i : ${list_proveedores[i].length}");
      }

      //print("Listas : ${list_proveedores.length}");

    } catch (e) {
      print(e);
    }

    setState(() {});
  }

  ///////////////////////////////////////////////////////////////////////////////////

  Future<void> GetProveedoresBy__() async {
    try {
      dynamic response = await supabase
          .rpc('get_proveedores_by__', params: {
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

      GetProveedoresQt getProveedoresQTResponse =
          getProveedoresQtFromMap(response);

      list_proveedores = [];

      for (var i = 0; i < getProveedoresQTResponse.data.length; i++) {
        List<dynamic> local_list = [];
        List<dynamic> local_list_2 = [];

        local_list.add(getProveedoresQTResponse.data[i].idProveedor);
        local_list.add(getProveedoresQTResponse.data[i].proveedor);
        local_list.add(getProveedoresQTResponse.data[i].cuentaSap);
        local_list.add(getProveedoresQTResponse.data[i].esquema);
        local_list.add(getProveedoresQTResponse.data[i].estado);

        dynamic response = await supabase
            .rpc('get_sociedades_by_id_proveedor', params: {
              'busqueda': getProveedoresQTResponse.data[i].idProveedor
            })
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

        list_proveedores.add(local_list);

        //print("Indice $i : ${list_proveedores[i]}");
        //print("Longitud $i : ${list_proveedores[i].length}");
        //print("Proveedor $i : ${list_proveedores[i][1]}");
        //print("Sociedades $i : ${list_proveedores[i][5]}");
        //print("Sociedad 0 $i : ${list_proveedores[i][5][0]}");
        //print("idSociedad $i : ${list_proveedores[i][5][0][0]}");
      }

      //print("Listas : ${list_proveedores.length}");

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
                                        style: globalUtility.textoA(context),
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
                          onPressed: () {},
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
                                '/proveedores',
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
                  ),
                  //const SideMenuWidget(),
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
                                                            GetProveedores();
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
                                                            GetProveedores();
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
                                                              GetProveedores();
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
                                                                    GetProveedores();
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
                                                    GetProveedores();
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
                                                      GetProveedoresBy__();
                                                    } else {
                                                      GetProveedores();
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
                                                    GetProveedores();
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
                                                      GetProveedoresBy__();
                                                    } else {
                                                      GetProveedores();
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
                                                    GetProveedores();
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
                                                      GetProveedoresBy__();
                                                    } else {
                                                      GetProveedores();
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
                                                    GetProveedores();
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
                                                      GetProveedoresBy__();
                                                    } else {
                                                      GetProveedores();
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
                                                            GetProveedoresBy__();
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
                                                            GetProveedoresBy__();
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
                                                            GetProveedoresBy__();
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
                                                            GetProveedoresBy__();
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
                                  itemCount: list_proveedores.length,
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
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      list_proveedores[index][1]
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
                                                        list_proveedores[index]
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
                                                        list_proveedores[index]
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
                                                        list_proveedores[index]
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
                                                    list_proveedores[index][5]
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
                                                                    list_proveedores[index][5]
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
                                                                    list_proveedores[index][5]
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
                                                                  list_proveedores[index]
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
                                                                  list_proveedores[index]
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
                                                                  list_proveedores[index]
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
                                                                    list_proveedores[index][5]
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
                                                                    list_proveedores[index][5]
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
