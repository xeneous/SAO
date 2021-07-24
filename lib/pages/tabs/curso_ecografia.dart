import 'package:base/constants.dart';
import 'package:base/services/members.dart';
import 'package:base/services/networking.dart';
import 'package:base/states/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:universal_html/html.dart' as html;


class Curso extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _cursoState createState() => _cursoState();
}

class _cursoState extends State<Curso> {

  initState() {

    const channelMercadoPagoRespuesta =
        const MethodChannel("canalNativoRespuesta");

    channelMercadoPagoRespuesta.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case 'mercadoPagoOK':
          var idPago = call.arguments[0];
          var status = call.arguments[1];
          var statusDetails = call.arguments[2];
          return mercadoPagoOK(idPago, status, statusDetails);
        case 'mercadoPagoError':
          var error = call.arguments[0];
          return mercadoPagoERROR(error);
      }
    });
    super.initState();
  }

  void CreamercadoPago({cuota, importe, preferenceId, concepto}) async {
    Map<String, dynamic> _userParams;
    _userParams = {
      'iduserapp': Provider.of<LoginState>(context, listen: false).getiduserapp(),
      'importe': importe,
      'cuota': cuota,
      'preference_id': preferenceId,
      'concepto': concepto
    };
    MemberModel users = MemberModel();
    bool received = await users.postJson(
        parameters: _userParams, urlSufix: '/abreMercadoPago.php');

  }

  void mercadoPagoOK(idPago, status, statusDetails) async {
    print("idPago $idPago");
    print("status $status");
    print("statusDetails $statusDetails");
    MemberModel socios = MemberModel();
    Map<String, dynamic> _userParams;
    _userParams = {
      'socio': Provider.of<LoginState>(context, listen: false).getSocio(),
      'idPago': idPago,
      'mpStatus': status,
      'importe': Provider.of<LoginState>(context, listen: false).getSaldo()
    };
    bool received = await socios.postJson(
        parameters: _userParams, urlSufix: '/pagoMercadoPago.php');
    setState(() {
      Provider.of<LoginState>(context, listen: false).setSaldo(0);
    });
    if (received) {
      Navigator.pop(context);
    }
  }

  void mercadoPagoERROR(error) {
    print("error $error");
  }

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final _cuota = Provider.of<LoginState>(context, listen: false).getSaldo().toDouble();
    final _precio = Provider.of<LoginState>(context, listen: false).getIsMember()==true ? 8000 : 24000;
    Provider.of<LoginState>(context, listen: false).setPago(_precio.toDouble());
    var status = true;
    var formatter = NumberFormat('#,##,000');

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: kAppBarColor,
          title: Text('EDUCACION SAO'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.indigo)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: screenHeight * .1,
                ),
                SizedBox(
                  height: screenHeight * .04,
                ),
                Center(
                  child: Text(
                    Provider.of<LoginState>(context).getApellido() +
                        ', ' +
                        Provider.of<LoginState>(context).getNombre(),
                    style: TextStyle(color: kAppBarColor, fontSize: 18.0),
                  ),
                ),
                SizedBox(
                  height: screenHeight * .04,
                ),
                // 1975735
                Center(
                  child: Text(
                    "Curso virtual de ecografia ocular 2021",
                    style: TextStyle(color: kAppBarColor, fontSize: 30.0, fontFamily: 'Montserrat'),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: screenHeight * .04,
                ),
                Center(
                  child: Container(
                    color: kAppBarColor,
                    padding: const EdgeInsets.all(8.2),
                    child: Text(
                      "Del 2 DE AGOSTO al 13 de DICIEMBRE 2021\n\nLUNES DE 19 a 21 HS\nHoras de Cursada: 34hs",
                      style: TextStyle(color:  Colors.white , backgroundColor:  kAppBarColor, fontSize: 18.0, fontFamily: 'Montserrat'),
                      textAlign: TextAlign.left,
                      softWrap: true
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * .08,
                ),
                Center(
                  child: Text(
                    (_precio != 0.0)
                        ? 'Valor Curso \$ ' + formatter.format(Provider.of<LoginState>(context, listen: false).getPago()).toString()
                        : 'UPS',
                    style: kCursosPrecio,
                  ),
                ),
              (_cuota>0) ? Center(
                  child: Text(
                    (_cuota != 0.0)
                        ? ' + Cuota Social \$ ' + formatter.format(Provider.of<LoginState>(context, listen: false).getSaldo()).toString() + '\n Total a Pagar ' + (_cuota+_precio).toString()
                        : 'UPS',
                    style: kCursosPrecio,
                  )
                ): SizedBox(
                  height: screenHeight * .01,
                ),
                SizedBox(
                  height: screenHeight * .05,
                ),
                Center(
                  child: Text(
                    (_precio != 0.0)
                        ? 'Formas de Pago Disponibles'
                        : '',
                    style: kTitkeLabelListViewTextStyle,
                  ),
                ),
                SizedBox(
                  height: screenHeight * .03,
                ),
                Center(
                  child: ElevatedButton(
                    child: Text('Pagar con Mercado Pago'),
                    onPressed: _precio+_cuota > 0 ? payButton : null,
                  ),
                ),
                SizedBox(
                  height: screenHeight * .06,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void payButton() async {
    final double _saldo=Provider.of<LoginState>(context, listen: false).getSaldo().toDouble();
    final double _curso=Provider.of<LoginState>(context, listen: false).getPago().toDouble();
    var _userParams = {
      'items': [
        {
          "title": "Cuota Social",
          "description": "Cuota Social SAO",
          "quantity": 1,
          "currency_id": "ARS",
          "unit_price": _saldo+_curso
        }
      ],
      "payer": {
        "name": Provider.of<LoginState>(context, listen: false).getNyap(),
        "email":
            Provider.of<LoginState>(context, listen: false).currentUser().email
      },
      "payment_methods": {
        "excluded_payment_types": [
          {"id": "ticket"},
          {"id": "atm"}
        ]
      },
      "back_urls": {
        "success": "https://www.administracionsao.com.ar//appwebsao//pagoMercadoPago.php",
        "pending": "https://www.administracionsao.com.ar//appwebsao//pagoMercadoPago.php",
        "failure": "https://www.administracionsao.com.ar//appwebsao//pagoMercadoPago.php"
      }

    };
    NetworkHelper networkHelper = NetworkHelper('https://administracionsao.com.ar//appwebsao//createorder.php');
    var response = await networkHelper.postJsonData(urlSufix: '',parameters: _userParams);
    var preferenceId = response["id"]; // preference id

    CreamercadoPago(preferenceId: preferenceId,concepto: 'Curso Virtual Ecografia',importe: Provider.of<LoginState>(context, listen: false).getPago(),cuota: Provider.of<LoginState>(context, listen: false).getSaldo());

    var mpUrl=response["init_point"];

    try {
      if (kIsWeb)
      {
        // var responseMP = await launchURL(url: mpUrl,);

        html.window.open(mpUrl,"_self");
      } else {
        const channelMercadoPago = const MethodChannel("canalNativo");
        final response = await channelMercadoPago
            .invokeMethod('mercadoPago', <String, dynamic>{
          "publicKey": "APP_USR-9b1031fd-9aee-4158-bc67-ff56c70e7075",
          "preferenceId": preferenceId
        });
        print(response);
      }

    } on PlatformException catch (e) {
      print(e.message);
      print(response);
    }
    var mpresponse = response;
    print(mpresponse);
    print(response);
  }
}
