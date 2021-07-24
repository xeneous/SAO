import 'package:base/constants.dart';
import 'package:base/functions/alertas.dart';
import 'package:base/pages/tabs/ficha.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import '../services/members.dart';
import '../states/login_state.dart';

class PreHomePage extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _PreHomePageState createState() => _PreHomePageState();
}

class _PreHomePageState extends State<PreHomePage> {
  MemberModel socios = MemberModel();
  TextEditingController _documentoController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  String _documento = '';
  String _email = '';
  bool _docEnablad = true;
  double _opacity = 0.0;
  String _emailMask = '';
  String _bText = 'siguiente';
  String _hTextDocumento = 'Numero documento';
  String _tituloArea = 'Area de Miembros SAO';
  Map<String, dynamic> _userParams;

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<LoginState>(context).currentUser();
    final _userEmail = _user.email;

    final double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: ListView(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 5 / 1,
                child: Image.asset('images/SAO-01.jpg'),
              ),
              SizedBox(
                height: height * .01,
              ),
              buildTextForm(text: 'Area de Miembros SAO\nAcceso'),
              TextField(
                enabled: _docEnablad,
                style: (TextStyle(color: kBotonColor)),
                decoration: kFieldLoginTextDecoration.copyWith(
                    icon: Icon(
                      FontAwesome.id_card,
                      color: kBotonColor,
                    ),
                    hintText: _hTextDocumento),
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(12),
                  WhitelistingTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.singleLineFormatter,
                ],
                textAlign: TextAlign.center,
                controller: _documentoController,
                maxLength: 8,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _documento = value;
                },
              ),
              Opacity(
                opacity: _opacity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildTextForm(
                        text:
                            'Email ingresado $_userEmail\n\nAl asociarse usted informo\n$_emailMask\n\npor favor confirmelo para verificar su identidad',
                        style: kLabelTextStyle.copyWith(
                            fontFamily: 'RobotoRegular', fontSize: 13.0)),
                    TextField(
                      autofocus: true,
                      style: (TextStyle(color: kBotonColor)),
                      decoration: kFieldLoginTextDecoration.copyWith(
                          hintText: 'email en SAO'),
                      textAlign: TextAlign.center,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        _email = value;
                      },
                    ),
                  ],
                ),
              ),
              Container(
                child: ElevatedButton(
                  child: Text(_bText),
                  onPressed: () async {
                    try {
                      _userParams = {'documento': _documento};
                      var memberData = await socios.getPostJson(
                          parameters: _userParams,
                          urlSufix: '/wsregistereddoc.php');
                      if (memberData[0]['documento'] == _documento) {
                        showMyDialog(
                            context: context,
                            title: _tituloArea,
                            line1: 'Documento asociado a otro email',
                            boton: 'OK');
                        return;
                      } else {
                        memberData =
                            await socios.getDocumento(urlSufix: '/ws.php', document:  _documento);
                        if (_documento == '') {
                          showMyDialog(
                            context: context,
                            title: _tituloArea,
                            line1: 'Debe Ingresar un Numero',
                          );
                        } else if (memberData[0]['socio'] == '0') {
                          setState(() {
                            _hTextDocumento = 'Verifique el numero';
                            _documentoController.clear();
                            showMyDialog(
                              context: context,
                              line1: 'Documento Inexistente',
                              line2: 'Acceso Denegado',
                              title: 'Area de Miembros',
                            );
                          });
                        } else if (_user.email != memberData[0]['email'] &&
                            _email != memberData[0]['email']) {
                          setState(
                            () {
                              _bText = 'Comprobar';
                              _docEnablad = false;
                              _opacity = 1.0;
                              _emailMask = memberData[0]['emailmask'];
                              _emailController.text = ''; // _emailMask;
                            },
                          );
                          showMyDialog(
                            context: context,
                            line1: 'Documento difiere del ingresado en SAO',
                            line2: 'Acceso Denegado',
                            title: 'Area de Miembros',
                          );
                        } else {
                          _userParams = {
                            'documento': _documento,
                            'email': _user.email
                          };
                          await socios.postIsIdentified(
                              urlSufix: '/wsIdentified.php',
                              parameters: _userParams);

                          Provider.of<LoginState>(context, listen: false)
                              .setIsIdentified(true);
                        }
                      }
                    } catch (e) {}
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          notchMargin: 8.0,
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                child: Text(
                  'ASOCIESE',
                  style: kLabelTextStyle,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Ficha()),
                  );
                },
              ),
              FlatButton(
                  child: Text(
                    'SALIR',
                    style: kLabelTextStyle,
                  ),
                  onPressed: () {
                    Provider.of<LoginState>(context, listen: false)
                        .userLogOut();
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Text buildTextForm(
      {final String text, @optionalTypeArgs var style = kLabelTextStyle}) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: style,
    );
  }
}
