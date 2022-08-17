import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:arux/helpers/globals.dart';
import 'package:arux/pages/pages.dart';
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
<<<<<<< HEAD
              /* await Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  duration: const Duration(milliseconds: 0),
                  reverseDuration: const Duration(milliseconds: 0),
                  child: Container(),
                  // child: InicioWidget(),
                ),
              ); */
=======
              // await Navigator.push(
              //   context,
              //   PageTransition(
              //     type: PageTransitionType.fade,
              //     duration: const Duration(milliseconds: 0),
              //     reverseDuration: const Duration(milliseconds: 0),
              //     child: Container(),
              //     // child: InicioWidget(),
              //   ),
              // );
            },
          ),
          MenuButton(
            icon: Icons.notifications_outlined,
            onPressed: () async {
              // await Navigator.push(
              //   context,
              //   PageTransition(
              //     type: PageTransitionType.fade,
              //     duration: const Duration(milliseconds: 0),
              //     reverseDuration: const Duration(milliseconds: 0),
              //     child: Container(),
              //     // child: NotificacionesWidget(),
              //   ),
              // );
            },
          ),
          MenuButton(
            borderColor: Colors.transparent,
            icon: Icons.subtitles_outlined,
            onPressed: () async {
              await Navigator.pushNamed(
                context,
                'gestor-partidas-push',
              );
>>>>>>> bec96b887b7d907a7fbc5248c18ca8ab88325ca5
            },
          ),
          MenuButton(
            borderColor: Colors.transparent,
            icon: Icons.podcasts,
            onPressed: () async {
<<<<<<< HEAD
              /* await Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  duration: const Duration(milliseconds: 0),
                  reverseDuration: const Duration(milliseconds: 0),
                  child: Container(),
                  // child: NotificacionesWidget(),
                ),
              ); */
=======
              await Navigator.pushNamed(
                context,
                'gestor-partidas-pull',
              );
>>>>>>> bec96b887b7d907a7fbc5248c18ca8ab88325ca5
            },
          ),
          MenuButton(
            icon: Icons.receipt_long_sharp,
            onPressed: () async {
<<<<<<< HEAD
              await Navigator.pushReplacementNamed(
                context,
                '/gestor-partidas-push',
              );
            },
          ),
          CustomIconButton(
            borderColor: Colors.transparent,
            borderRadius: 50,
            borderWidth: 0,
            buttonSize: 70,
            fillColor: Colors.transparent,
            icon: FaIcon(
              FontAwesomeIcons.podcast,
              color: AppTheme.of(context).secondaryText,
              size: 35,
            ),
            onPressed: () async {
              /* await Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  duration: const Duration(milliseconds: 0),
                  reverseDuration: const Duration(milliseconds: 0),
                  child: const GestorPartidasPull(),
                ),
              ); */
            },
          ),
          /* Material(
            color: Colors.transparent,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF09A963),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
            ),
          ), */
          CustomIconButton(
            borderColor: Colors.transparent,
            borderRadius: 100,
            borderWidth: 1,
            buttonSize: 70,
            icon: Icon(
              Icons.receipt_long_sharp,
              color: AppTheme.of(context).secondaryText,
              size: 35,
            ),
            onPressed: () async {
              /* await Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  duration: const Duration(milliseconds: 0),
                  reverseDuration: const Duration(milliseconds: 0),
                  child: Container(),
                  // child: PagosWidget(),
                ),
              ); */
            },
          ),
          CustomIconButton(
            borderColor: Colors.transparent,
            borderRadius: 100,
            borderWidth: 1,
            buttonSize: 70,
            icon: Icon(
              Icons.bar_chart_rounded,
              color: AppTheme.of(context).secondaryText,
              size: 35,
            ),
=======
              // await Navigator.push(
              //   context,
              //   PageTransition(
              //     type: PageTransitionType.fade,
              //     duration: const Duration(milliseconds: 0),
              //     reverseDuration: const Duration(milliseconds: 0),
              //     child: Container(),
              //     // child: PagosWidget(),
              //   ),
              // );
            },
          ),
          MenuButton(
            icon: Icons.bar_chart_rounded,
>>>>>>> bec96b887b7d907a7fbc5248c18ca8ab88325ca5
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                '/reporte-seguimiento-facturas',
              );
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
