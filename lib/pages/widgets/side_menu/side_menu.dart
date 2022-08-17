import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';

import 'package:arux/helpers/globals.dart';
import 'package:arux/pages/pages.dart';
import 'package:arux/pages/widgets/custom_icon_button.dart';
import 'package:arux/theme/theme.dart';

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
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomIconButton(
            borderColor: Colors.transparent,
            borderRadius: 100,
            borderWidth: 0,
            buttonSize: 70,
            fillColor: Colors.transparent,
            icon: Icon(
              Icons.home_outlined,
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
                  // child: InicioWidget(),
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
              Icons.notifications_outlined,
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
                  // child: NotificacionesWidget(),
                ),
              ); */
            },
          ),
          CustomIconButton(
            borderColor: Colors.transparent,
            borderRadius: 50,
            borderWidth: 0,
            buttonSize: 70,
            fillColor: Colors.transparent,
            icon: Icon(
              Icons.subtitles_outlined,
              color: AppTheme.of(context).secondaryText,
              size: 50,
            ),
            onPressed: () async {
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
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                '/reporte-seguimiento-facturas',
              );
            },
          ),
          Align(
            alignment: const AlignmentDirectional(0, 0.5),
            child: CustomIconButton(
              borderColor: Colors.transparent,
              borderRadius: 100,
              borderWidth: 1,
              buttonSize: 70,
              icon: Icon(
                Icons.person_add_outlined,
                color: AppTheme.of(context).secondaryText,
                size: 35,
              ),
              onPressed: () async {
                await Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    duration: const Duration(milliseconds: 0),
                    reverseDuration: const Duration(milliseconds: 0),
                    child: const AltaUsuarioPage(),
                  ),
                );
              },
            ),
          ),
          Material(
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
              child: Align(
                alignment: const AlignmentDirectional(0, 0.5),
                child: CustomIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 100,
                  borderWidth: 1,
                  buttonSize: 70,
                  icon: const Icon(
                    Icons.group_outlined,
                    color: Color(0xFFFDFDFD),
                    size: 35,
                  ),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        duration: const Duration(milliseconds: 0),
                        reverseDuration: const Duration(milliseconds: 0),
                        child: const UsuariosPage(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          CustomIconButton(
            borderColor: Colors.transparent,
            borderRadius: 100,
            borderWidth: 1,
            buttonSize: 100,
            icon: const Icon(
              Icons.power_settings_new_outlined,
              color: Color(0xFFFF0003),
              size: 35,
            ),
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
