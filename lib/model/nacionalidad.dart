class Nacionalidad {
  int idpais;
  String gentilicio;

  Nacionalidad({this.idpais, this.gentilicio});

  factory Nacionalidad.fromJson(Map<String, dynamic> parsedJson) {
    return Nacionalidad(
        idpais: int.parse(parsedJson["idpais"]),
        gentilicio: parsedJson["gentilicio"] as String);
  }
}
