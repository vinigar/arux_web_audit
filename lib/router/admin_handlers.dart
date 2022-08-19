import 'package:arux/helpers/globals.dart';
import 'package:fluro/fluro.dart';
import 'package:arux/pages/pages.dart';

class AdminHandlers {
  static Handler rootHandler = Handler(handlerFunc: (context, params) {
    if (currentUser == null) {
      return const LoginPage();
    } else {
      if (Uri.base.hasFragment) {
        return null;
      } else {
        //Return HomePage
        return const UsuariosPage();
      }
    }
  });

  static Handler resetPassword = Handler(handlerFunc: (context, params) {
    return const ResetPasswordPage();
  });

  static Handler usuarios = Handler(handlerFunc: (context, params) {
    return const UsuariosPage();
  });

  static Handler gestorPartidasPull = Handler(handlerFunc: (context, params) {
    return const GestorPartidasPull();
  });

  static Handler gestorPartidasPush = Handler(handlerFunc: (context, params) {
    return const GestorPartidasPush();
  });

  static Handler proveedores = Handler(handlerFunc: (context, params) {
    return const Proveedores();
  });

  static Handler seguimientoProveedores =
      Handler(handlerFunc: (context, params) {
    return const SeguimientoProveedoresPage();
  });

  static Handler reporteSeguimientoFacturas =
      Handler(handlerFunc: (context, params) {
    return const ReporteSeguimientoDeFacturas();
  });

  static Handler seguimientoFacturas = Handler(handlerFunc: (context, params) {
    return const SeguimientoDeFacturas();
  });

  static Handler altaUsuario = Handler(handlerFunc: (context, params) {
    return const AltaUsuarioPage();
  });
}
