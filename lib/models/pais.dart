import 'dart:convert';

class Pais {
  Pais({
    required this.nombrePais,
    required this.idPaisPk,
    required this.clave,
  });

  String nombrePais;
  int idPaisPk;
  String clave;

  factory Pais.fromJson(String str) => Pais.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pais.fromMap(Map<String, dynamic> json) {
    return Pais(
      nombrePais: json["nombre_pais"],
      idPaisPk: json["id_pais_pk"],
      clave: json["clave"],
    );
  }

  Map<String, dynamic> toMap() => {
        "nombre_pais": nombrePais,
        "id_pais_pk": idPaisPk,
        "clave": clave,
      };
}
