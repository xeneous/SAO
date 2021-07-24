import 'package:base/common/LoginFormFIelds.dart';
import 'package:base/constants.dart';
import 'package:base/functions/alertas.dart';
import 'package:base/functions/validator.dart';
import 'package:base/states/login_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 42.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                                bool enter = await Provider.of<LoginState>(
                                        context,
                                        listen: false)
                                    .emailSignUp(_email, _password);
                                if (!enter) {
                                  showMyDialog(
                                      context: context,
                                      title: 'Nuevo Usuario',
                                      line1:
                                          'Email y/o Passwords Incorrectos o ya existentes',
                                      boton: 'Ok');
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
                                  title: 'Atencion',
                                  line1: _msgText);
                            }
                          },
                          minWidth: 200.0,
                          height: 42.0,
                          child: Text(
                            'REGISTRARSE',
                            style: TextStyle(
                                color: Colors.white, letterSpacing: 1.2),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    // FlatButton(
                    //   onPressed: () async {
                    //     bool l =
                    //         await Provider.of<LoginState>(context, listen: false)
                    //             .toWelcomeScreen();
                    //     return l;
                    //   },
                    //   child: Text(
                    //     'Atras',
                    //     style: kURLTextStyle,
                    //   ),
                    // )
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
