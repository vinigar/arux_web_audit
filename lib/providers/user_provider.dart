import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:arux/helpers/globals.dart';
import 'package:arux/models/models.dart';
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

  Usuario? currentUser;

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

  Future<Usuario?> getCurrentUserData() async {
    final user = supabase.auth.currentUser!;
    final res = await supabase
        .from('perfil_usuario')
        .select(
            'nombre, apellidos, paises (id_pais_pk, nombre_pais, clave), roles (id_rol_pk, nombre_rol), telefono')
        .eq('perfil_usuario_id', user.id)
        .execute();
    if (res.hasError) {
      return null; //TODO: handle error (retry, send to login)
    } else if ((res.data as List).isEmpty) {
      //usuario no tiene perfil
      return null; //TODO: mandar a login
    }
    final userProfile = res.data[0];
    userProfile['id'] = user.id;
    userProfile['email'] = user.email!;

    final usuario = Usuario.fromJson(jsonEncode(userProfile));

    currentUser = usuario;

    return usuario;
  }

  Future<void> logout() async {
    final res = await supabase.auth.signOut();
    //TODO: handle errors
    // if(res.statusCode);
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
