import 'package:animations/animations.dart';
import 'package:base/common/cardWidgets.dart';
import 'package:base/pages/selected_item_page/selected_item_page.dart';
import 'package:base/states/login_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({
    Key key,
    @required this.textStyle,
  }) : super(key: key);

  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    Map<String, dynamic> _userParams;
    String _documento = '';

    final List<String> Titulos = [
      'Consentimientos Informados',
      'Certificados Seguro',
      'Estado de Cuenta',
      'Actualice sus Datos'
    ];

    final List<String> subTitulos = [
      'Descarga de Archivos',
      'Certificado de Poliza de Seguro',
      'Administre su estado de cuenta y autorizaciones',
      'Para poder comunicarnos'
    ];

    final List<String> Trailing = [
      '',
      (Provider.of<LoginState>(context).getAceptoSeguro() == 9)
          ? 'Confirme si Acepta o Rechaza el Seguro'
          : '',
      (Provider.of<LoginState>(context).getSaldo() > 0)
          ? 'Usted posee un saldo pendiente\nen su Cuenta'
          : '',
      ''
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF0164A2),
              const Color(0xFF0B516B),
              const Color(0xFF014F7D),
            ], // whitish to gray
            //-tileMode: TileMode.repeated, // repeats the gradient over the canvas
          )),
          height: height * .06,
          child: Padding(
            padding: const EdgeInsets.only(top: 8, left: 30),
            child: Text(
              'Dr. ' +
                  capitalize(
                    Provider.of<LoginState>(context).getApellido(),
                  ) +
                  ', ' +
                  capitalize(
                    Provider.of<LoginState>(context).getNombre(),
                  ),
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.normal,
                fontSize: 16.0,
                letterSpacing: 1.4,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Divider(
          color: Colors.blueGrey.withOpacity(.2),
          thickness: 0.25,
          height: 0.25,
        ),
        Expanded(
          child: ListView.separated(
              itemCount: Titulos.length,
              separatorBuilder: (BuildContext context, int index) => Divider(
                    color: Colors.blue.withOpacity(.3),
                    thickness: 0.25,
                    height: 0.25,
                  ),
              itemBuilder: (BuildContext context, int index) {
                return OpenContainer(
                  openElevation: 2.0,
                  closedElevation: 2.0,
                  closedBuilder: (BuildContext _, VoidCallback openContainer) {
                    return ExampleCard(
                      openContainer: openContainer,
                      tittle: Titulos[index],
                      subTitle: subTitulos[index],
                      textTrailing: Trailing[index],
                    );
                  },
                  openBuilder: (context, action) {
                    return SelectedItemPage(seletedItem: index);
                  },
                );
              }),
        ),
      ],
    );
  }

  String capitalize(String s) =>
      s[0].toUpperCase() + s.substring(1).toLowerCase();

  ListTile buildListTile(int index) {
    return ListTile(
      title: Text(
        index.toString(),
        style: textStyle,
      ),
    );
  }
}
