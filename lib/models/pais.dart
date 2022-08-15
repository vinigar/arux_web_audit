import 'dart:convert';

class Pais {
  Pais({
    required this.nombrePais,
    required this.idPaisPk,
  });

  String nombrePais;
  int idPaisPk;

  factory Pais.fromJson(String str) => Pais.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pais.fromMap(Map<String, dynamic> json) => Pais(
        nombrePais: json["nombre_pais"],
        idPaisPk: json["id_pais_pk"],
      );

  Map<String, dynamic> toMap() => {
        "nombre_pais": nombrePais,
        "id_pais_pk": idPaisPk,
      };
}
