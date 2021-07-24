import 'package:base/constants.dart';
import 'package:base/pages/home_page.dart';
import 'package:base/pages/login_screen.dart';
import 'package:base/pages/registration_screen.dart';
import 'package:base/pages/tabs/ficha.dart';
import 'package:base/pages/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'pages/pre_home.dart';
import 'states/login_state.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static final String _empresa = 'Sociedad Argentina de Oftalmología';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginState>(
      create: (BuildContext context) => LoginState(),
      child: MaterialApp(
        title: _empresa,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en'),
          const Locale('es', 'AR'),
        ],
        theme:
            ThemeData(primarySwatch: Colors.blue, primaryColor: kAppBarColor),
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (BuildContext context) {
            var state = Provider.of<LoginState>(context, listen: true);
            if (state.isLoggedIn()) {
              if (state.isIdentified()) {
                  return HomePage();
              } else {
                Provider.of<LoginState>(context, listen: false)
                    .setFormType(FormType.Register);
                return Ficha(); // PreHomePage();
              }
            } else {
              switch (state.userLoginType()) {
                case LoginType.emailLogin:
                  {
                    return LoginScreen();
                  }
                  break;
                case LoginType.emailRegister:
                  {
                    return RegistrationScreen();
                  }
                  break;
                default:
                  {
                    return WelcomeScreen();
                  }
              }
            }
          },
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          HomePage.id: (context) => HomePage(),
        },
      ),
    );
  }
}
