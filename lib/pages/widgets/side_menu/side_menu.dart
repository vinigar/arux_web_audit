import 'package:flutter/material.dart';

import 'package:arux/helpers/globals.dart';
import 'package:arux/pages/widgets/side_menu/widgets/menu_button.dart';

class SideMenuWidget extends StatefulWidget {
  const SideMenuWidget({Key? key}) : super(key: key);

  @override
  State<SideMenuWidget> createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MenuButton(
            icon: Icons.home_outlined,
            onPressed: () async {
              // await Navigator.pushNamed(
              //   context,
              //   '/home',
              // );
            },
          ),
          MenuButton(
            icon: Icons.notifications_outlined,
            onPressed: () async {
              // await Navigator.pushNamed(
              //   context,
              //   '/notificaiones'
              // );
            },
          ),
          MenuButton(
            borderColor: Colors.transparent,
            icon: Icons.subtitles_outlined,
            onPressed: () async {
              await Navigator.pushNamed(
                context,
                '/gestor-partidas-push',
              );
            },
          ),
          MenuButton(
            borderColor: Colors.transparent,
            icon: Icons.podcasts,
            onPressed: () async {
              await Navigator.pushNamed(
                context,
                '/gestor-partidas-pull',
              );
            },
          ),
          MenuButton(
            icon: Icons.receipt_long_sharp,
            onPressed: () async {
              await Navigator.pushNamed(
                context,
                '/pagos',
              );
            },
          ),
          MenuButton(
            icon: Icons.bar_chart_rounded,
            onPressed: () {
              print('IconButton pressed ...');
            },
          ),
          MenuButton(
            icon: Icons.person_add_outlined,
            onPressed: () async {
              await Navigator.pushNamed(
                context,
                '/alta-usuario',
              );
            },
          ),
          MenuButton(
            icon: Icons.group_outlined,
            onPressed: () async {
              await Navigator.pushNamed(
                context,
                '/usuarios',
              );
            },
          ),
          // Material(
          //   color: Colors.transparent,
          //   elevation: 10,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(20),
          //   ),
          //   child: Container(
          //     decoration: BoxDecoration(
          //       color: const Color(0xFF09A963),
          //       borderRadius: BorderRadius.circular(20),
          //       border: Border.all(
          //         color: Colors.white,
          //         width: 2,
          //       ),
          //     ),
          //     child:
          //   ),
          // ),
          MenuButton(
            fillColor: const Color(0xFFFF0003),
            icon: Icons.power_settings_new_outlined,
            onPressed: () async {
              //TODO: handle errors
              final res = await supabase.auth.signOut();
              // if(res.statusCode);
              if (!mounted) return;
              await Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}
