import 'dart:convert';

class RolApi {
  RolApi({
    required this.nombreRol,
    required this.idRolPk,
  });

  String nombreRol;
  int idRolPk;

  factory RolApi.fromJson(String str) => RolApi.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RolApi.fromMap(Map<String, dynamic> json) => RolApi(
        nombreRol: json["nombre_rol"],
        idRolPk: json["id_rol_pk"],
      );

  Map<String, dynamic> toMap() => {
        "nombre_rol": nombreRol,
        "id_rol_pk": idRolPk,
      };
}
