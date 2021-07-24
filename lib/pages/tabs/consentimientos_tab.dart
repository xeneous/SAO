import 'package:base/functions/formatters.dart';
import 'package:base/functions/funciones.dart';
import 'package:base/functions/navigation.dart';
import 'package:base/services/networking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class Consentimientos extends StatefulWidget {
  const Consentimientos({
    Key key,
  }) : super(key: key);

  @override
  _ConsentimientosState createState() => _ConsentimientosState();
}

class _ConsentimientosState extends State<Consentimientos> {
  TextEditingController controller = new TextEditingController();

  // Get json result and convert it to model. Then add
  Future<Null> getConsentimientos() async {
    _userConsentimientosDetails = [];
    final NetworkHelper networkHelper =
        NetworkHelper('https://www.administracionsao.com.ar//appwebsao//wsConsentimienosData.php');

    final response = await networkHelper.getData();

    setState(() {
      for (Map consentimiento in response) {
        _userConsentimientosDetails
            .add(UserConsentimientosDetails.fromJson(consentimiento));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    getConsentimientos();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: kAppBarColor,
        title: new TextField(
          textCapitalization: TextCapitalization.characters,
          controller: controller,
          style: TextStyle(color: Colors.white),
          decoration: new InputDecoration(
              hintText: 'BUSCAR',
              hintStyle: TextStyle(color: Colors.white, letterSpacing: 1.2),
              // border: InputBorder.,
              suffixIcon: Icon(
                Icons.search,
                color: Colors.white,
              )),
          inputFormatters: [
            new UpperCaseTextFormatter(),
          ],
          onChanged: onSearchTextChanged,
        ),
        elevation: 0.0,
      ),
      body: new Column(
        children: <Widget>[
          new Expanded(
            child: _searchResult.length != 0 || controller.text.isNotEmpty
                ? new ListView.builder(
                    itemCount: _searchResult.length,
                    itemBuilder: (context, i) {
                      return Card(
                        elevation: 3.0,
                        child: new ListTile(
                          title: new Text(
                            _searchResult[i].titulo,
                            style: kTitkeLabelListViewTextStyle,
                          ),
                          subtitle: new Text(_searchResult[i].detalle),
                          trailing: Icon(Icons.star_border),
                          onTap: () {
                            launchURL(url: _searchResult[i].url);
                          },
                        ),
                      );
                    },
                  )
                : new ListView.builder(
                    itemCount: _userConsentimientosDetails.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: new ListTile(
                          title: new Text(
                              _userConsentimientosDetails[index].titulo,
                              style: kTitkeLabelListViewTextStyle),
                          subtitle: new Text(
                              _userConsentimientosDetails[index].detalle),
                          trailing: Icon(Icons.star_border),
                          onTap: () {
                            launchURL(
                                url: _userConsentimientosDetails[index].url);
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _userConsentimientosDetails.forEach((userConsentimiento) {
      if (removeDiacritics(userConsentimiento.titulo).contains(text) == true) {
        _searchResult.add(userConsentimiento);
      }
    });

    setState(
      () {},
    );
  }
}

List<UserConsentimientosDetails> _searchResult = [];

List<UserConsentimientosDetails> _userConsentimientosDetails = [];

final String url = '';

class UserConsentimientosDetails {
  final String id;
  final String titulo, detalle, url;

  UserConsentimientosDetails(
      {this.id, this.titulo, this.detalle, this.url = ''});

  factory UserConsentimientosDetails.fromJson(Map<String, dynamic> json) {
    return new UserConsentimientosDetails(
      id: json['id'].toString(),
      titulo: json['titulo'],
      detalle: json['detalle'],
      url: json['url'],
    );
  }
}
