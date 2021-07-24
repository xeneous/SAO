import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL({@required String url}) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
