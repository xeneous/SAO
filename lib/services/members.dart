import 'package:base/services/networking.dart';

const apiKey = '416883593632253425237t3364323439386a87923867';
const openWeatherMapURL = 'https://www.administracionsao.com.ar//appwebsao';

class MemberModel {
  /// *
  /// Verifica Numero de Documento contra base de Miembros

  Future<dynamic> getDocumento({String urlSufix, String document}) async {
    NetworkHelper networkHelper =
        NetworkHelper('$openWeatherMapURL$urlSufix?d=$document&t=$apiKey');

    var memberData = await networkHelper.getData();
    return memberData;
  }

  Future<dynamic> getPostJson(
      {String urlSufix, Map<String, dynamic> parameters}) async {
    NetworkHelper networkHelper = NetworkHelper('$openWeatherMapURL$urlSufix');

    var memberData = await networkHelper.postJsonGetJsonData(
        urlSufix: urlSufix, parameters: parameters);

    return memberData;
  }

  /// *
  /// Verifica si ya fue identificado contra base accesoria
  Future<bool> getWasIdentified(
          {String urlSufix, String parameters}) async {
    NetworkHelper networkHelper = NetworkHelper('$openWeatherMapURL' + urlSufix + '?' + parameters);
    bool _isIdentified;
    var memberData = await networkHelper.getData();
    if (memberData[0]['grupo'] != 'X') {
      _isIdentified = true;
    } else {
      _isIdentified = false;
    }

    return _isIdentified;
  }

  /// *
  /// Verifica si ya fue identificado contra base accesoria
  Future<List<dynamic>> getWasIdentifiedData(
      {String urlSufix, String parameters}) async {
    NetworkHelper networkHelper = NetworkHelper('$openWeatherMapURL' + urlSufix + '?' + parameters);
    var _memberData = await networkHelper.getData();
    return _memberData;
  }

  Future<bool> getWasIdentified_Cors(
      {String urlSufix, Map<String, dynamic> parameters}) async {
    NetworkHelper networkHelper = NetworkHelper('$openWeatherMapURL');
    bool _isIdentified;
    var memberData = await networkHelper.postJsonGetJsonData(
        urlSufix: urlSufix, parameters: parameters);
    if (memberData[0]['grupo'] != 'X') {
      _isIdentified = true;
    } else {
      _isIdentified = false;
    }

    return _isIdentified;
  }

  /// *
  /// Verifica si ya fue identificado contra base accesoria
  Future<List<dynamic>> getWasIdentifiedDataCors(
      {String urlSufix, Map<String, dynamic> parameters}) async {
    NetworkHelper networkHelper = NetworkHelper('$openWeatherMapURL');
    var _memberData = await networkHelper.postJsonGetJsonData(
        urlSufix: urlSufix, parameters: parameters);
    return _memberData;
  }

  /// *
  /// Update de tabla accesoria de miembros una vez identificado
  Future<dynamic> postIsIdentified(
      {String urlSufix, Map<String, dynamic> parameters}) async {
    NetworkHelper networkHelper = NetworkHelper('$openWeatherMapURL');

    var memberData = await networkHelper.postJsonData(
        urlSufix: urlSufix, parameters: parameters);
    return memberData;
  }

  Future<bool> postJson(
      {String urlSufix, Map<String, dynamic> parameters}) async {
    NetworkHelper networkHelper =
        NetworkHelper('$openWeatherMapURL'); // '$openWeatherMapURL$urlSufix'

    bool memberData = await networkHelper.postJsonDatanoResponse(
        urlSufix: urlSufix, parameters: parameters);

    return memberData;
  }
}
