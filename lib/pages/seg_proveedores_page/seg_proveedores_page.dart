import 'package:arux/helpers/globalUtility.dart';
import 'package:arux/models/models.dart';
import 'package:arux/pages/widgets/header/header.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart' as provider;
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:arux/pages/widgets/side_menu/side_menu.dart';
import 'package:arux/pages/widgets/top_menu/top_menu.dart';
import 'package:arux/providers/providers.dart';
import 'package:arux/theme/theme.dart';

class SeguimientoProveedoresPage extends StatefulWidget {
  const SeguimientoProveedoresPage({Key? key}) : super(key: key);

  @override
  State<SeguimientoProveedoresPage> createState() =>
      _SeguimientoProveedoresPageState();
}

class _SeguimientoProveedoresPageState
    extends State<SeguimientoProveedoresPage> {
  GlobalUtility globalUtility = GlobalUtility();
  TextEditingController searchController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final CrudProveedores proveedorProvider =
        provider.Provider.of<CrudProveedores>(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).primaryBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const TopMenuWidget(),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SideMenuWidget(),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 0, 20, 0),
                          child: Column(
                            children: [
                              const PageHeader(
                                headerName: 'Seguimiento de Proveedores',
                              ),
                              FutureBuilder<List<FacturaProveedor>?>(
                                  future: proveedorProvider
                                      .getSeguimientoProveedores(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: SpinKitCircle(
                                            color: AppTheme.of(context)
                                                .secondaryColor,
                                            size: 50,
                                          ),
                                        ),
                                      );
                                    }
                                    final List<FacturaProveedor> facturas =
                                        snapshot.data!;
                                    return Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        child: DataTable2(
                                          showCheckboxColumn: true,
                                          columnSpacing: 20,
                                          horizontalMargin: 10,
                                          minWidth: 100,
                                          columns: getColumns(),
                                          rows: List.generate(facturas.length,
                                              (index) {
                                            final factura = facturas[index];
                                            return DataRow2(
                                              cells: [
                                                DataCell(
                                                  Text(
                                                    factura.idProveedorPk
                                                        .toString(),
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                DataCell(
                                                  Text(
                                                    factura.sociedad,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                DataCell(
                                                  Text(
                                                    factura.noDocPartida,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                DataCell(
                                                  Text(
                                                    factura.importe.toString(),
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                DataCell(
                                                  Text(
                                                    factura.moneda,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                DataCell(
                                                  Text(
                                                    factura.descuentoPorcPp
                                                        .toString(),
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                DataCell(
                                                  Text(
                                                    factura.descuentoCantPp
                                                        .toString(),
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                DataCell(
                                                  Text(
                                                    DateFormat('dd-MM-yyyy')
                                                        .format(
                                                      factura.fechaDoc,
                                                    ),
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                DataCell(
                                                  Text(
                                                    factura.nombreEstatus,
                                                    style: globalUtility
                                                        .contenidoTablas(
                                                            context),
                                                  ),
                                                ),
                                                // DataCell(
                                                //   Row(
                                                //     mainAxisAlignment:
                                                //         MainAxisAlignment.end,
                                                //     children: [
                                                //       Padding(
                                                //         padding:
                                                //             const EdgeInsets
                                                //                     .symmetric(
                                                //                 horizontal: 10),
                                                //         child: InkWell(
                                                //           onTap: () {},
                                                //           child: const Icon(
                                                //             Icons.file_open,
                                                //             color: Color(
                                                //                 0xFF09A963),
                                                //             size: 30,
                                                //           ),
                                                //         ),
                                                //       ),
                                                //       Padding(
                                                //         padding:
                                                //             const EdgeInsets
                                                //                     .symmetric(
                                                //                 horizontal: 10),
                                                //         child: InkWell(
                                                //           onTap: () {},
                                                //           child: const Icon(
                                                //             Icons
                                                //                 .remove_red_eye,
                                                //             color: Color(
                                                //                 0xFF09A963),
                                                //             size: 30,
                                                //           ),
                                                //         ),
                                                //       ),
                                                //     ],
                                                //   ),
                                                // ),
                                              ],
                                            );
                                          }),
                                        ),
                                      ),
                                    );
                                  }),
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
        ),
      ),
    );
  }

  List<DataColumn2> getColumns() {
    return [
      DataColumn2(
        size: ColumnSize.S,
        label: Text(
          'ID',
          textAlign: TextAlign.center,
          style: globalUtility.encabezadoTablasOffAlt(context),
        ),
      ),
      DataColumn2(
        size: ColumnSize.M,
        label: Text(
          'Nombre',
          textAlign: TextAlign.center,
          style: globalUtility.encabezadoTablasOffAlt(context),
        ),
      ),
      DataColumn2(
        size: ColumnSize.M,
        label: Text(
          'Factura',
          textAlign: TextAlign.center,
          style: globalUtility.encabezadoTablasOffAlt(context),
        ),
      ),
      DataColumn2(
        numeric: true,
        size: ColumnSize.M,
        label: Text(
          'Importe',
          textAlign: TextAlign.center,
          style: globalUtility.encabezadoTablasOffAlt(context),
        ),
      ),
      DataColumn2(
        numeric: true,
        size: ColumnSize.S,
        label: Text(
          'Moneda',
          textAlign: TextAlign.center,
          style: globalUtility.encabezadoTablasOffAlt(context),
        ),
      ),
      DataColumn2(
        size: ColumnSize.M,
        numeric: true,
        label: Text(
          '%DPP',
          textAlign: TextAlign.center,
          style: globalUtility.encabezadoTablasOffAlt(context),
        ),
      ),
      DataColumn2(
        size: ColumnSize.M,
        numeric: true,
        label: Text(
          '\$DPP',
          textAlign: TextAlign.center,
          style: globalUtility.encabezadoTablasOffAlt(context),
        ),
      ),
      DataColumn2(
        size: ColumnSize.M,
        numeric: true,
        label: Text(
          'Fecha pago',
          textAlign: TextAlign.center,
          style: globalUtility.encabezadoTablasOffAlt(context),
        ),
      ),
      DataColumn2(
        size: ColumnSize.M,
        numeric: true,
        label: Text(
          'Estátus',
          textAlign: TextAlign.center,
          style: globalUtility.encabezadoTablasOffAlt(context),
        ),
      ),
      // DataColumn2(
      //   size: ColumnSize.M,
      //   numeric: true,
      //   label: Text(
      //     'Acciones',
      //     textAlign: TextAlign.center,
      //     style: globalUtility.encabezadoTablasOffAlt(context),
      //   ),
      // ),
    ];
  }
}
