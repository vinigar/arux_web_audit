// ignore_for_file: unused_local_variable, non_constant_identifier_names, prefer_const_constructors_in_immutables, prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:arux/helpers/globals.dart';
import 'package:arux/models/GET_Gestor_Partidas_QT.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class SupabaseTestRPC extends StatefulWidget {
  SupabaseTestRPC({Key? key}) : super(key: key);

  @override
  State<SupabaseTestRPC> createState() => _SupabaseTestRPCState();
}

class _SupabaseTestRPCState extends State<SupabaseTestRPC> {
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

        local_list.add(getGestorPartidasQTResponse.data[i].idPartidasPk);
        local_list.add(getGestorPartidasQTResponse.data[i].proveedor);
        local_list.add(getGestorPartidasQTResponse.data[i].referencia);
        local_list.add("\$ ${getGestorPartidasQTResponse.data[i].importe}");
        local_list.add(getGestorPartidasQTResponse.data[i].moneda);
        local_list.add("\$ ${getGestorPartidasQTResponse.data[i].importeUsd}");
        local_list.add(getGestorPartidasQTResponse.data[i].diasPago);
        local_list.add("${getGestorPartidasQTResponse.data[i].porcDpp} %");
        local_list.add("${getGestorPartidasQTResponse.data[i].cantDpp}");
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
        local_list.add("${getGestorPartidasQTResponse.data[i].cantDpp}");
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
        local_list.add("${getGestorPartidasQTResponse.data[i].cantDpp}");
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
        local_list.add("${getGestorPartidasQTResponse.data[i].cantDpp}");
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
        local_list.add("${getGestorPartidasQTResponse.data[i].cantDpp}");
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
        local_list.add("${getGestorPartidasQTResponse.data[i].cantDpp}");
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
        local_list.add("${getGestorPartidasQTResponse.data[i].cantDpp}");
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
          .rpc('get_gestor_partidas_by__', params: {
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
        local_list.add("${getGestorPartidasQTResponse.data[i].cantDpp}");
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
    return Stack(
      children: [
        SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 50,
                      width: 500,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SizedBox(
                            width: 430,
                            child: TextField(
                              controller: controller_busqueda,
                              showCursor: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Búsqueda',
                              ),
                              onChanged: (value) {
                                parametro_busqueda = value;
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
                                } else {
                                  GetPartidas();
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Material(
                      color: Colors.transparent,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: InkWell(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: Color(0XFF00C774),
                            ),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Filtrar',
                                ),
                                Icon(
                                  Icons.filter_alt_outlined,
                                  color: Color(0XFF082147),
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            popup_rise = true;
                          });
                        },
                      ),
                    ),
                    filtro_avanzado == true || filtro_simple == true
                        ? Material(
                            color: Colors.transparent,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: InkWell(
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: Color(0XFF00C774),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 10, 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'Eliminar Filtro',
                                      ),
                                      Icon(
                                        Icons.filter_alt_off_outlined,
                                        color: Color(0XFF082147),
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                filtro_simple = false;
                                filtro_avanzado = false;
                                orden = "id_partidas_pk";
                                asc = true;
                                parametro_busqueda = "";
                                parametro_idpartida = "";
                                parametro_proveedor = "";
                                parametro_referencia = "";
                                parametro_importe = "";
                                parametro_moneda = "";
                                selectedDDEnc = ["Registro SAP"];
                                selectedDDEnc_transf = [""];
                                selectedDDOpe = ["="];
                                parametro_filt = [""];
                                initState();
                              },
                            ),
                          )
                        : Text("")
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    height: filtro_simple == true ? 80 : 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Color(0XFF00C774),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      child: Text(
                                        "Registro SAP",
                                        textAlign: TextAlign.center,
                                        style:
                                            TextStyle(color: Color(0XFF082147)),
                                      ),
                                      onTap: () {
                                        filtro_avanzado = false;
                                        filtro_simple = true;
                                        setState(() {});
                                      },
                                    ),
                                    InkWell(
                                      child: Icon(
                                          orden == "id_partidas_pk"
                                              ? asc == true
                                                  ? Icons.arrow_drop_down
                                                  : Icons.arrow_drop_up
                                              : Icons.arrow_drop_down,
                                          color: orden == "id_partidas_pk"
                                              ? Color(0XFF00C774)
                                              : Color(0XFF082147)),
                                      onTap: () {
                                        if (orden != "id_partidas_pk") {
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      child: Text(
                                        "Proveedor",
                                        textAlign: TextAlign.center,
                                        style:
                                            TextStyle(color: Color(0XFF082147)),
                                      ),
                                      onTap: () {
                                        filtro_avanzado = false;
                                        filtro_simple = true;
                                        setState(() {});
                                      },
                                    ),
                                    InkWell(
                                      child: Icon(
                                          orden == "proveedor"
                                              ? asc == true
                                                  ? Icons.arrow_drop_down
                                                  : Icons.arrow_drop_up
                                              : Icons.arrow_drop_down,
                                          color: orden == "proveedor"
                                              ? Color(0XFF00C774)
                                              : Color(0XFF082147)),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      child: Text(
                                        "Referencia",
                                        textAlign: TextAlign.center,
                                        style:
                                            TextStyle(color: Color(0XFF082147)),
                                      ),
                                      onTap: () {
                                        filtro_avanzado = false;
                                        filtro_simple = true;
                                        setState(() {});
                                      },
                                    ),
                                    InkWell(
                                      child: Icon(
                                          orden == "referencia"
                                              ? asc == true
                                                  ? Icons.arrow_drop_down
                                                  : Icons.arrow_drop_up
                                              : Icons.arrow_drop_down,
                                          color: orden == "referencia"
                                              ? Color(0XFF00C774)
                                              : Color(0XFF082147)),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      child: Text(
                                        "Importe Factura",
                                        textAlign: TextAlign.center,
                                        style:
                                            TextStyle(color: Color(0XFF082147)),
                                      ),
                                      onTap: () {
                                        filtro_avanzado = false;
                                        filtro_simple = true;
                                        setState(() {});
                                      },
                                    ),
                                    InkWell(
                                      child: Icon(
                                          orden == "importe"
                                              ? asc == true
                                                  ? Icons.arrow_drop_down
                                                  : Icons.arrow_drop_up
                                              : Icons.arrow_drop_down,
                                          color: orden == "importe"
                                              ? Color(0XFF00C774)
                                              : Color(0XFF082147)),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      child: Text(
                                        "Moneda",
                                        textAlign: TextAlign.center,
                                        style:
                                            TextStyle(color: Color(0XFF082147)),
                                      ),
                                      onTap: () {
                                        filtro_avanzado = false;
                                        filtro_simple = true;
                                        setState(() {});
                                      },
                                    ),
                                    InkWell(
                                      child: Icon(
                                          orden == "moneda"
                                              ? asc == true
                                                  ? Icons.arrow_drop_down
                                                  : Icons.arrow_drop_up
                                              : Icons.arrow_drop_down,
                                          color: orden == "moneda"
                                              ? Color(0XFF00C774)
                                              : Color(0XFF082147)),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      child: Text(
                                        "Importe USD",
                                        textAlign: TextAlign.center,
                                        style:
                                            TextStyle(color: Color(0XFF082147)),
                                      ),
                                      onTap: () {
                                        filtro_avanzado = false;
                                        filtro_simple = true;
                                        setState(() {});
                                      },
                                    ),
                                    InkWell(
                                      child: Icon(
                                          orden == "importe"
                                              ? asc == true
                                                  ? Icons.arrow_drop_down
                                                  : Icons.arrow_drop_up
                                              : Icons.arrow_drop_down,
                                          color: orden == "importe"
                                              ? Color(0XFF00C774)
                                              : Color(0XFF082147)),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      child: Text(
                                        "Dias para Pago",
                                        textAlign: TextAlign.center,
                                        style:
                                            TextStyle(color: Color(0XFF082147)),
                                      ),
                                      onTap: () {
                                        filtro_avanzado = false;
                                        filtro_simple = true;
                                        setState(() {});
                                      },
                                    ),
                                    InkWell(
                                      child: Icon(
                                          orden == "dias_pago"
                                              ? asc == true
                                                  ? Icons.arrow_drop_down
                                                  : Icons.arrow_drop_up
                                              : Icons.arrow_drop_down,
                                          color: orden == "dias_pago"
                                              ? Color(0XFF00C774)
                                              : Color(0XFF082147)),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      child: Text(
                                        "%DPP",
                                        textAlign: TextAlign.center,
                                        style:
                                            TextStyle(color: Color(0XFF082147)),
                                      ),
                                      onTap: () {
                                        filtro_avanzado = false;
                                        filtro_simple = true;
                                        setState(() {});
                                      },
                                    ),
                                    InkWell(
                                      child: Icon(
                                          orden == "porc_dpp"
                                              ? asc == true
                                                  ? Icons.arrow_drop_down
                                                  : Icons.arrow_drop_up
                                              : Icons.arrow_drop_down,
                                          color: orden == "porc_dpp"
                                              ? Color(0XFF00C774)
                                              : Color(0XFF082147)),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      child: Text(
                                        "\$DPP",
                                        textAlign: TextAlign.center,
                                        style:
                                            TextStyle(color: Color(0XFF082147)),
                                      ),
                                      onTap: () {
                                        filtro_avanzado = false;
                                        filtro_simple = true;
                                        setState(() {});
                                      },
                                    ),
                                    InkWell(
                                      child: Icon(
                                          orden == "cant_dpp"
                                              ? asc == true
                                                  ? Icons.arrow_drop_down
                                                  : Icons.arrow_drop_up
                                              : Icons.arrow_drop_down,
                                          color: orden == "cant_dpp"
                                              ? Color(0XFF00C774)
                                              : Color(0XFF082147)),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      child: Text(
                                        "Pronto Pago",
                                        textAlign: TextAlign.center,
                                        style:
                                            TextStyle(color: Color(0XFF082147)),
                                      ),
                                      onTap: () {
                                        filtro_avanzado = false;
                                        filtro_simple = true;
                                        setState(() {});
                                      },
                                    ),
                                    InkWell(
                                      child: Icon(
                                          orden == "pronto_pago"
                                              ? asc == true
                                                  ? Icons.arrow_drop_down
                                                  : Icons.arrow_drop_up
                                              : Icons.arrow_drop_down,
                                          color: orden == "pronto_pago"
                                              ? Color(0XFF00C774)
                                              : Color(0XFF082147)),
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
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          height: 30,
                                          width: 85,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Color(0XFF00C774),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 9,
                                              horizontal: 5,
                                            ),
                                            child: TextField(
                                              controller: controller_idpartida,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none),
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
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          height: 30,
                                          width: 85,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Color(0XFF00C774),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 9,
                                              horizontal: 5,
                                            ),
                                            child: TextField(
                                              controller: controller_proveedor,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none),
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
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          height: 30,
                                          width: 85,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Color(0XFF00C774),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 9,
                                              horizontal: 5,
                                            ),
                                            child: TextField(
                                              controller: controller_referencia,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none),
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
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          height: 30,
                                          width: 85,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Color(0XFF00C774),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 9,
                                              horizontal: 5,
                                            ),
                                            child: TextField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: controller_importe,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none),
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
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          height: 30,
                                          width: 85,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Color(0XFF00C774),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 9,
                                              horizontal: 5,
                                            ),
                                            child: TextField(
                                              keyboardType: TextInputType.text,
                                              controller: controller_moneda,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none),
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
                                    Expanded(child: SizedBox()),
                                    Expanded(child: SizedBox()),
                                    Expanded(child: SizedBox()),
                                    Expanded(child: SizedBox()),
                                    Expanded(child: SizedBox()),
                                  ],
                                )
                              : SizedBox(
                                  width: 0,
                                  height: 0,
                                )
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 500,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10)),
                  child: list_partidas.isEmpty
                      ? Text("")
                      : ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: list_partidas.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: Text(
                                      list_partidas[index][0].toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      list_partidas[index][1].toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      list_partidas[index][2].toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      list_partidas[index][3].toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      list_partidas[index][4].toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      list_partidas[index][5].toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      list_partidas[index][6].toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      list_partidas[index][7].toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      list_partidas[index][8].toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      list_partidas[index][9].toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
        popup_rise
            ? Stack(
                children: [
                  InkWell(
                    child: Expanded(
                      child: Container(
                        color: Color.fromARGB(172, 29, 29, 29),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        popup_rise = false;
                      });
                    },
                  ),
                  Center(
                    child: Container(
                      height: 500,
                      width: 500,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 200,
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
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(item),
                                            ))
                                        .toList(),
                                    onChanged: (item) =>
                                        setState(() => selectedDDEnc[0] = item),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 50,
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: selectedDDOpe[0],
                                    items: <String>[
                                      "=",
                                      "<",
                                      "<=",
                                      ">",
                                      ">=",
                                      "!=",
                                    ]
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(item),
                                            ))
                                        .toList(),
                                    onChanged: (item) =>
                                        setState(() => selectedDDOpe[0] = item),
                                  ),
                                ),
                                Container(
                                  width: 200,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color(0xFF66BB6A),
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: TextField(
                                      controller: controller_busqueda_filtro,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    onSurface: Color(0xFF66BB6A),
                                  ),
                                  icon: Icon(Icons.search_outlined),
                                  label: Text("Buscar"),
                                  onPressed: () {
                                    parametro_filt[0] =
                                        controller_busqueda_filtro.text;
                                    switch (selectedDDEnc[0]) {
                                      case "Registro SAP":
                                        selectedDDEnc_transf[0] =
                                            "id_partidas_pk";
                                        break;
                                      case "Proveedor":
                                        selectedDDEnc_transf[0] = "proveedor";
                                        break;
                                      case "Referencia":
                                        selectedDDEnc_transf[0] = "referencia";
                                        break;
                                      case "Importe":
                                        selectedDDEnc_transf[0] = "importe";
                                        break;
                                      case "Moneda":
                                        selectedDDEnc_transf[0] = "moneda";
                                        break;
                                      case "Importe USD":
                                        selectedDDEnc_transf[0] = "importe";
                                        break;
                                      case "Dias para Pago":
                                        selectedDDEnc_transf[0] = "dias_pago";
                                        break;
                                      case "%DPP":
                                        selectedDDEnc_transf[0] = "porc_dpp";
                                        break;
                                      case "\$DPP":
                                        selectedDDEnc_transf[0] = "cant_dpp";
                                        break;
                                      case "Pronto Pago":
                                        selectedDDEnc_transf[0] = "pronto_pago";
                                        break;
                                    }
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
                                    popup_rise = false;
                                    filtro_avanzado = true;
                                    setState(() {});
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Text("")
      ],
    );
  }
}
