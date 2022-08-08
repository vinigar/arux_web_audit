import 'package:fluro/fluro.dart';
import 'package:arux/router/admin_handlers.dart';
import 'package:arux/router/no_page_found_handlers.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static String rootRoute = '/';

  // static String homeRoute = 'home';

  static String resetPassword = '/reset-password';

  static String changePassword = '/change-password/:token';

  //TODO: quitar
  // static String prefillRoute = 'prefill/:address';

  // static String repRouteTemp = 'rep';

  // static String repRoute = 'rep/:rep';

  static void configureRoutes() {
    // Auth Routes
    router.define(
      rootRoute,
      handler: AdminHandlers.homePage,
      transitionType: TransitionType.none,
    );

    router.define(
      resetPassword,
      handler: AdminHandlers.resetPassword,
      transitionType: TransitionType.none,
    );

    router.define(
      changePassword,
      handler: AdminHandlers.changePassword,
      transitionType: TransitionType.none,
    );

    //404
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;
  }
}
