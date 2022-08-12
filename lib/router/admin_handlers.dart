import 'dart:html';

import 'package:fluro/fluro.dart';
import 'package:arux/pages/pages.dart';

class AdminHandlers {
  static Handler homePage = Handler(handlerFunc: (context, params) {
    // The root route is always pushed at the start of the app (even if the route
    // is different). We have to avoid creating the same layout twice to preserve
    // the state
    print('Entered homePage handler');
    print('URL: ${Uri.base}');
    print('Params: $params');

    //no query parameters
    return const SplashPage();
  });

  static Handler resetPassword = Handler(handlerFunc: (context, params) {
    print('Entered changePassword handler');
    print('URL: ${window.location.href}');
    print('Params: $params');
    return const ResetPasswordPage();
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
