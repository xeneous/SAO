import 'package:base/pages/tabs/certificados.dart';
import 'package:base/pages/tabs/consentimientos_tab.dart';
import 'package:base/pages/tabs/estadosocio.dart';
import 'package:base/pages/tabs/ficha.dart';
import 'package:base/states/login_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectedItemPage extends StatelessWidget {
  const SelectedItemPage({
    Key key,
    @required this.seletedItem,
  }) : super(key: key);

  final int seletedItem;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return itemSelector(selectedIndex: seletedItem, context: context);
          },
        ),
      ),
    );
  }
}

Widget itemSelector(
    {int selectedIndex,
    @optionalTypeArgs String url = '',
    BuildContext context}) {
  switch (selectedIndex) {
    case 0:
      {
        return new Consentimientos();
      }
      break;
    case 1:
      {
        return new Certificados(
          aceptaSeguro: Provider.of<LoginState>(context).getAceptoSeguro(),
        );
      }
      break;

    case 2:
      {
        return new EstadoSocio();
      }
      break;
    case 3:
      {
        return new Ficha();
      }
      break;
  }
  return Container();
}
