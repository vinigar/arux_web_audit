import 'dart:convert';

import 'package:arux/helpers/globals.dart';
import 'package:arux/models/models.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CrudProveedores extends ChangeNotifier {
  //QUERIES
  final seguimientoProveedoresQuery =
      supabase.from('perfil_usuario').select().execute();

  Future<List<Usuario>> getSeguimientoProveedores() async {
    final PostgrestResponse<dynamic> res = await seguimientoProveedoresQuery;
    final List<Usuario> facturasProveedor = (res.data as List<dynamic>)
        .map((usuario) => Usuario.fromJson(jsonEncode(usuario)))
        .toList();
    return facturasProveedor;
  }
}
