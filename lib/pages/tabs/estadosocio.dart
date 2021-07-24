import 'package:base/constants.dart';
import 'package:base/pages/tabs/tarjetaCredito.dart';
import 'package:base/services/members.dart';
import 'package:base/services/networking.dart';
import 'package:base/states/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EstadoSocio extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _EstadoSocioState createState() => _EstadoSocioState();
}

class _EstadoSocioState extends State<EstadoSocio> {
  // Widget _bottomAction(IconData icon, Function callback) {
  //   return InkWell(
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Icon(icon),
  //     ),
  //     onTap: callback,
  //   );
  // }

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
//    final user = Provider.of<LoginState>(context).currentUser();

    final screenHeight = MediaQuery.of(context).size.height;
    //final screenWidth = MediaQuery.of(context).size.width;
    //final logoHeight = screenHeight * 0.06;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: kAppBarColor,
          title: Text('SAO'),
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
//                Center(
//                  child: Text(
//                    'Socio SAO ' +
//                        Provider.of<LoginState>(context).getSocio().toString(),
//                    style: TextStyle(color: kAppBarColor),
//                  ),
//                ),
                SizedBox(
                  height: screenHeight * .04,
                ),
                Center(
                  child: Text(
                    Provider.of<LoginState>(context).getApellido() +
                        ', ' +
                        Provider.of<LoginState>(context).getNombre(),
                    style: TextStyle(color: kAppBarColor, fontSize: 16.0),
                  ),
                ),
                SizedBox(
                  height: screenHeight * .04,
                ),
                // 1975735
                Center(
                  child: Text(
                    "ESTADO DE CUENTA:",
                    style: TextStyle(color: kAppBarColor, fontSize: 12.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: screenHeight * .06,
                ),
                Center(
                  child: Text(
                    (Provider.of<LoginState>(context).getSaldo().toInt() != 0.0)
                        ? Provider.of<LoginState>(context).getSaldo().toString()
                        : 'Al día',
                    style: kTitkeLabelListViewTextStyle,
                  ),
                ),
                SizedBox(
                  height: screenHeight * .06,
                ),
                Center(
                  child: Text(
                    (Provider.of<LoginState>(context).getSaldo().toInt() != 0.0)
                        ? 'Formas de Pago Disponibles'
                        : '',
                    style: kTitkeLabelListViewTextStyle,
                  ),
                ),
                SizedBox(
                  height: screenHeight * .06,
                ),
                Center(
                  child: RaisedButton(
                    child: Text('Pagar con Mercado Pago'),
                    onPressed: (Provider.of<LoginState>(context).getSaldo() > 0)
                        ? payButton
                        : null,
                  ),
                ),
                SizedBox(
                  height: screenHeight * .06,
                ),
                Center(
                  child: RaisedButton(
                    child: Text('Adhesion al Debito Automatico'),
                    onPressed: (Provider.of<LoginState>(context).getSaldo() > 0)
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => datosTarjeta()),
                            );
                          }
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void payButton() async {
    var _userParams = {
      'items': [
        {
          "title": "Cuota Social",
          "description": "Cuota Social SAO",
          "quantity": 1,
          "currency_id": "ARS",
          "unit_price":
              Provider.of<LoginState>(context, listen: false).getSaldo()
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
      }
    };
    NetworkHelper networkHelper = NetworkHelper('');
    var response = await networkHelper.postJsonGetJsonData(
        urlSufix: 'http://administracionsao.com.ar/appwebsao/createorder.php',
        parameters: _userParams);
    var preferenceId = response["id"]; // preference id
    try {
      const channelMercadoPago = const MethodChannel("canalNativo");
      final response = await channelMercadoPago
          .invokeMethod('mercadoPago', <String, dynamic>{
        "publicKey": "APP_USR-9b1031fd-9aee-4158-bc67-ff56c70e7075",
        "preferenceId": preferenceId
      });
      print(response);
    } on PlatformException catch (e) {
      print(e.message);
      print(response);
    }
    var mpresponse = response;
    print(mpresponse);
    print(response);
  }
}
