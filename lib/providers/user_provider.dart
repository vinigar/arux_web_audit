import 'package:flutter/material.dart';

import 'package:arux/helpers/globals.dart';
import 'package:arux/services/navigation_service.dart';

// //TODO: agregar roles
// enum Rol { administrador, publico }

class UserState extends ChangeNotifier {
  //EMAIL
  String _email = '';

  String get email => _email;
  Future<void> setEmail() async {
    _email = emailController.text;
    await prefs.setString('email', emailController.text);
  }

  //Controlador para LoginScreen
  TextEditingController emailController = TextEditingController();

  //PASSWORD
  String _password = '';

  String get password => _password;
  Future<void> setPassword() async {
    _password = passwordController.text;
    await prefs.setString('password', passwordController.text);
  }

  //Controlador para LoginScreen
  TextEditingController passwordController = TextEditingController();

  bool recuerdame = false;

  //Constructor de provider
  UserState() {
    recuerdame = prefs.getBool('recuerdame') ?? false;

    if (recuerdame == true) {
      _email = prefs.getString('email') ?? _email;
      _password = prefs.getString('password') ?? password;
    }

    emailController.text = _email;
    passwordController.text = _password;
  }

  void updateRecuerdame() async {
    recuerdame = !recuerdame;
    await prefs.setBool('recuerdame', recuerdame);
    notifyListeners();
  }

  Future<void> logout() async {
    final res = await supabase.auth.signOut();
    //TODO: handle errors
    // if(res.statusCode);
    currentUser = null;
    await NavigationService.removeTo('/');
  }

  // void setRole(String rol) {
  //   switch (rol) {
  //     case 'Administrador':
  //       this.rol = Rol.administrador;
  //       break;
  //     default:
  //       this.rol = Rol.publico;
  //   }
  // }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
