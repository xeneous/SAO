import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    http.Response response = await http.get(Uri.encodeFull(url));
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

  Future PostData(String mpUrl) async {
    http.Response response = await http.get(Uri.encodeFull(mpUrl));
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

  Future postJsonData(
      {String urlSufix, Map<String, dynamic> parameters}) async {
    http.Response response = await http.post(
      this.url + urlSufix,
      headers: {"Access-Control-Allow-Headers": "*"/*,"Content-Type": "application/json"*/},
      body: jsonEncode(parameters),
    );
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else if (response.statusCode == 201) {
      print(jsonDecode(response.body));
    } else {
      print(response.statusCode);
    }
  }

  Future postJsonGetJsonData(
      {String urlSufix, Map<String, dynamic> parameters}) async {
    http.Response response = await http.post(
      /* this.url + */ urlSufix,
      headers: {"Access-Control-Allow-Headers": "*",
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Access-Control-Allow-Methods": "GET, POST"
      },
      body: jsonEncode(parameters),
    );
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else if (response.statusCode == 201) {
      print(jsonDecode(response.body));
    } else {
      print(response.statusCode);
    }
  }

  Future postJsonDatanoResponse(
      {String urlSufix, Map<String, dynamic> parameters}) async {

    http.Response response = await http.post(
      this.url + urlSufix,
      body: jsonEncode(parameters),
    );
    if (response.statusCode == 200) {
      String data = response.body;
      return true;
    } else if (response.statusCode == 201) {
      print(jsonDecode(response.body));
      return true;
    } else {
      print(response.statusCode);
      return false;
    }
  }
}
