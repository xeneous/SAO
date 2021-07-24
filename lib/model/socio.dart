class Socio {
  Socio(
      this.nombre,
      this.apellido,
      this.sexo,
      this.documento,
      this.pais,
      this.provincia,
      this.localidad,
      this.domicilio,
      this.codigoPostal,
      this.celular,
      this.fijo,
      this.email,
      this.matriculaNacional,
      this.matriculaProvincial,
      this.provinciaMatricula,
      this.residente,
      this.frenteDiploma,
      this.dorsoDiploma,
      this.aceptaSeguro);

  final String nombre;
  final String apellido;
  final int sexo;
  final int documento;
  final int pais;
  final String provincia;
  final String localidad;
  final String domicilio;
  final String codigoPostal;
  final String celular;
  final String fijo;
  final String email;
  final String matriculaNacional;
  final String matriculaProvincial;
  final String provinciaMatricula;
  final int residente; // 0 no 1 si
  final String frenteDiploma;
  final String dorsoDiploma;
  final int aceptaSeguro;

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'apellido': apellido,
      'sexo': sexo,
      'documento': documento,
      'pais': pais,
      'provincia': provincia,
      'localidad': localidad,
      'domicilio': domicilio,
      'codigoPostal': codigoPostal,
      'celular': celular,
      'fijo': fijo,
      'email': email,
      'matriculaNacional': matriculaNacional,
      'matriculaProvincial': matriculaProvincial,
      'provinciaMatricula': provinciaMatricula,
      'residente': residente, // 0 no 1 si
      'frenteDiploma': frenteDiploma,
      'dorsoDiploma': dorsoDiploma,
      'aceptaSeguro': aceptaSeguro
    };
  }
}
