import 'package:base/functions/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key key,
    @required TextEditingController fieldController,
    this.labelText,
    this.labelError = 'No es un campo opcional',
    this.textInputType = TextInputType.text,
    this.onSaveCallback,
    this.boolReadOnly=false,
  })  : _fieldController = fieldController,
        super(key: key);

  final TextEditingController _fieldController;
  final String labelText, labelError;
  final TextInputType textInputType;
  final Function onSaveCallback;
  final bool boolReadOnly;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: TextStyle(
            fontSize: 14.0, fontFamily: 'Roboto', fontWeight: FontWeight.w700),
        keyboardType: textInputType,
        readOnly: boolReadOnly,
        maxLength: 40,
        controller: _fieldController,
        onSaved: onSaveCallback,

        inputFormatters: [
          UpperCaseTextFormatter(),
          FilteringTextInputFormatter.allow(RegExp(r"[A-Z0-9 -]+"))
        ],
        decoration: InputDecoration(
            labelText: labelText,
            counterStyle: TextStyle(
              height: double.minPositive,
            ),
            counterText: ""),
        validator: (value) => value.isNotEmpty ? null : labelError);
  }
}
