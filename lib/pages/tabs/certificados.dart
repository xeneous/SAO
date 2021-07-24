import 'package:base/constants.dart';
import 'package:base/functions/navigation.dart';
import 'package:base/services/members.dart';
import 'package:base/states/login_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Certificados extends StatefulWidget {
  final int aceptaSeguro;

  const Certificados({Key key, this.aceptaSeguro}) : super(key: key);

  @override
  _CertificadosState createState() => _CertificadosState();
}

enum SingingCharacter { Si, No }
SingingCharacter _character;

class _CertificadosState extends State<Certificados> {
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    int __character = widget.aceptaSeguro;

    switch (__character) {
      case 0:
        {
          _character = SingingCharacter.Si;
        }
        break;
      case 1:
        {
          _character = SingingCharacter.No;
        }
        break;
      default:
        {
          _character = null;
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    Map<String, dynamic> _userParams;
    MemberModel socios = MemberModel();

    return Scaffold(
      appBar: AppBar(
        title: Text('Seguro de Mala Praxis'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: height * .08,
          ),
          Text(
            'Acepto seguro de Praxis Medica',
            style: kLabelTextStyle,
          ),
          SizedBox(
            height: height * .04,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: ListTile(
                    title: const Text('Si'),
                    leading: Radio(
                      value: SingingCharacter.Si,
                      groupValue: _character,
                      onChanged: (SingingCharacter value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: ListTile(
                    title: const Text('No'),
                    leading: Radio(
                      value: SingingCharacter.No,
                      groupValue: _character,
                      onChanged: (SingingCharacter value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * .06,
          ),
          Container(
            child: Center(
              child: FlatButton(
                color: Colors.blue,
                onPressed: () async {
                  if (_character == SingingCharacter.Si ||
                      _character == SingingCharacter.No) {
                    try {
                      _userParams = {
                        'socio': Provider.of<LoginState>(context, listen: false)
                            .getSocio(),
                        'optSeguro': _character == SingingCharacter.Si ? 0 : 1
                      };
                      bool received = await socios.postJson(
                          parameters: _userParams,
                          urlSufix: '/conformeseguro.php');
                      if (received) {
                        setState(
                          () {
                            Provider.of<LoginState>(context, listen: false)
                                .setAceptaSeguro(
                                    _character == SingingCharacter.Si ? 0 : 1);
                          },
                        );
                      }
                      return;
                    } catch (e) {
                      print(e.toString());
                    }
                  }
                },
                child: Text(
                  'Confirma',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * .02,
          ),
          buildBotonCertificado(),
        ],
      ),
    );
  }

  Container buildBotonCertificado() {
    if (_character == SingingCharacter.Si &&
        Provider.of<LoginState>(context, listen: false).geturlCertificado() !=
            "") {
      return Container(
        height: MediaQuery.of(context).size.height * .4,
        child: Center(
          child: FlatButton(
            color: kAppBarColor,
            onPressed: () {
              launchURL(
                  url: Provider.of<LoginState>(context, listen: false)
                      .geturlCertificado());
            },
            child: Text(
              'Descargar Certificado',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    } else if (Provider.of<LoginState>(context, listen: false)
                .geturlCertificado() ==
            "" &&
        _character == SingingCharacter.Si) {
      return Container(
        height: MediaQuery.of(context).size.height * .35,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(35.0),
            child: Text(
              "Proximamente ud. podra descargar el certificado de su poliza",
              style: TextStyle(
                  fontSize: 17.0,
                  fontFamily: 'Roboto',
                  color: kAppBarColor,
                  letterSpacing: 1.2),
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
