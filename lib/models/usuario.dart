import 'dart:convert';

import 'package:arux/models/models.dart';

class Usuario {
  Usuario({
    required this.id,
    required this.email,
    required this.nombre,
    required this.apellidos,
    required this.telefono,
    required this.pais,
    required this.rol,
  });

  String id;
  String email;
  String nombre;
  String apellidos;
  String telefono;
  Pais pais;
  RolApi rol;

  factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Usuario.fromMap(Map<String, dynamic> json) {
    return Usuario(
      id: json["id"],
      email: json["email"],
      nombre: json["nombre"],
      apellidos: json["apellidos"],
      telefono: json["telefono"],
      pais: Pais.fromJson(jsonEncode(json['paises'][0])),
      rol: RolApi.fromJson(jsonEncode(json['roles'][0])),
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "nombre": nombre,
        "apellidos": apellidos,
        "telefono": telefono,
        "paises": pais.toMap(),
        "roles": rol.toMap(),
      };
}
