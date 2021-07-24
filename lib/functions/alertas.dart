import 'package:flutter/material.dart';

void showMyDialog(
    {BuildContext context,
    String title = '',
    String line1 = '',
    String line2 = '',
    String boton = 'Ok'}) {
  showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                line1,
                textAlign: TextAlign.center,
              ),
              Text(
                line2,
                textAlign: TextAlign.center,

              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(boton),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void showMyDialogLink(
    {BuildContext context,
      String title = '',
      String line1 = '',
      String line2 = '',
      String boton = 'Ok',
      Function ontap}) {
  showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                line1,
                textAlign: TextAlign.center,
              ),
              Text(
                line2,
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                onPressed: ontap,
                child: Text('Asociese'),
              )
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(boton),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );

}
