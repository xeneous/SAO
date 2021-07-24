import 'package:base/constants.dart';
import 'package:flutter/material.dart';

class CreditCard extends StatelessWidget {
  final String fullName;
  final String number;
  final String urlImage;

  const CreditCard(
      {Key key,
      this.fullName,
      @optionalTypeArgs this.number,
      @optionalTypeArgs this.urlImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Material(
          borderRadius: BorderRadius.circular(16.0),
          elevation: 5.0,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.white54,
                border: Border.all(width: 1, color: kBotonColor)),
            width: 300,
            height: 200,
            child: Stack(
              children: [
                Positioned(
                  top: 18,
                  left: 18,
                  child: Image.network(
                      'https://www.sao.org.ar/templates/yootheme/cache/100anos-3-dbd9a50c.webp'),
                ),
                Positioned(
                  top: 120,
                  left: 20,
                  child: Text(
                    'Socio SAO: ' + number,
                    style: TextStyle(
                        color: kAppBarColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Positioned(
                    top: 150,
                    left: 20,
                    child: Text(
                      fullName,
                      style: TextStyle(
                          color: kBotonColor,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
