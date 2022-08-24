import 'dart:convert';

import 'package:arux/helpers/globals.dart';
import 'package:arux/models/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseQueries {
  static Future<Usuario?> getCurrentUserData() async {
    final user = supabase.auth.currentUser;
    if (user == null) return null;

    final PostgrestFilterBuilder query = supabase
        .from('perfil_usuario')
        .select(
            'nombre, apellidos, paises (id_pais_pk, nombre_pais, clave), roles (id_rol_pk, nombre_rol, permisos), telefono, id_proveedor_fk')
        .eq('perfil_usuario_id', user.id);

    final res = await query.execute();

    if (res.hasError) {
      return null;
    } else if ((res.data as List).isEmpty) {
      return null;
    }

    final userProfile = res.data[0];
    userProfile['id'] = user.id;
    userProfile['email'] = user.email!;

    final usuario = Usuario.fromJson(jsonEncode(userProfile));

    return usuario;
  }

  static Future<bool> insertNc(int partidaSapId, String folio) async {
    var res = await supabase.from('nc_sap').insert(
      [
        {
          'id_partida_sap_fk': partidaSapId,
          'no_doc_nc': folio,
        }
      ],
      returning: ReturningOption.minimal,
    ).execute();

    if (res.hasError) return false;

    //Update a NC Recibida
    res = await supabase
        .from('partidas_sap')
        .update({
          'id_estatus_fk': 6,
        })
        .eq('id_partidas_pk', partidaSapId)
        .execute();

    if (res.hasError) return false;

    return true;
  }

  static Future<bool> completarFactura(int partidaSapId) async {
    //Update a Completado
    final res = await supabase
        .from('partidas_sap')
        .update({
          'id_estatus_fk': 8,
        })
        .eq('id_partidas_pk', partidaSapId)
        .execute();

    if (res.hasError) return false;
    return true;
  }

  static Future<bool> actualizarEstatus(int partidaSapId, int idstatus) async {
    //Update a Completado
    final res = await supabase
        .from('partidas_sap')
        .update({
          'id_estatus_fk': idstatus,
        })
        .eq('id_partidas_pk', partidaSapId)
        .execute();

    if (res.hasError) return false;
    return true;
  }
}
