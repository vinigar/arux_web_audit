import 'package:fluro/fluro.dart';
import 'package:arux/pages/pages.dart';

class AdminHandlers {
  static Handler homePage = Handler(handlerFunc: (context, params) {
    return const SplashPage();
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
