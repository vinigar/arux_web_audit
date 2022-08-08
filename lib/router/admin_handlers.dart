import 'package:fluro/fluro.dart';
import 'package:arux/pages/pages.dart';

class AdminHandlers {
  static Handler homePage = Handler(handlerFunc: (context, params) {
    // The root route is always pushed at the start of the app (even if the route
    // is different). We have to avoid creating the same layout twice to preserve
    // the state
    print('Entered homePage handler');
    if (Uri.base.fragment.contains('?')) {
      //has query parameters (will be rebuilt anyway)
      return null;
    } else {
      //no query parameters
      return const SplashPage();
    }
  });

  static Handler resetPassword = Handler(handlerFunc: (context, params) {
    return const ResetPasswordPage();
  });

  static Handler changePassword = Handler(handlerFunc: (context, params) {
    if (params.containsKey('token')) {
      return ChangePasswordPage(token: params['token']![0]);
    } else {
      return const PageNotFoundPage();
    }
  });
}
