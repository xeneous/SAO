import 'package:animations/animations.dart';
import 'package:base/common/notifywidgets.dart';
import 'package:base/pages/tabs/curso_ecografia.dart';
import 'package:base/pages/tabs/home_tab.dart';
import 'package:base/services/members.dart';
import 'package:base/states/login_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_screen';
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MemberModel memberData = new MemberModel();

  int _selectedIndex = 0;
  static final _textStyle =
      TextStyle(fontSize: 30,fontFamily: 'Montserrat', fontWeight: FontWeight.bold);

  static final _tabs = <Widget>[
    //HomeTab(textStyle: _textStyle),
    Curso(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      if (index == 1) {
        Provider.of<LoginState>(context, listen: false).userLogOut();
        _selectedIndex = 0;
      } else {
        _selectedIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
//    final _user = Provider.of<LoginState>(context).currentUser();
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.account_circle),
        title: Text(
          'SAO',
          style: TextStyle(letterSpacing: 1.5),
        ),
        backgroundColor: Color(0xFF0164A2),
        titleSpacing: 1.8,
        centerTitle: true,
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {},
              ),
              NotificationBubble(
                notifications: 0,
              )
            ],
          ),
        ],
      ),
      body: //
          FutureBuilder(
        future: Provider.of<LoginState>(context).getDatawasIdentified(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              return HomeBody(tabs: _tabs, selectedIndex: _selectedIndex);
            } else {
              return Center(child: new CircularProgressIndicator());
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.credit_card),
          //   title: Text('Credenciales'),
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            label: 'Cerrar',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF0B516B),
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({
    Key key,
    @required List<Widget> tabs,
    @required int selectedIndex,
  })  : _tabs = tabs,
        _selectedIndex = selectedIndex,
        super(key: key);

  final List<Widget> _tabs;
  final int _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return FadeThroughTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: _tabs[_selectedIndex],
      ),
    );
  }
}
