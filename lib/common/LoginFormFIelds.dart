import 'package:flutter/material.dart';

class buildLogo extends StatelessWidget {
  const buildLogo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size=MediaQuery.of(context).size;
    return AspectRatio(
      aspectRatio: _size.width>1100 ? 3 / 0.5 : 2/1,
      child: Image.asset('images/logo.png'),
    );
  }
}
