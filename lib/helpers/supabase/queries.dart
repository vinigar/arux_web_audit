import 'dart:convert';

import 'package:arux/helpers/globals.dart';
import 'package:arux/models/models.dart';

class SupabaseQueries {
  static Future<Usuario?> getCurrentUserData() async {
    final user = supabase.auth.currentUser;
    if (user == null) return null;
    final res = await supabase
        .from('perfil_usuario')
        .select(
            'nombre, apellidos, paises (id_pais_pk, nombre_pais, clave), roles (id_rol_pk, nombre_rol, permisos), telefono, id_proveedor_fk')
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

    print(jsonEncode(userProfile));

    final usuario = Usuario.fromJson(jsonEncode(userProfile));

    return usuario;
  }
}
