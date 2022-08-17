import 'package:flutter/material.dart';

class VisualStateProvider extends ChangeNotifier {
  //OPCIONES MENU:
  //Home, Notificaciones, GestorPartidasPush, GestorPartidasPull, Pagos, Algo, Alta Usuario, Usuarios, Cerrar Sesion
  List<bool> isTaped = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
}
