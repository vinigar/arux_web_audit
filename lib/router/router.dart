import 'package:fluro/fluro.dart';
import 'package:arux/router/admin_handlers.dart';
import 'package:arux/router/no_page_found_handlers.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static String rootRoute = '/';

  static String home = '/home';

  static String resetPassword = '/reset-password';

  static String gestorPartidasPull = '/gestor-partidas-pull';

  static String gestoPartidasPush = '/gestor-partidas-push';

  static String proveedores = '/proveedores';

  static String seguimientoProveedores = '/seguimiento-proveedores';

  static String reporteSeguimientoFacturas = '/reporte-seguimiento-facturas';

  static String seguimientoFacturas = '/seguimiento-facturas';

  static String usuarios = '/usuarios';

  static String altaUsuario = '/alta-usuario';

  static String pagos = '/pagos';

  static void configureRoutes() {
    router.define(
      rootRoute,
      handler: AdminHandlers.rootHandler,
      transitionType: TransitionType.none,
    );

    router.define(
      home,
      handler: AdminHandlers.homeHandler,
      transitionType: TransitionType.none,
    );

    router.define(
      resetPassword,
      handler: AdminHandlers.resetPassword,
      transitionType: TransitionType.none,
    );

    router.define(
      usuarios,
      handler: AdminHandlers.usuarios,
      transitionType: TransitionType.none,
    );

    router.define(
      gestoPartidasPush,
      handler: AdminHandlers.gestorPartidasPush,
      transitionType: TransitionType.none,
    );

    router.define(
      gestorPartidasPull,
      handler: AdminHandlers.gestorPartidasPull,
      transitionType: TransitionType.none,
    );

    router.define(
      proveedores,
      handler: AdminHandlers.proveedores,
      transitionType: TransitionType.none,
    );

    router.define(
      seguimientoProveedores,
      handler: AdminHandlers.seguimientoProveedores,
      transitionType: TransitionType.none,
    );

    router.define(
      reporteSeguimientoFacturas,
      handler: AdminHandlers.reporteSeguimientoFacturas,
      transitionType: TransitionType.none,
    );

    router.define(
      seguimientoFacturas,
      handler: AdminHandlers.seguimientoFacturas,
      transitionType: TransitionType.none,
    );

    router.define(
      altaUsuario,
      handler: AdminHandlers.altaUsuario,
      transitionType: TransitionType.none,
    );

    router.define(pagos,
        handler: AdminHandlers.pagos, transitionType: TransitionType.none);

    //404
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;
  }
}
