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

  static Handler altaUsuario = Handler(handlerFunc: (context, params) {
    return const AltaUsuarioPage();
  });
}
