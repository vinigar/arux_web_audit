import 'package:fluro/fluro.dart';
import 'package:arux/router/admin_handlers.dart';
import 'package:arux/router/no_page_found_handlers.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static String rootRoute = '/';

  static String resetPassword = '/reset-password';

  static String altaUsuario = 'alta-usuario';

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
      altaUsuario,
      handler: AdminHandlers.altaUsuario,
      transitionType: TransitionType.none,
    );

    //404
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;
  }
}
