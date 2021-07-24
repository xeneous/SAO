import 'dart:io';

import 'package:base/functions/formatters.dart';
import 'package:base/input_formatters.dart';
import 'package:base/my_strings.dart';
import 'package:base/payment_card.dart';
import 'package:base/services/members.dart';
import 'package:base/states/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class datosTarjeta extends StatefulWidget {
  datosTarjeta({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _datosTarjetaState createState() => new _datosTarjetaState();
}

class _datosTarjetaState extends State<datosTarjeta> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _formKey = new GlobalKey<FormState>();
  var numberController = new TextEditingController();
  var _paymentCard = PaymentCard();
  var _autoValidate = false;

  var _card = new PaymentCard();

  @override
  void initState() {
    super.initState();
    _paymentCard.type = CardType.Others;
    numberController.addListener(_getCardTypeFrmNumber);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          title: new Text('Adhesion Debito Automatico'),
        ),
        body: new Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: new Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: new ListView(
                children: <Widget>[
                  new SizedBox(
                    height: 20.0,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      border: const UnderlineInputBorder(),
                      filled: true,
                      icon: const Icon(
                        Icons.person,
                        size: 40.0,
                      ),
                      hintText: 'Nombre como figura en la tarjeta',
                      labelText: 'Nombre en la tarjeta',
                    ),
                    onSaved: (String value) {
                      _paymentCard.name = value;
                    },
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                      FilteringTextInputFormatter.allow(RegExp(r"[A-Z0-9 -]+"))
                    ],
                    validator: (String value) =>
                        value.isEmpty ? Strings.fieldReq : null,
                  ),
                  new SizedBox(
                    height: 30.0,
                  ),
                  new TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      new LengthLimitingTextInputFormatter(19),
                      new CardNumberInputFormatter()
                    ],
                    controller: numberController,
                    decoration: new InputDecoration(
                      border: const UnderlineInputBorder(),
                      filled: true,
                      icon: CardUtils.getCardIcon(_paymentCard.type),
                      hintText: 'Numero de tarjeta',
                      labelText: 'Numero de tarjeta',
                    ),
                    onSaved: (String value) {
                      print('onSaved = $value');
                      print('Num controller has = ${numberController.text}');
                      _paymentCard.number = CardUtils.getCleanedNumber(value);
                    },
                    validator: CardUtils.validateCardNum,
                  ),
                  // new SizedBox(
                  //   height: 30.0,
                  // ),
                  // new TextFormField(
                  //   inputFormatters: [
                  //     WhitelistingTextInputFormatter.digitsOnly,
                  //     new LengthLimitingTextInputFormatter(4),
                  //   ],
                  //   decoration: new InputDecoration(
                  //     border: const UnderlineInputBorder(),
                  //     filled: true,
                  //     icon: new Image.asset(
                  //       'assets/images/card_cvv.png',
                  //       width: 40.0,
                  //       color: Colors.grey[600],
                  //     ),
                  //     hintText: 'Number behind the card',
                  //     labelText: 'CVV',
                  //   ),
                  //   validator: CardUtils.validateCVV,
                  //   keyboardType: TextInputType.number,
                  //   onSaved: (value) {
                  //     _paymentCard.cvv = int.parse(value);
                  //   },
                  // ),
                  new SizedBox(
                    height: 30.0,
                  ),
                  new TextFormField(
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      new LengthLimitingTextInputFormatter(4),
                      new CardMonthInputFormatter()
                    ],
                    decoration: new InputDecoration(
                      border: const UnderlineInputBorder(),
                      filled: true,
                      icon: Icon(
                        Icons.calendar_today,
                        size: 40.0,
                      ),
                      hintText: 'MM/AA',
                      labelText: 'Fecha Expiracion MM/AA',
                    ),
                    validator: CardUtils.validateDate,
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      List<int> expiryDate = CardUtils.getExpiryDate(value);
                      _paymentCard.month = expiryDate[0];
                      _paymentCard.year = expiryDate[1];
                    },
                  ),
                  new SizedBox(
                    height: 50.0,
                  ),
                  new Container(
                    alignment: Alignment.center,
                    child: _getPayButton(),
                  )
                ],
              )),
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    numberController.removeListener(_getCardTypeFrmNumber);
    numberController.dispose();
    super.dispose();
  }

  void _getCardTypeFrmNumber() {
    String input = CardUtils.getCleanedNumber(numberController.text);
    CardType cardType = CardUtils.getCardTypeFrmNumber(input);
    setState(() {
      this._paymentCard.type = cardType;
    });
  }

  void _validateInputs() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      setState(() {
        _autoValidate = true; // Start validating on every change.
      });
      _showInSnackBar('Por favor corrija los errores para continuar.');
    } else {
      form.save();
      // Encrypt and send send payment details to payment gateway
      _showInSnackBar('Adhesion al debito Completada');

      MemberModel socios = MemberModel();
      Map<String, dynamic> _userParams;
      _userParams = {
        'socio': Provider.of<LoginState>(context, listen: false).getSocio(),
        'c0': _paymentCard.number,
        'c1': _paymentCard.name,
        'c2': _paymentCard.month.toString() + '/' + _paymentCard.year.toString()
      };
      bool received = await socios.postJson(
          parameters: _userParams, urlSufix: '/adhesion.php');
      setState(() {
        Provider.of<LoginState>(context, listen: false).setSaldo(0);
      });

      Navigator.pop(context);
    }
  }

  Widget _getPayButton() {
    if (Platform.isIOS) {
      return new CupertinoButton(
        onPressed: _validateInputs,
        color: CupertinoColors.activeBlue,
        child: const Text(
          Strings.pay,
          style: const TextStyle(fontSize: 17.0),
        ),
      );
    } else {
      return new RaisedButton(
        onPressed: _validateInputs,
        color: Colors.blue,
        splashColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(const Radius.circular(100.0)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 80.0),
        textColor: Colors.white,
        child: new Text(
          Strings.pay.toUpperCase(),
          style: const TextStyle(fontSize: 17.0),
        ),
      );
    }
  }

  void _showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
      duration: new Duration(seconds: 3),
    ));
  }
}
