import 'package:base/constants.dart';
import 'package:base/responsive.dart';
import 'package:base/states/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size _size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer(
        builder: (BuildContext context, LoginState value, Widget child) {
          if (value.isLoading()) {
            return Center(child: CircularProgressIndicator());
          } else {
            return child;
          }
        },
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: AspectRatio(
                          aspectRatio: _size.width>1100 ? 3 / 0.5 : 2/1,
                          child: Image.asset('images/logo.png'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  Center(
                      child: Text(
                        'Acceso con Email/Password',
                        style: kURLTextStyle,
                      )),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 65,
                    padding: EdgeInsets.symmetric(horizontal: 55.0, vertical: 14),
                    child: Material(
                      borderRadius: BorderRadius.circular(55.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: kBotonColor,),
                        onPressed: () {
                          Provider.of<LoginState>(context, listen: false)
                              .loginEmail();
                        },
                        child: Text(
                          'INGRESO',
                          style: kBotonLoginStyle,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 65,
                    padding: EdgeInsets.symmetric(horizontal: 55.0, vertical: 14.0),
                    child: Material(
                      /*color: Colors.blue,*/
                      borderRadius: BorderRadius.circular(08.0),
                      elevation: 5.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: kBotonColor,),
                        onPressed: () async {
                          Provider.of<LoginState>(context, listen: false)
                              .registerEmail();
                        },
                        child: Text(
                          'NUEVO USUARIO',
                          style: kBotonLoginStyle,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 5.0),
                        child: new ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: kBotonColor,elevation: 5.0,padding:
                            EdgeInsets.only(top: 3.0, bottom: 3.0, left: 3.0)),
                            onPressed: () async {
                              await Provider.of<LoginState>(context, listen: false)
                                  .googleSignIn();
                            },
                            child: new Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new Image.asset(
                                  'images/google.jpg',
                                  height: 30.0,
                                ),
                                new Container(
                                    padding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                    child: new Text(
                                      "Acceso con Google",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
      ),
    );
  }
}
