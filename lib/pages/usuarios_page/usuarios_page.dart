import 'package:arux/models/models.dart';
import 'package:arux/pages/usuarios_page/widgets/switch_list_tile.dart';
import 'package:arux/pages/widgets/header/header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:arux/pages/widgets/side_menu/side_menu.dart';
import 'package:arux/pages/widgets/top_menu/top_menu.dart';
import 'package:arux/providers/providers.dart';
import 'package:arux/theme/theme.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({Key? key}) : super(key: key);

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  TextEditingController searchController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final CrudUsuarios usuarios = provider.Provider.of<CrudUsuarios>(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).primaryBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const TopMenuWidget(),
                const Divider(
                  height: 2,
                  color: Color(0xFFB7B7B7),
                ),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SideMenuWidget(),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 0, 20, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const PageHeader(
                                headerName: 'Usuarios',
                                spacer: true,
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 5, 0, 0),
                                child: Material(
                                  color: Colors.transparent,
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
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF09A963),
                                      borderRadius: BorderRadius.only(
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
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: const [
                                          Expanded(
                                            child: TableColumnName(
                                              nombre: 'ID Usuario',
                                            ),
                                          ),
                                          Expanded(
                                            child: TableColumnName(
                                              nombre: 'Nombre',
                                            ),
                                          ),
                                          Expanded(
                                            child: TableColumnName(
                                              nombre: 'Rol',
                                            ),
                                          ),
                                          Expanded(
                                            child: TableColumnName(
                                              nombre: 'Correo',
                                            ),
                                          ),
                                          Expanded(
                                            child: TableColumnName(
                                              nombre: 'Teléfono',
                                            ),
                                          ),
                                          Expanded(
                                            child: TableColumnName(
                                              nombre: 'País',
                                            ),
                                          ),
                                          Expanded(
                                            child: TableColumnName(
                                              nombre: 'Ausencia',
                                            ),
                                          ),
                                          Expanded(
                                            child: TableColumnName(
                                              nombre: 'Acciones',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 20),
                                  child: FutureBuilder<List<Usuario>>(
                                      future: usuarios.getUsuarios(),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
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
                                        final List<Usuario> usuarios =
                                            snapshot.data!;
                                        return RefreshIndicator(
                                          onRefresh: () async {
                                            //TODO: revisar funcionalidad
                                            setState(() {});
                                          },
                                          child: SingleChildScrollView(
                                            child: ListView.builder(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              primary: false,
                                              scrollDirection: Axis.vertical,
                                              itemCount: usuarios.length,
                                              itemBuilder: (context, index) {
                                                final usuario = usuarios[index];
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
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 55,
                                                      decoration: BoxDecoration(
                                                        color: AppTheme.of(
                                                                context)
                                                            .primaryBackground,
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
                                                                0, 5, 0, 5),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                usuario.id,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: AppTheme.of(
                                                                        context)
                                                                    .subtitle1
                                                                    .override(
                                                                      fontFamily:
                                                                          'Gotham-Light',
                                                                      color: AppTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      useGoogleFonts:
                                                                          false,
                                                                    ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                '${usuario.nombre} ${usuario.apellidos}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: AppTheme.of(
                                                                        context)
                                                                    .subtitle1
                                                                    .override(
                                                                      fontFamily:
                                                                          'Gotham-Light',
                                                                      color: AppTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      useGoogleFonts:
                                                                          false,
                                                                    ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                usuario.rol
                                                                    .nombreRol,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: AppTheme.of(
                                                                        context)
                                                                    .subtitle1
                                                                    .override(
                                                                      fontFamily:
                                                                          'Gotham-Light',
                                                                      color: AppTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      useGoogleFonts:
                                                                          false,
                                                                    ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                usuario.email,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: AppTheme.of(
                                                                        context)
                                                                    .subtitle1
                                                                    .override(
                                                                      fontFamily:
                                                                          'Gotham-Light',
                                                                      color: AppTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      useGoogleFonts:
                                                                          false,
                                                                    ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                usuario
                                                                    .telefono,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: AppTheme.of(
                                                                        context)
                                                                    .subtitle1
                                                                    .override(
                                                                      fontFamily:
                                                                          'Gotham-Light',
                                                                      color: AppTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      useGoogleFonts:
                                                                          false,
                                                                    ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                usuario.pais
                                                                    .nombrePais,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: AppTheme.of(
                                                                        context)
                                                                    .subtitle1
                                                                    .override(
                                                                      fontFamily:
                                                                          'Gotham-Light',
                                                                      color: AppTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      useGoogleFonts:
                                                                          false,
                                                                    ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child:
                                                                  CustomSwitchListTile(
                                                                key:
                                                                    UniqueKey(),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                'Acciones',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: AppTheme.of(
                                                                        context)
                                                                    .subtitle1
                                                                    .override(
                                                                      fontFamily:
                                                                          'Gotham-Light',
                                                                      color: AppTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      useGoogleFonts:
                                                                          false,
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
                                            ),
                                          ),
                                        );
                                      }),
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
        ),
      ),
    );
  }
}

class TableColumnName extends StatelessWidget {
  const TableColumnName({
    Key? key,
    required this.nombre,
  }) : super(key: key);

  final String nombre;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          nombre,
          textAlign: TextAlign.center,
          style: AppTheme.of(context).subtitle1.override(
                fontFamily: 'Bicyclette-Bold',
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
                useGoogleFonts: false,
              ),
        ),
        const Padding(
          padding: EdgeInsetsDirectional.fromSTEB(2, 0, 0, 0),
          child: Icon(
            Icons.arrow_drop_down_sharp,
            color: Colors.white,
            size: 24,
          ),
        ),
      ],
    );
  }
}
