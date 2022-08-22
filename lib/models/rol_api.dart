import 'dart:convert';

class RolApi {
  RolApi({
    required this.nombreRol,
    required this.idRolPk,
    required this.permisos,
  });

  String nombreRol;
  int idRolPk;
  Permisos permisos;

  factory RolApi.fromJson(String str) => RolApi.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RolApi.fromMap(Map<String, dynamic> json) => RolApi(
        nombreRol: json["nombre_rol"],
        idRolPk: json["id_rol_pk"],
        permisos: Permisos.fromMap(json["permisos"]),
      );

  Map<String, dynamic> toMap() => {
        "nombre_rol": nombreRol,
        "id_rol_pk": idRolPk,
        "permisos": permisos.toMap(),
      };
}

class Permisos {
  Permisos({
    required this.extraccionDeFacturas,
    required this.seguimientoDeFacturas,
    required this.pagos,
    required this.seguimientoProveedor,
    required this.notificaciones,
    required this.administracionDeProveedores,
    required this.administracionDeUsuarios,
    required this.reportes,
    required this.perfilDeUsuario,
  });

  dynamic extraccionDeFacturas;
  dynamic seguimientoDeFacturas;
  dynamic pagos;
  dynamic seguimientoProveedor;
  dynamic notificaciones;
  dynamic administracionDeProveedores;
  dynamic administracionDeUsuarios;
  dynamic reportes;
  dynamic perfilDeUsuario;

  factory Permisos.fromJson(String str) => Permisos.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Permisos.fromMap(Map<String, dynamic> json) => Permisos(
        extraccionDeFacturas: json["Extraccion de Facturas"],
        seguimientoDeFacturas: json["Seguimiento de Facturas"],
        pagos: json["Pagos"],
        seguimientoProveedor: json["Seguimiento Proveedor"],
        notificaciones: json["Notificaciones"],
        administracionDeProveedores: json["Administracion de Proveedores"],
        administracionDeUsuarios: json["Administracion de Usuarios"],
        reportes: json["Reportes"],
        perfilDeUsuario: json["Perfil de Usuario"],
      );

  Map<String, dynamic> toMap() => {
        "Extraccion de Facturas": extraccionDeFacturas,
        "Seguimiento de Facturas": seguimientoDeFacturas,
        "Pagos": pagos,
        "Seguimiento Proveedor": seguimientoProveedor,
        "Notificaciones": notificaciones,
        "Administracion de Proveedores": administracionDeProveedores,
        "Administracion de Usuarios": administracionDeUsuarios,
        "Reportes": reportes,
        "Perfil de Usuario": perfilDeUsuario,
      };
}
