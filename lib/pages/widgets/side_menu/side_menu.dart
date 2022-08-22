import 'package:arux/helpers/globals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:arux/providers/providers.dart';
import 'package:arux/pages/widgets/side_menu/widgets/menu_button.dart';

class SideMenuWidget extends StatefulWidget {
  const SideMenuWidget({Key? key}) : super(key: key);

  @override
  State<SideMenuWidget> createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  @override
  Widget build(BuildContext context) {
    final VisualStateProvider visualState =
        Provider.of<VisualStateProvider>(context);
    final UserState userState = Provider.of<UserState>(context);
    final userPermissions = currentUser!.rol.permisos;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: MenuButton(
                icon: Icons.home_outlined,
                isTaped: visualState.isTaped[0],
                onPressed: () async {
                  visualState.setTapedOption(0);
                  await Navigator.pushNamed(
                    context,
                    '/home',
                  );
                },
              ),
            ),
            userPermissions.notificaciones != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: MenuButton(
                      icon: Icons.notifications_outlined,
                      isTaped: visualState.isTaped[1],
                      onPressed: () async {
                        visualState.setTapedOption(1);
                        // await Navigator.pushNamed(
                        //   context,
                        //   '/notificaciones'
                        // );
                      },
                    ),
                  )
                : Container(),
            userPermissions.extraccionDeFacturas != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: MenuButton(
                      icon: Icons.subtitles_outlined,
                      isTaped: visualState.isTaped[2],
                      onPressed: () async {
                        visualState.setTapedOption(2);
                        await Navigator.pushNamed(
                          context,
                          '/gestor-partidas-push',
                        );
                      },
                    ),
                  )
                : Container(),
            userPermissions.seguimientoDeFacturas != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: MenuButton(
                      icon: Icons.podcasts,
                      isTaped: visualState.isTaped[3],
                      onPressed: () async {
                        visualState.setTapedOption(3);
                        await Navigator.pushNamed(
                          context,
                          '/seguimiento-facturas',
                        );
                      },
                    ),
                  )
                : Container(),
            userPermissions.pagos != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: MenuButton(
                      icon: Icons.receipt_long_sharp,
                      isTaped: visualState.isTaped[4],
                      onPressed: () async {
                        visualState.setTapedOption(4);
                        await Navigator.pushNamed(
                          context,
                          '/pagos',
                        );
                      },
                    ),
                  )
                : Container(),
            userPermissions.reportes != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: MenuButton(
                      icon: Icons.bar_chart_rounded,
                      isTaped: visualState.isTaped[5],
                      onPressed: () async {
                        /* visualState.setTapedOption(6);
                  await Navigator.pushNamed(
                    context,
                    '/seguimiento-facturas',
                  ); */
                      },
                    ),
                  )
                : Container(),
            userPermissions.seguimientoProveedor != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: MenuButton(
                      icon: Icons.person_add_outlined,
                      isTaped: visualState.isTaped[6],
                      onPressed: () async {
                        visualState.setTapedOption(6);
                        await Navigator.pushNamed(
                          context,
                          '/seguimiento-proveedores',
                        );
                      },
                    ),
                  )
                : Container(),
            userPermissions.administracionDeUsuarios != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: MenuButton(
                      icon: Icons.group_outlined,
                      isTaped: visualState.isTaped[7],
                      onPressed: () async {
                        visualState.setTapedOption(7);
                        await Navigator.pushNamed(
                          context,
                          '/usuarios',
                        );
                      },
                    ),
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: MenuButton(
                fillColor: const Color(0xFFFF0003),
                icon: Icons.power_settings_new_outlined,
                iconColor: const Color(0xFFFF0003),
                isTaped: visualState.isTaped[8],
                onPressed: () async {
                  visualState.setTapedOption(7);
                  await userState.logout();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
