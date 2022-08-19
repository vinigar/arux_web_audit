import 'dart:convert';

import 'package:arux/helpers/globals.dart';
import 'package:arux/models/models.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CrudUsuarios extends ChangeNotifier {
  //QUERIES
  final paisesQuery =
      supabase.from('paises').select('nombre_pais, id_pais_pk').execute();
  final rolesQuery =
      supabase.from('roles').select('nombre_rol, id_rol_pk').execute();
  final usuariosQuery = supabase
      .from('users')
      .select(
          'id, email, nombre, apellidos, paises!perfil_usuario (id_pais_pk, nombre_pais, clave), roles!perfil_usuario (id_rol_pk, nombre_rol), telefono')
      .execute();

  List<Pais> paises = [];
  List<RolApi> roles = [];
  List<Usuario> usuarios = [];

  //Informacion del usuario
  String paisId = '';
  String rolId = '';
  String proveedorId = '2';

  void setPais(String? nombre) {
    if (nombre == null) return;
    try {
      paisId = paises
          .singleWhere((element) => element.nombrePais == nombre)
          .idPaisPk
          .toString();
    } catch (e) {
      print(e);
    }
  }

  void setRol(String? nombre) {
    if (nombre == null) return;
    try {
      rolId = roles
          .singleWhere((element) => element.nombreRol == nombre)
          .idRolPk
          .toString();
    } catch (e) {
      print(e);
    }
  }

  void setPaises(List<dynamic> paises) {
    if (this.paises.isNotEmpty) return;
    for (final pais in paises) {
      this.paises.add(Pais.fromJson(jsonEncode(pais)));
    }
  }

  void setRoles(List<dynamic> roles) {
    if (this.roles.isNotEmpty) return;
    for (final rol in roles) {
      this.roles.add(RolApi.fromJson(jsonEncode(rol)));
    }
  }

  //TODO: mejorar logica, manejar errores
  Future<List<String>> getPaises() async {
    final PostgrestResponse<dynamic> res = await paisesQuery;
    setPaises(res.data as List<dynamic>);
    final List<String> nombresPaises = (res.data as List<dynamic>)
        .map((e) => e['nombre_pais'] as String)
        .toList();
    return nombresPaises;
  }

  Future<List<String>> getRoles() async {
    final PostgrestResponse<dynamic> res = await rolesQuery;
    setRoles(res.data as List<dynamic>);
    final List<String> nombresRoles = (res.data as List<dynamic>)
        .map((e) => e['nombre_rol'] as String)
        .toList();
    return nombresRoles;
  }

  Future<List<Usuario>> getUsuarios() async {
    final PostgrestResponse<dynamic> res = await usuariosQuery;
    final List<Usuario> usuarios = (res.data as List<dynamic>)
        .map((usuario) => Usuario.fromJson(jsonEncode(usuario)))
        .toList();
    return usuarios;
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }
}
