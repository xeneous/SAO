import 'package:base/common/creditCard.dart';
import 'package:base/states/login_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CredencialeslTab extends StatelessWidget {
  const CredencialeslTab({
    Key key,
    @required this.textStyle,
  }) : super(key: key);

  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CreditCard(
          fullName: Provider.of<LoginState>(context, listen: false).getNyap(),
          number: Provider.of<LoginState>(context, listen: false)
              .getSocio()
              .toString(),
        ),
      ],
    );
  }
}
