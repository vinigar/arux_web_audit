import 'dart:html';

import 'package:fluro/fluro.dart';
import 'package:arux/pages/pages.dart';

class AdminHandlers {
  static Handler homePage = Handler(handlerFunc: (context, params) {
    // The root route is always pushed at the start of the app (even if the route
    // is different). We have to avoid creating the same layout twice to preserve
    // the state
    print('Entered homePage handler');
    print('URL: ${window.location.href}');
    print('Params: $params');
    if (Uri.base.fragment.contains('?')) {
      //has query parameters (will be rebuilt anyway)
      return null;
    } else {
      //no query parameters
      return const SplashPage();
    }
  });

  static Handler resetPassword = Handler(handlerFunc: (context, params) {
    print('Entered changePassword handler');
    print('URL: ${window.location.href}');
    print('Params: $params');
    return const ResetPasswordPage();
  });

  static Handler changePassword = Handler(handlerFunc: (context, params) {
    print('Entered changePassword handler');
    print('URL: ${window.location.href}');
    print('Params: $params');
    if (params.containsKey('token')) {
      final String accessToken = parseParams(params['token']![0]);
      if (accessToken == '') return const PageNotFoundPage();
      return ChangePasswordPage(token: accessToken);
    } else {
      return const PageNotFoundPage();
    }
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
