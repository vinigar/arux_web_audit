// ignore_for_file: unused_local_variable, non_constant_identifier_names, prefer_const_constructors_in_immutables, prefer_const_constructors, avoid_print

import 'dart:convert';

import 'package:arux/helpers/globals.dart';
import 'package:arux/models/proveedor_from_partida_QT.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:arux/models/partidas_sapQT.dart';

class SupabaseTest extends StatefulWidget {
  SupabaseTest({Key? key}) : super(key: key);

  @override
  State<SupabaseTest> createState() => _SupabaseTestState();
}

class _SupabaseTestState extends State<SupabaseTest> {
  List<List<dynamic>> list_partidas_sap = [];
  String orden = "id_partida_pk";
  bool ascOdes = false;

  ///////////////////////////////////////////////////////////////////////////////////

  Future<void> GetPartidas() async {
    dynamic response = await supabase
        .from('partidas_sap')
        .select()
        .order('$orden', ascending: ascOdes)
        .execute();

    print("-----Error: ${response.error}");

    response = jsonEncode(response);

/*     print("-----Response: ");
    print(response.toString()); */

    PartidasSapQt partidasSAPQTResponse = partidasSapQtFromMap(response);

    list_partidas_sap = [];

    for (var i = 0; i < partidasSAPQTResponse.data.length; i++) {
      List<dynamic> local_list = [];

      dynamic response_foreign = await supabase
          .from('partidas_sap')
          .select('''
        proveedores: id_proveedor_fk ( sociedad )''')
          .eq('id_partidas_pk', partidasSAPQTResponse.data[i].idPartidasPk)
          .execute();

      print("-----Error: ${response_foreign.error}");

      response_foreign = jsonEncode(response_foreign);

      print("-----Response_Foranea: ");
      print(response_foreign.toString());

      ProveedorFromPartidaQt provFpartQTResponse =
          proveedorFromPartidaQtFromMap(response_foreign);

      local_list.add(partidasSAPQTResponse.data[i].idPartidasPk);
      local_list.add(provFpartQTResponse.data[0].proveedores.sociedad);
      local_list.add(partidasSAPQTResponse.data[i].referencia);
      local_list.add("\$ ${partidasSAPQTResponse.data[i].importe}");
      local_list.add(partidasSAPQTResponse.data[i].moneda);
      local_list.add("\$ ${partidasSAPQTResponse.data[i].importe}");
      local_list.add(partidasSAPQTResponse.data[i].diasPago);
      local_list.add("${partidasSAPQTResponse.data[i].descuentoPorcPp} %");
      local_list.add("${partidasSAPQTResponse.data[i].descuentoCantPp}");
      local_list.add("\$ ${partidasSAPQTResponse.data[i].prontoPago}");

      list_partidas_sap.add(local_list);

      //print("Indice $i : ${list_partidas_sap[i]}");
      //print("Indice $i : ${list_partidas_sap[i][1]}");
      //print("Indice $i : ${list_partidas_sap[i].length}");
    }

    //print("Listas : ${list_partidas_sap.length}");

    setState(() {});
  }

  ///////////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.green[400],
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: InkWell(
                            child: Text(
                              "Registro SAP",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              orden = "id_partidas_pk";
                              ascOdes == true
                                  ? ascOdes = false
                                  : ascOdes = true;
                              GetPartidas();
                            },
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Text(
                              "Proveedor",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              orden = "id_proveedor_fk";
                              ascOdes == true
                                  ? ascOdes = false
                                  : ascOdes = true;
                              GetPartidas();
                            },
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Text(
                              "Referencia",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              orden = "referencia";
                              ascOdes == true
                                  ? ascOdes = false
                                  : ascOdes = true;
                              GetPartidas();
                            },
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Text(
                              "Importe Factura",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              orden = "importe";
                              ascOdes == true
                                  ? ascOdes = false
                                  : ascOdes = true;
                              GetPartidas();
                            },
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Text(
                              "Moneda",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              orden = "moneda";
                              ascOdes == true
                                  ? ascOdes = false
                                  : ascOdes = true;
                              GetPartidas();
                            },
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Text(
                              "Importe USD",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              orden = "importe";
                              ascOdes == true
                                  ? ascOdes = false
                                  : ascOdes = true;
                              GetPartidas();
                            },
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Text(
                              "Dias para Pago",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              orden = "dias_pago";
                              ascOdes == true
                                  ? ascOdes = false
                                  : ascOdes = true;
                              GetPartidas();
                            },
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Text(
                              "%DPP",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              orden = "descuento_porc_pp";
                              ascOdes == true
                                  ? ascOdes = false
                                  : ascOdes = true;
                              GetPartidas();
                            },
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Text(
                              "\$DPP",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              orden = "descuento_cant_pp";
                              ascOdes == true
                                  ? ascOdes = false
                                  : ascOdes = true;
                              GetPartidas();
                            },
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Text(
                              "Pronto Pago",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              orden = "pronto_pago";
                              ascOdes == true
                                  ? ascOdes = false
                                  : ascOdes = true;
                              GetPartidas();
                            },
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)),
                child: list_partidas_sap.isEmpty
                    ? Text("")
                    : ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: list_partidas_sap.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Text(
                                    list_partidas_sap[index][0].toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    list_partidas_sap[index][1].toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    list_partidas_sap[index][2].toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    list_partidas_sap[index][3].toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    list_partidas_sap[index][4].toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    list_partidas_sap[index][5].toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    list_partidas_sap[index][6].toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    list_partidas_sap[index][7].toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    list_partidas_sap[index][8].toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    list_partidas_sap[index][9].toString(),
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
    );
  }
}
