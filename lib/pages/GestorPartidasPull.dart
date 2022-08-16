import 'dart:convert';

import 'package:arux/helpers/globalUtility.dart';
import 'package:arux/helpers/globals.dart';
import 'package:arux/models/GET_Gestor_Partidas_QT.dart';
import 'package:arux/pages/pages.dart';
import 'package:arux/pages/widgets/menuButton.dart';
import 'package:flutter/material.dart';

class GestorPartidasPull extends StatefulWidget {
  const GestorPartidasPull({Key? key}) : super(key: key);

  @override
  State<GestorPartidasPull> createState() => _GestorPartidasPullState();
}

class _GestorPartidasPullState extends State<GestorPartidasPull> {
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

  List<List<dynamic>> list_partidas = [];
  String orden = "id_partidas_pk";
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
  bool filtro_simple = false;

  ///////////////////////////////////////////////////////////////////////////////////

  @override
  void initState() {
    GetPartidas();
    super.initState();
  }

  Future<void> GetPartidas() async {
    try {
      dynamic response = await supabase
          .rpc('get_gestor_partidas_pull',
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

  Future<void> GetPartidasMenor() async {
    try {
      list_partidas = [];

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

      GetGestorPartidasQt getGestorPartidasQTResponse =
          getGestorPartidasQtFromMap(response);

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

  Future<void> GetPartidasMenorI() async {
    try {
      list_partidas = [];

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

      GetGestorPartidasQt getGestorPartidasQTResponse =
          getGestorPartidasQtFromMap(response);

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

  Future<void> GetPartidasIgual() async {
    try {
      list_partidas = [];

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

      GetGestorPartidasQt getGestorPartidasQTResponse =
          getGestorPartidasQtFromMap(response);

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

  Future<void> GetPartidasMayor() async {
    try {
      list_partidas = [];

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

      GetGestorPartidasQt getGestorPartidasQTResponse =
          getGestorPartidasQtFromMap(response);

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

  Future<void> GetPartidasMayorI() async {
    try {
      list_partidas = [];

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

      GetGestorPartidasQt getGestorPartidasQTResponse =
          getGestorPartidasQtFromMap(response);

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

  Future<void> GetPartidasDif() async {
    try {
      list_partidas = [];

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

      GetGestorPartidasQt getGestorPartidasQTResponse =
          getGestorPartidasQtFromMap(response);

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
          .rpc('get_gestor_partidas_pull_by__', params: {
            'idpartida': parametro_idpartida,
            'proveedor': parametro_proveedor,
            'referencia': parametro_referencia,
            'importe': parametro_importe,
            'moneda': parametro_moneda
          })
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
      body: Column(
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
                    padding: const EdgeInsetsDirectional.fromSTEB(50, 0, 50, 0),
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
                            if (Theme.of(context).brightness == Brightness.dark)
                              Image.asset(
                                'assets/images/AruxBlanco.png',
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                100, 20, 50, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Nuestro Trabajo',
                                  style: globalUtility.textoA(context),
                                ),
                                Text(
                                  'Reseñas',
                                  style: globalUtility.textoA(context),
                                ),
                                Text(
                                  'Proveedores',
                                  style: globalUtility.textoA(context),
                                ),
                                Text(
                                  'Conócenos',
                                  style: globalUtility.textoA(context),
                                ),
                              ],
                            ),
                          ),
                        ),
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
                                      style: globalUtility.textoIgual(context),
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
                                builder: (context) => GestorPartidasPush()),
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
                                    ReporteSeguimientoDeFacturas()),
                          );
                        },
                      ),
                      InkWell(
                        child: MenuButton(
                          icono: Icons.person_add_outlined,
                          color: globalUtility.primary,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Proveedores()),
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
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
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
                                    'Gestor de Facturas Pull NC - Pago',
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
                                                          switch (selectedDDOpe[
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
                                                          GetPartidas();
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
                                                          if (filtro_simple ==
                                                                  false ||
                                                              filtro_avanzado ==
                                                                  false) {
                                                            count_f++;
                                                            GetPartidas();
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
                                                              GetPartidas();
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
                                                                    GetPartidas();
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
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 5),
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
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
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
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Selección de pagos: ',
                                          style:
                                              globalUtility.textoIgual(context),
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
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 10, 0, 0),
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
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              10, 0, 10, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'TOTAL A PAGAR: ',
                                            style: globalUtility
                                                .textoIgual(context),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(10, 0, 0, 0),
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
                                                  if (filtro_simple == false) {
                                                    filtro_avanzado = false;
                                                    filtro_simple = true;
                                                  } else {
                                                    filtro_simple = false;
                                                    controller_idpartida
                                                        .clear();
                                                    parametro_idpartida = "";
                                                    controller_proveedor
                                                        .clear();
                                                    parametro_proveedor = "";
                                                    controller_referencia
                                                        .clear();
                                                    parametro_referencia = "";
                                                    controller_importe.clear();
                                                    parametro_importe = "";
                                                    controller_moneda.clear();
                                                    parametro_moneda = "";
                                                  }
                                                  GetPartidas();
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
                                                        : Icons.arrow_drop_down,
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
                                                  if (filtro_avanzado) {
                                                    switch (selectedDDOpe[0]) {
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
                                                    GetPartidasBy__();
                                                  } else {
                                                    GetPartidas();
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
                                                  if (filtro_simple == false) {
                                                    filtro_avanzado = false;
                                                    filtro_simple = true;
                                                  } else {
                                                    filtro_simple = false;
                                                    controller_idpartida
                                                        .clear();
                                                    parametro_idpartida = "";
                                                    controller_proveedor
                                                        .clear();
                                                    parametro_proveedor = "";
                                                    controller_referencia
                                                        .clear();
                                                    parametro_referencia = "";
                                                    controller_importe.clear();
                                                    parametro_importe = "";
                                                    controller_moneda.clear();
                                                    parametro_moneda = "";
                                                  }
                                                  GetPartidas();
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
                                                        : Icons.arrow_drop_down,
                                                    color: orden == "proveedor"
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
                                                    switch (selectedDDOpe[0]) {
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
                                                    GetPartidasBy__();
                                                  } else {
                                                    GetPartidas();
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
                                                  if (filtro_simple == false) {
                                                    filtro_avanzado = false;
                                                    filtro_simple = true;
                                                  } else {
                                                    filtro_simple = false;
                                                    controller_idpartida
                                                        .clear();
                                                    parametro_idpartida = "";
                                                    controller_proveedor
                                                        .clear();
                                                    parametro_proveedor = "";
                                                    controller_referencia
                                                        .clear();
                                                    parametro_referencia = "";
                                                    controller_importe.clear();
                                                    parametro_importe = "";
                                                    controller_moneda.clear();
                                                    parametro_moneda = "";
                                                  }
                                                  GetPartidas();
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
                                                        : Icons.arrow_drop_down,
                                                    color: orden == "referencia"
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
                                                  if (filtro_avanzado) {
                                                    switch (selectedDDOpe[0]) {
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
                                                    GetPartidasBy__();
                                                  } else {
                                                    GetPartidas();
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
                                                  if (filtro_simple == false) {
                                                    filtro_avanzado = false;
                                                    filtro_simple = true;
                                                  } else {
                                                    filtro_simple = false;
                                                    controller_idpartida
                                                        .clear();
                                                    parametro_idpartida = "";
                                                    controller_proveedor
                                                        .clear();
                                                    parametro_proveedor = "";
                                                    controller_referencia
                                                        .clear();
                                                    parametro_referencia = "";
                                                    controller_importe.clear();
                                                    parametro_importe = "";
                                                    controller_moneda.clear();
                                                    parametro_moneda = "";
                                                  }
                                                  GetPartidas();
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
                                                        : Icons.arrow_drop_down,
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
                                                  if (filtro_avanzado) {
                                                    switch (selectedDDOpe[0]) {
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
                                                    GetPartidasBy__();
                                                  } else {
                                                    GetPartidas();
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
                                                  if (filtro_simple == false) {
                                                    filtro_avanzado = false;
                                                    filtro_simple = true;
                                                  } else {
                                                    filtro_simple = false;
                                                    controller_idpartida
                                                        .clear();
                                                    parametro_idpartida = "";
                                                    controller_proveedor
                                                        .clear();
                                                    parametro_proveedor = "";
                                                    controller_referencia
                                                        .clear();
                                                    parametro_referencia = "";
                                                    controller_importe.clear();
                                                    parametro_importe = "";
                                                    controller_moneda.clear();
                                                    parametro_moneda = "";
                                                  }
                                                  GetPartidas();
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
                                                        : Icons.arrow_drop_down,
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
                                                    switch (selectedDDOpe[0]) {
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
                                                    GetPartidasBy__();
                                                  } else {
                                                    GetPartidas();
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
                                                  if (filtro_simple == false) {
                                                    filtro_avanzado = false;
                                                    filtro_simple = true;
                                                  } else {
                                                    filtro_simple = false;
                                                    controller_idpartida
                                                        .clear();
                                                    parametro_idpartida = "";
                                                    controller_proveedor
                                                        .clear();
                                                    parametro_proveedor = "";
                                                    controller_referencia
                                                        .clear();
                                                    parametro_referencia = "";
                                                    controller_importe.clear();
                                                    parametro_importe = "";
                                                    controller_moneda.clear();
                                                    parametro_moneda = "";
                                                  }
                                                  GetPartidas();
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
                                                        : Icons.arrow_drop_down,
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
                                                  if (filtro_avanzado) {
                                                    switch (selectedDDOpe[0]) {
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
                                                    GetPartidasBy__();
                                                  } else {
                                                    GetPartidas();
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
                                                  if (filtro_simple == false) {
                                                    filtro_avanzado = false;
                                                    filtro_simple = true;
                                                  } else {
                                                    filtro_simple = false;
                                                    controller_idpartida
                                                        .clear();
                                                    parametro_idpartida = "";
                                                    controller_proveedor
                                                        .clear();
                                                    parametro_proveedor = "";
                                                    controller_referencia
                                                        .clear();
                                                    parametro_referencia = "";
                                                    controller_importe.clear();
                                                    parametro_importe = "";
                                                    controller_moneda.clear();
                                                    parametro_moneda = "";
                                                  }
                                                  GetPartidas();
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
                                                        : Icons.arrow_drop_down,
                                                    color: orden == "dias_pago"
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
                                                  if (filtro_avanzado) {
                                                    switch (selectedDDOpe[0]) {
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
                                                    GetPartidasBy__();
                                                  } else {
                                                    GetPartidas();
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
                                                  if (filtro_simple == false) {
                                                    filtro_avanzado = false;
                                                    filtro_simple = true;
                                                  } else {
                                                    filtro_simple = false;
                                                    controller_idpartida
                                                        .clear();
                                                    parametro_idpartida = "";
                                                    controller_proveedor
                                                        .clear();
                                                    parametro_proveedor = "";
                                                    controller_referencia
                                                        .clear();
                                                    parametro_referencia = "";
                                                    controller_importe.clear();
                                                    parametro_importe = "";
                                                    controller_moneda.clear();
                                                    parametro_moneda = "";
                                                  }
                                                  GetPartidas();
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
                                                        : Icons.arrow_drop_down,
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
                                                  if (filtro_avanzado) {
                                                    switch (selectedDDOpe[0]) {
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
                                                    GetPartidasBy__();
                                                  } else {
                                                    GetPartidas();
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
                                                  if (filtro_simple == false) {
                                                    filtro_avanzado = false;
                                                    filtro_simple = true;
                                                  } else {
                                                    filtro_simple = false;
                                                    controller_idpartida
                                                        .clear();
                                                    parametro_idpartida = "";
                                                    controller_proveedor
                                                        .clear();
                                                    parametro_proveedor = "";
                                                    controller_referencia
                                                        .clear();
                                                    parametro_referencia = "";
                                                    controller_importe.clear();
                                                    parametro_importe = "";
                                                    controller_moneda.clear();
                                                    parametro_moneda = "";
                                                  }
                                                  GetPartidas();
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
                                                        : Icons.arrow_drop_down,
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
                                                  if (filtro_avanzado) {
                                                    switch (selectedDDOpe[0]) {
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
                                                    GetPartidasBy__();
                                                  } else {
                                                    GetPartidas();
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
                                                  if (filtro_simple == false) {
                                                    filtro_avanzado = false;
                                                    filtro_simple = true;
                                                  } else {
                                                    filtro_simple = false;
                                                    controller_idpartida
                                                        .clear();
                                                    parametro_idpartida = "";
                                                    controller_proveedor
                                                        .clear();
                                                    parametro_proveedor = "";
                                                    controller_referencia
                                                        .clear();
                                                    parametro_referencia = "";
                                                    controller_importe.clear();
                                                    parametro_importe = "";
                                                    controller_moneda.clear();
                                                    parametro_moneda = "";
                                                  }
                                                  GetPartidas();
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
                                                        : Icons.arrow_drop_down,
                                                    color:
                                                        orden == "pronto_pago"
                                                            ? globalUtility
                                                                .primaryBg
                                                            : globalUtility
                                                                .secondary),
                                                onTap: () {
                                                  if (orden != "pronto_pago") {
                                                    orden = "pronto_pago";
                                                    asc = true;
                                                  } else {
                                                    asc == true
                                                        ? asc = false
                                                        : asc = true;
                                                  }
                                                  if (filtro_avanzado) {
                                                    switch (selectedDDOpe[0]) {
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
                                                    GetPartidasBy__();
                                                  } else {
                                                    GetPartidas();
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
                                              const Expanded(child: SizedBox()),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Container(
                                                    height: 30,
                                                    width: 85,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                        color: globalUtility
                                                            .primaryBg,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 9,
                                                        horizontal: 5,
                                                      ),
                                                      child: TextField(
                                                        controller:
                                                            controller_idpartida,
                                                        decoration:
                                                            const InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none),
                                                        onChanged: (value) {
                                                          parametro_idpartida =
                                                              value.toString();
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
                                                      const EdgeInsets.all(5.0),
                                                  child: Container(
                                                    height: 30,
                                                    width: 85,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                        color: globalUtility
                                                            .primaryBg,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
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
                                                              value.toString();
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
                                                      const EdgeInsets.all(5.0),
                                                  child: Container(
                                                    height: 30,
                                                    width: 85,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                        color: globalUtility
                                                            .primaryBg,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 9,
                                                        horizontal: 5,
                                                      ),
                                                      child: TextField(
                                                        controller:
                                                            controller_referencia,
                                                        decoration:
                                                            const InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none),
                                                        onChanged: (value) {
                                                          parametro_referencia =
                                                              value.toString();
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
                                                      const EdgeInsets.all(5.0),
                                                  child: Container(
                                                    height: 30,
                                                    width: 85,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                        color: globalUtility
                                                            .primaryBg,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
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
                                                        decoration:
                                                            const InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none),
                                                        onChanged: (value) {
                                                          parametro_importe =
                                                              value.toString();
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
                                                      const EdgeInsets.all(5.0),
                                                  child: Container(
                                                    height: 30,
                                                    width: 85,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                        color: globalUtility
                                                            .primaryBg,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 9,
                                                        horizontal: 5,
                                                      ),
                                                      child: TextField(
                                                        keyboardType:
                                                            TextInputType.text,
                                                        controller:
                                                            controller_moneda,
                                                        decoration:
                                                            const InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none),
                                                        onChanged: (value) {
                                                          parametro_moneda =
                                                              value.toString();
                                                          GetPartidasBy__();
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Expanded(child: SizedBox()),
                                              const Expanded(child: SizedBox()),
                                              const Expanded(child: SizedBox()),
                                              const Expanded(child: SizedBox()),
                                              const Expanded(child: SizedBox()),
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
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          child: SizedBox(
                            height: filtro_simple == true ? 674 : 720,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: list_partidas.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Material(
                                    color: Colors.transparent,
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      height: 55,
                                      decoration: BoxDecoration(
                                        color: globalUtility.primaryBg,
                                        borderRadius: BorderRadius.circular(10),
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
                                                color: globalUtility.secondary,
                                                size: 30,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                list_partidas[index][0]
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: globalUtility
                                                    .contenidoTablas(context),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                list_partidas[index][1]
                                                    .toString(),
                                                textAlign: TextAlign.start,
                                                style: globalUtility
                                                    .contenidoTablas(context),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                list_partidas[index][2]
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: globalUtility
                                                    .contenidoTablas(context),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                list_partidas[index][3]
                                                    .toString(),
                                                textAlign: TextAlign.end,
                                                style: globalUtility
                                                    .contenidoTablas(context),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                list_partidas[index][4]
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: globalUtility
                                                    .contenidoTablas(context),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                list_partidas[index][5]
                                                    .toString(),
                                                textAlign: TextAlign.end,
                                                style: globalUtility
                                                    .contenidoTablas(context),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                list_partidas[index][6]
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: globalUtility
                                                    .contenidoTablas(context),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                list_partidas[index][7]
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: globalUtility
                                                    .contenidoTablas(context),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                list_partidas[index][8]
                                                    .toString(),
                                                textAlign: TextAlign.end,
                                                style: globalUtility
                                                    .contenidoTablas(context),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                list_partidas[index][9]
                                                    .toString(),
                                                textAlign: TextAlign.end,
                                                style: globalUtility
                                                    .contenidoTablas(context),
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
