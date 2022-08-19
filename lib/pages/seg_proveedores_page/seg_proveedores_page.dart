import 'package:arux/models/models.dart';
import 'package:arux/pages/widgets/header/header.dart';
import 'package:arux/pages/widgets/table_column_name.dart';
import 'package:flutter/material.dart';
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
                              FutureBuilder(
                                  future: proveedorProvider
                                      .getSeguimientoProveedores(),
                                  builder: (context, snapshot) {
                                    return Container();
                                  }),
                              // Padding(
                              //   padding: const EdgeInsetsDirectional.fromSTEB(
                              //       0, 5, 0, 0),
                              //   child: Material(
                              //     color: Colors.transparent,
                              //     elevation: 10,
                              //     shape: const RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.only(
                              //         bottomLeft: Radius.circular(5),
                              //         bottomRight: Radius.circular(5),
                              //         topLeft: Radius.circular(10),
                              //         topRight: Radius.circular(10),
                              //       ),
                              //     ),
                              //     child: Container(
                              //       width: double.infinity,
                              //       decoration: const BoxDecoration(
                              //         color: Color(0xFF09A963),
                              //         borderRadius: BorderRadius.only(
                              //           bottomLeft: Radius.circular(5),
                              //           bottomRight: Radius.circular(5),
                              //           topLeft: Radius.circular(10),
                              //           topRight: Radius.circular(10),
                              //         ),
                              //       ),
                              //       child: Padding(
                              //         padding:
                              //             const EdgeInsetsDirectional.fromSTEB(
                              //                 0, 5, 0, 5),
                              //         child: Row(
                              //           mainAxisSize: MainAxisSize.max,
                              //           children: const [
                              //             Expanded(
                              //               child: TableColumnName(
                              //                 nombre: 'ID',
                              //               ),
                              //             ),
                              //             Expanded(
                              //               child: TableColumnName(
                              //                 nombre: 'Factura',
                              //               ),
                              //             ),
                              //             Expanded(
                              //               child: TableColumnName(
                              //                 nombre: 'Importe',
                              //               ),
                              //             ),
                              //             Expanded(
                              //               child: TableColumnName(
                              //                 nombre: 'Moneda',
                              //               ),
                              //             ),
                              //             Expanded(
                              //               child: TableColumnName(
                              //                 nombre: '%DPP',
                              //               ),
                              //             ),
                              //             Expanded(
                              //               child: TableColumnName(
                              //                 nombre: '\$DPP',
                              //               ),
                              //             ),
                              //             Expanded(
                              //               child: TableColumnName(
                              //                 nombre: 'Fecha pago',
                              //               ),
                              //             ),
                              //             Expanded(
                              //               child: TableColumnName(
                              //                 nombre: 'Estátus',
                              //               ),
                              //             ),
                              //             Expanded(
                              //               child: TableColumnName(
                              //                 nombre: 'Acciones',
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // Flexible(
                              //   child: Padding(
                              //     padding: const EdgeInsetsDirectional.fromSTEB(
                              //         0, 0, 0, 20),
                              //     child: FutureBuilder<List<Usuario>>(
                              //         future: usuarios.getUsuarios(),
                              //         builder: (context, snapshot) {
                              //           // Customize what your widget looks like when it's loading.
                              //           if (!snapshot.hasData) {
                              //             return Center(
                              //               child: SizedBox(
                              //                 width: 50,
                              //                 height: 50,
                              //                 child: SpinKitCircle(
                              //                   color: AppTheme.of(context)
                              //                       .secondaryColor,
                              //                   size: 50,
                              //                 ),
                              //               ),
                              //             );
                              //           }
                              //           final List<Usuario> usuarios =
                              //               snapshot.data!;
                              //           return RefreshIndicator(
                              //             onRefresh: () async {
                              //               //TODO: revisar funcionalidad
                              //               setState(() {});
                              //             },
                              //             child: SingleChildScrollView(
                              //               child: ListView.builder(
                              //                 padding: EdgeInsets.zero,
                              //                 shrinkWrap: true,
                              //                 primary: false,
                              //                 scrollDirection: Axis.vertical,
                              //                 itemCount: usuarios.length,
                              //                 itemBuilder: (context, index) {
                              //                   final usuario = usuarios[index];
                              //                   return Padding(
                              //                     padding:
                              //                         const EdgeInsetsDirectional
                              //                                 .fromSTEB(
                              //                             0, 10, 0, 0),
                              //                     child: Material(
                              //                       color: Colors.transparent,
                              //                       elevation: 5,
                              //                       shape:
                              //                           RoundedRectangleBorder(
                              //                         borderRadius:
                              //                             BorderRadius.circular(
                              //                                 10),
                              //                       ),
                              //                       child: Container(
                              //                         width: double.infinity,
                              //                         height: 55,
                              //                         decoration: BoxDecoration(
                              //                           color: AppTheme.of(
                              //                                   context)
                              //                               .primaryBackground,
                              //                           borderRadius:
                              //                               BorderRadius
                              //                                   .circular(10),
                              //                           border: Border.all(
                              //                             color: Colors
                              //                                 .transparent,
                              //                             width: 1,
                              //                           ),
                              //                         ),
                              //                         child: Padding(
                              //                           padding:
                              //                               const EdgeInsetsDirectional
                              //                                       .fromSTEB(
                              //                                   0, 5, 0, 5),
                              //                           child: Row(
                              //                             mainAxisAlignment:
                              //                                 MainAxisAlignment
                              //                                     .spaceEvenly,
                              //                             children: [
                              //                               Expanded(
                              //                                 child: Text(
                              //                                   usuario.id,
                              //                                   textAlign:
                              //                                       TextAlign
                              //                                           .center,
                              //                                   style: AppTheme.of(
                              //                                           context)
                              //                                       .subtitle1
                              //                                       .override(
                              //                                         fontFamily:
                              //                                             'Gotham-Light',
                              //                                         color: AppTheme.of(
                              //                                                 context)
                              //                                             .primaryText,
                              //                                         fontWeight:
                              //                                             FontWeight
                              //                                                 .normal,
                              //                                         useGoogleFonts:
                              //                                             false,
                              //                                       ),
                              //                                 ),
                              //                               ),
                              //                               Expanded(
                              //                                 child: Text(
                              //                                   '${usuario.nombre} ${usuario.apellidos}',
                              //                                   textAlign:
                              //                                       TextAlign
                              //                                           .center,
                              //                                   style: AppTheme.of(
                              //                                           context)
                              //                                       .subtitle1
                              //                                       .override(
                              //                                         fontFamily:
                              //                                             'Gotham-Light',
                              //                                         color: AppTheme.of(
                              //                                                 context)
                              //                                             .primaryText,
                              //                                         fontWeight:
                              //                                             FontWeight
                              //                                                 .normal,
                              //                                         useGoogleFonts:
                              //                                             false,
                              //                                       ),
                              //                                 ),
                              //                               ),
                              //                               Expanded(
                              //                                 child: Text(
                              //                                   usuario.rol
                              //                                       .nombreRol,
                              //                                   textAlign:
                              //                                       TextAlign
                              //                                           .center,
                              //                                   style: AppTheme.of(
                              //                                           context)
                              //                                       .subtitle1
                              //                                       .override(
                              //                                         fontFamily:
                              //                                             'Gotham-Light',
                              //                                         color: AppTheme.of(
                              //                                                 context)
                              //                                             .primaryText,
                              //                                         fontWeight:
                              //                                             FontWeight
                              //                                                 .normal,
                              //                                         useGoogleFonts:
                              //                                             false,
                              //                                       ),
                              //                                 ),
                              //                               ),
                              //                               Expanded(
                              //                                 child: Text(
                              //                                   usuario.email,
                              //                                   textAlign:
                              //                                       TextAlign
                              //                                           .center,
                              //                                   style: AppTheme.of(
                              //                                           context)
                              //                                       .subtitle1
                              //                                       .override(
                              //                                         fontFamily:
                              //                                             'Gotham-Light',
                              //                                         color: AppTheme.of(
                              //                                                 context)
                              //                                             .primaryText,
                              //                                         fontWeight:
                              //                                             FontWeight
                              //                                                 .normal,
                              //                                         useGoogleFonts:
                              //                                             false,
                              //                                       ),
                              //                                 ),
                              //                               ),
                              //                               Expanded(
                              //                                 child: Text(
                              //                                   usuario
                              //                                       .telefono,
                              //                                   textAlign:
                              //                                       TextAlign
                              //                                           .center,
                              //                                   style: AppTheme.of(
                              //                                           context)
                              //                                       .subtitle1
                              //                                       .override(
                              //                                         fontFamily:
                              //                                             'Gotham-Light',
                              //                                         color: AppTheme.of(
                              //                                                 context)
                              //                                             .primaryText,
                              //                                         fontWeight:
                              //                                             FontWeight
                              //                                                 .normal,
                              //                                         useGoogleFonts:
                              //                                             false,
                              //                                       ),
                              //                                 ),
                              //                               ),
                              //                               Expanded(
                              //                                 child: Text(
                              //                                   usuario.pais
                              //                                       .nombrePais,
                              //                                   textAlign:
                              //                                       TextAlign
                              //                                           .center,
                              //                                   style: AppTheme.of(
                              //                                           context)
                              //                                       .subtitle1
                              //                                       .override(
                              //                                         fontFamily:
                              //                                             'Gotham-Light',
                              //                                         color: AppTheme.of(
                              //                                                 context)
                              //                                             .primaryText,
                              //                                         fontWeight:
                              //                                             FontWeight
                              //                                                 .normal,
                              //                                         useGoogleFonts:
                              //                                             false,
                              //                                       ),
                              //                                 ),
                              //                               ),
                              //                               Expanded(
                              //                                 child:
                              //                                     CustomSwitchListTile(
                              //                                   key:
                              //                                       UniqueKey(),
                              //                                 ),
                              //                               ),
                              //                               Expanded(
                              //                                 child: Text(
                              //                                   'Acciones',
                              //                                   textAlign:
                              //                                       TextAlign
                              //                                           .center,
                              //                                   style: AppTheme.of(
                              //                                           context)
                              //                                       .subtitle1
                              //                                       .override(
                              //                                         fontFamily:
                              //                                             'Gotham-Light',
                              //                                         color: AppTheme.of(
                              //                                                 context)
                              //                                             .primaryText,
                              //                                         fontWeight:
                              //                                             FontWeight
                              //                                                 .normal,
                              //                                         useGoogleFonts:
                              //                                             false,
                              //                                       ),
                              //                                 ),
                              //                               ),
                              //                             ],
                              //                           ),
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   );
                              //                 },
                              //               ),
                              //             ),
                              //           );
                              //         }),
                              //   ),
                              // ),
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
}
