import 'package:arux/pages/pagos.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import 'package:arux/helpers/globals.dart';
import 'package:arux/providers/providers.dart';
import 'package:arux/pages/pages.dart';

class AdminHandlers {
  static Handler rootHandler = Handler(handlerFunc: (context, params) {
    if (currentUser == null) {
      return const LoginPage();
    } else {
      if (Uri.base.hasFragment && Uri.base.fragment != '/') {
        return null;
      } else {
        final VisualStateProvider visualState =
            Provider.of<VisualStateProvider>(context!);
        if (currentUser!.rol.nombreRol == 'Proveedor') {
          visualState.setTapedOption(6);
          return const SeguimientoProveedoresPage();
        } else {
          visualState.setTapedOption(7);
          return const UsuariosPage();
        }
      }
    }
  });

  static Handler resetPassword = Handler(handlerFunc: (context, params) {
    return const ResetPasswordPage();
  });

  static Handler usuarios = Handler(handlerFunc: (context, params) {
    final VisualStateProvider visualState =
        Provider.of<VisualStateProvider>(context!);
    visualState.setTapedOption(7);
    return const UsuariosPage();
  });

  static Handler gestorPartidasPull = Handler(handlerFunc: (context, params) {
    final VisualStateProvider visualState =
        Provider.of<VisualStateProvider>(context!);
    visualState.setTapedOption(3);
    return const GestorPartidasPull();
  });

  static Handler gestorPartidasPush = Handler(handlerFunc: (context, params) {
    final VisualStateProvider visualState =
        Provider.of<VisualStateProvider>(context!);
    visualState.setTapedOption(2);
    return const GestorPartidasPush();
  });

  static Handler proveedores = Handler(handlerFunc: (context, params) {
    // final VisualStateProvider visualState =
    //     Provider.of<VisualStateProvider>(context!);
    // visualState.setTapedOption(2);
    return const Proveedores();
  });

  static Handler seguimientoProveedores =
      Handler(handlerFunc: (context, params) {
    final VisualStateProvider visualState =
        Provider.of<VisualStateProvider>(context!);
    visualState.setTapedOption(6);
    return const SeguimientoProveedoresPage();
  });

  static Handler reporteSeguimientoFacturas =
      Handler(handlerFunc: (context, params) {
    // final VisualStateProvider visualState =
    //     Provider.of<VisualStateProvider>(context!);
    //     visualState.setTapedOption(6);
    return const ReporteSeguimientoDeFacturas();
  });

  static Handler seguimientoFacturas = Handler(handlerFunc: (context, params) {
    final VisualStateProvider visualState =
        Provider.of<VisualStateProvider>(context!);
    visualState.setTapedOption(3);
    return const SeguimientoDeFacturas();
  });

  static Handler altaUsuario = Handler(handlerFunc: (context, params) {
    return const AltaUsuarioPage();
  });

  static Handler pagos = Handler(handlerFunc: (context, params) {
    return const Pagos();
  });
}
