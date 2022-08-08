import 'package:arux/helpers/globals.dart';
import 'package:arux/pages/pages.dart';
import 'package:arux/services/navigation_service.dart';
import 'package:flutter/material.dart';

import 'package:jwt_decode/jwt_decode.dart';

//TODO: agregar roles
enum Rol { administrador, publico }

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

  //Variables autenticacion
  List<String> token = [];

  Rol rol = Rol.administrador;

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

  //Funcion que revisa si un jwt ha expirado
  bool isTokenExpired(String jwt) {
    DateTime? expiryDate = Jwt.getExpiryDate(jwt);
    if (expiryDate == null) return false;
    return expiryDate.isBefore(DateTime.now());
  }

  //Funciones de autenticacion
  Future<void> setToken(String jwt) async {
    token.clear();
    token.add(jwt);
    await storage.write(key: 'token', value: jwt);
    notifyListeners();
  }

  Future<String> readToken() async {
    final jwt = await storage.read(key: 'token') ?? '';
    if (jwt != '') {
      if (isTokenExpired(jwt)) {
        await logout(false);
        return '';
      }
      token.add(jwt);
    }
    return jwt;
  }

  Future<void> logout([bool remove = true]) async {
    await storage.delete(key: 'token');
    token.clear();
    if (remove) {
      await NavigationService.removeTo(MaterialPageRoute(
        builder: (context) => const SplashPage(
          splashTimer: 0,
        ),
      ));
    }
  }

  void setRole(String rol) {
    switch (rol) {
      case 'Administrador':
        this.rol = Rol.administrador;
        break;
      default:
        this.rol = Rol.publico;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
