import 'dart:convert';

import 'package:arux/helpers/globals.dart';
import 'package:arux/models/models.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CrudProveedores extends ChangeNotifier {
  //QUERIES
  final seguimientoProveedoresQuery = supabase
      .from('seguimiento_proveedor')
      .select()
      .eq('id_proveedor_fk', currentUser?.idProveedorFk ?? '')
      .not('nombre_estatus', 'eq', 'Extraccion')
      .execute();

  //TODO: manejar errores
  Future<List<FacturaProveedor>?> getSeguimientoProveedores() async {
    final PostgrestResponse<dynamic> res = await seguimientoProveedoresQuery;
    if (res.hasError) {
      print(res.error);
      return null;
    }

    final List<FacturaProveedor> facturasProveedor = (res.data as List<dynamic>)
        .map((facturaProveedor) =>
            FacturaProveedor.fromJson(jsonEncode(facturaProveedor)))
        .toList();
    return facturasProveedor;
  }
}
