import 'package:fluro/fluro.dart';
import 'package:arux/pages/pages.dart';

class AdminHandlers {
  static Handler homePage = Handler(handlerFunc: (context, params) {
    return const SplashPage();
  });

  static Handler resetPassword = Handler(handlerFunc: (context, params) {
    return const ResetPasswordPage();
  });

  static Handler altaUsuario = Handler(handlerFunc: (context, params) {
    return const AltaUsuarioPage();
  });

  static String parseParams(String params) {
    if (params.contains('#access_token=')) {
      const start = 'access_token=';
      const end = '&';

      final startIndex = params.indexOf(start);
      final endIndex = params.indexOf(end, startIndex + start.length);

      return params.substring(startIndex + start.length, endIndex);
    } else {
      return '';
    }
  }
}
