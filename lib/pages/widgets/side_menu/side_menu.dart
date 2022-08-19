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
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MenuButton(
            icon: Icons.home_outlined,
            isTaped: visualState.isTaped[0],
            onPressed: () async {
              visualState.setTapedOption(0);
              // await Navigator.pushNamed(
              //   context,
              //   '/home',
              // );
            },
          ),
          MenuButton(
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
          MenuButton(
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
          MenuButton(
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
          MenuButton(
            icon: Icons.receipt_long_sharp,
            isTaped: visualState.isTaped[4],
            onPressed: () async {
              visualState.setTapedOption(4);
              // await Navigator.pushNamed(
              //   context,
              //   '/pagos',
              // );
            },
          ),
          MenuButton(
            icon: Icons.bar_chart_rounded,
            isTaped: visualState.isTaped[5],
            onPressed: () {
              visualState.setTapedOption(5);
              print('IconButton pressed ...');
            },
          ),
          MenuButton(
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
          MenuButton(
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
          MenuButton(
            fillColor: const Color(0xFFFF0003),
            icon: Icons.power_settings_new_outlined,
            iconColor: const Color(0xFFFF0003),
            isTaped: visualState.isTaped[8],
            onPressed: () async {
              visualState.setTapedOption(7);
              await userState.logout();
            },
          ),
        ],
      ),
    );
  }
}
