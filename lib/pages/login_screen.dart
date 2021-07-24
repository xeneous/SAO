import 'package:base/common/LoginFormFIelds.dart';
import 'package:base/constants.dart';
import 'package:base/functions/alertas.dart';
import 'package:base/functions/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../states/login_state.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email;
  String _password;

  bool _emailOk = false;
  bool _passOk = false;

  String _msgText = '';

  bool _passwordVisible = true;
  IconData iData = Icons.visibility;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool l = await Provider.of<LoginState>(context, listen: false)
            .toWelcomeScreen();
        return l;
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 42.0),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildLogo(),
                TextField(
                  onChanged: (value) {
                    _email = value;
                    _emailOk = validateEmail(value);
                    setState(() {});
                  },
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  style: kFieldLoginTextStyle,
                  decoration: kFieldLoginTextDecoration.copyWith(
                    hintText: 'Ingrese su email',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  obscureText: _passwordVisible,
                  onChanged: (value) {
                    _password = value;
                    _passOk = _password.length > 5;
                    setState(() {});
                  },
                  decoration: kFieldLoginTextDecoration.copyWith(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                          icon: Icon(iData),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                              if (_passwordVisible)
                                iData = Icons.visibility_off;
                              else
                                iData = Icons.visibility;
                            });
                          })),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    color: kBotonColor,
                    borderRadius: BorderRadius.all(Radius.circular(04.0)),
                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: () async {
                        if (_emailOk && _passOk) {
                          try {
                            bool enter = await Provider.of<LoginState>(context,
                                    listen: false)
                                .emailSignIn(_email, _password);
                            if (!enter) {
                              showMyDialog(
                                  context: context,
                                  boton: 'ok',
                                  title: 'Ingreso con su email y contraseña',
                                  line1:
                                      'Email y/o Passwords\nIncorrectos o Inexistentes',
                                  line2: '');
                            }
                          } catch (e) {}
                        } else {
                          _msgText = '';
                          if (!_emailOk) {
                            _msgText = _msgText +
                                'Email incorrecto\nDebe ingresar un email valido\n';
                          }
                          if (!_passOk) {
                            _msgText = _msgText +
                                'Password incorrecto\ndebe tener mas de 5 letras';
                          }
                          showMyDialog(
                              context: context,
                              boton: 'ok',
                              title: 'Atencion',
                              line1: _msgText,
                              line2: '');
                        }
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Ingreso con Email',
                        style: kBotonLoginStyle,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                // FlatButton(
                //   onPressed: () async {
                //     SystemChannels.textInput.invokeMethod('TextInput.hide');
                //     bool l =
                //         await Provider.of<LoginState>(context, listen: false)
                //             .toWelcomeScreen();
                //     return true;
                //   },
                //   child: Text(
                //     'Atras',
                //     style: kURLTextStyle,
                //   ),
                // ),
              ],
            ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
