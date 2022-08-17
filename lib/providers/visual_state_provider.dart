import 'package:flutter/material.dart';

class VisualStateProvider extends ChangeNotifier {
  //OPCIONES MENU:
  List<bool> isTaped = [
    false, //Home
    false, //Notificaciones
    false, //GestorPartidasPush
    false, //GestorPartidasPull
    false, //Pagos
    false, //Algo
    false, //Alta Usuario
    true, //Usuarios
    false, //Cerrar sesion
  ];

  void setTapedOption(int index) {
    for (var i = 0; i < isTaped.length; i++) {
      isTaped[i] = false;
    }
    isTaped[index] = true;
  }
}
