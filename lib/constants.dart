import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kFieldLoginTextStyle = TextStyle(
  color: kBotonColor,
  fontWeight: FontWeight.w400,
);

const kFieldLoginTextDecoration = InputDecoration(
  hintText: '',
  hintStyle: TextStyle(fontSize: 16.0, color: kBotonColor),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: kBotonColor),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: kBotonColor),
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kLoginDecoration = InputDecoration(
  hintText: '',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

// Estilo del texto de los botones
const kBotonLoginStyle = TextStyle(
  color: Colors.white,
  letterSpacing: 1.4,
  fontWeight: FontWeight.w600,
);
//
const kURLTextStyle = TextStyle(
  color: kBotonColor,
  letterSpacing: 1.4,
  fontWeight: FontWeight.w900,
);

const kAppBarColor = Color(0xFF0164A2);

const kBotonColor = Color(0xff0170A6);

const kLabelTextStyle =
    TextStyle(fontSize: 16.0, letterSpacing: 1.2, color: kBotonColor);

const kTitkeLabelListViewTextStyle = TextStyle(
    fontFamily: 'RobotoRegular',
    fontSize: 16.0,
    letterSpacing: 1.2,
    color: kBotonColor,
    fontWeight: FontWeight.w500);

const kCursosPrecio = TextStyle(
    fontFamily: 'RobotoRegular',
    fontSize: 24.0,
    letterSpacing: 1.2,
    color: kBotonColor,
    fontWeight: FontWeight.w500);

const kSubtitleTextStyle = TextStyle(
    fontSize: 14.0,
    letterSpacing: 1.1,
    color: Colors.black,
    fontFamily: 'RobotoRegular',
    fontWeight: FontWeight.w300);

TextStyle hoursPlayedLabelTextStyle = TextStyle(
  fontSize: 12,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

List<dynamic> knacionalidades = [
  {"idpais": "0", "gentilicio": " "},
  {"idpais": "1", "gentilicio": "ARGENTINA"},
  {"idpais": "2", "gentilicio": "BOLIVIANA"},
  {"idpais": "3", "gentilicio": "BRASILE??A"},
  {"idpais": "4", "gentilicio": "CHILENA"},
  {"idpais": "5", "gentilicio": "COLOMBIANA"},
  {"idpais": "6", "gentilicio": "ECUATORIANA"},
  {"idpais": "7", "gentilicio": "PARAGUAYA"},
  {"idpais": "8", "gentilicio": "PERUANA"},
  {"idpais": "9", "gentilicio": "URUGUAYA"},
  {"idpais": "10", "gentilicio": "VENEZOLANA"},
  {"idpais": "11", "gentilicio": "AFGANA"},
  {"idpais": "12", "gentilicio": "ALBANESA"},
  {"idpais": "13", "gentilicio": "ALEMANA"},
  {"idpais": "14", "gentilicio": "ANDORRANA"},
  {"idpais": "15", "gentilicio": "ANGOLE??A"},
  {"idpais": "16", "gentilicio": "ANTIGUANA"},
  {"idpais": "17", "gentilicio": "SAUD??"},
  {"idpais": "18", "gentilicio": "ARGELINA"},
  {"idpais": "19", "gentilicio": "ARMENIA"},
  {"idpais": "20", "gentilicio": "ARUBE??A"},
  {"idpais": "21", "gentilicio": "AUSTRALIANA"},
  {"idpais": "22", "gentilicio": "AUSTRIACA"},
  {"idpais": "23", "gentilicio": "AZERBAIYANA"},
  {"idpais": "24", "gentilicio": "BAHAME??A"},
  {"idpais": "25", "gentilicio": "BANGLADES??"},
  {"idpais": "26", "gentilicio": "BARBADENSE"},
  {"idpais": "27", "gentilicio": "BAREIN??"},
  {"idpais": "28", "gentilicio": "BELGA"},
  {"idpais": "29", "gentilicio": "BELICE??A"},
  {"idpais": "30", "gentilicio": "BENIN??SA"},
  {"idpais": "31", "gentilicio": "BIELORRUSA"},
  {"idpais": "32", "gentilicio": "BIRMANA"},
  {"idpais": "33", "gentilicio": "BOSNIA"},
  {"idpais": "34", "gentilicio": "BOTSUANA"},
  {"idpais": "35", "gentilicio": "BRUNEANA"},
  {"idpais": "36", "gentilicio": "B??LGARA"},
  {"idpais": "37", "gentilicio": "BURKIN??S"},
  {"idpais": "38", "gentilicio": "BURUND??SA"},
  {"idpais": "39", "gentilicio": "BUTAN??SA"},
  {"idpais": "40", "gentilicio": "CABOVERDIANA"},
  {"idpais": "41", "gentilicio": "CAMBOYANA"},
  {"idpais": "42", "gentilicio": "CAMERUNESA"},
  {"idpais": "43", "gentilicio": "CANADIENSE"},
  {"idpais": "44", "gentilicio": "CATAR??"},
  {"idpais": "45", "gentilicio": "CHADIANA"},
  {"idpais": "46", "gentilicio": "CHINA"},
  {"idpais": "47", "gentilicio": "CHIPRIOTA"},
  {"idpais": "48", "gentilicio": "VATICANA"},
  {"idpais": "49", "gentilicio": "COMORENSE"},
  {"idpais": "50", "gentilicio": "NORCOREANA"},
  {"idpais": "51", "gentilicio": "SURCOREANA"},
  {"idpais": "52", "gentilicio": "MARFILE??A"},
  {"idpais": "53", "gentilicio": "COSTARRICENSE"},
  {"idpais": "54", "gentilicio": "CROATA"},
  {"idpais": "55", "gentilicio": "CUBANA"},
  {"idpais": "56", "gentilicio": "DAN??SA"},
  {"idpais": "57", "gentilicio": "DOMINIQU??S"},
  {"idpais": "58", "gentilicio": "EGIPCIA"},
  {"idpais": "59", "gentilicio": "SALVADORE??A"},
  {"idpais": "60", "gentilicio": "EMIRAT??"},
  {"idpais": "61", "gentilicio": "ERITREA"},
  {"idpais": "62", "gentilicio": "ESLOVACA"},
  {"idpais": "63", "gentilicio": "ESLOVENA"},
  {"idpais": "64", "gentilicio": "ESPA??OLA"},
  {"idpais": "65", "gentilicio": "ESTADOUNIDENSE"},
  {"idpais": "66", "gentilicio": "ESTONIA"},
  {"idpais": "67", "gentilicio": "ET??OPE"},
  {"idpais": "68", "gentilicio": "FILIPINA"},
  {"idpais": "69", "gentilicio": "FINLAND??SA"},
  {"idpais": "70", "gentilicio": "FIYIANA"},
  {"idpais": "71", "gentilicio": "FRANC??SA"},
  {"idpais": "72", "gentilicio": "GABON??SA"},
  {"idpais": "73", "gentilicio": "GAMBIANA"},
  {"idpais": "74", "gentilicio": "GEORGIANA"},
  {"idpais": "75", "gentilicio": "GIBRALTARE??A"},
  {"idpais": "76", "gentilicio": "GHAN??SA"},
  {"idpais": "77", "gentilicio": "GRANADINA"},
  {"idpais": "78", "gentilicio": "GRIEGA"},
  {"idpais": "79", "gentilicio": "GROENLAND??SA"},
  {"idpais": "80", "gentilicio": "GUATEMALTECA"},
  {"idpais": "81", "gentilicio": "ECUATOGUINEANA"},
  {"idpais": "82", "gentilicio": "GUINEANA"},
  {"idpais": "83", "gentilicio": "GUINEANA"},
  {"idpais": "84", "gentilicio": "GUYANESA"},
  {"idpais": "85", "gentilicio": "HAITIANA"},
  {"idpais": "86", "gentilicio": "HONDURE??A"},
  {"idpais": "87", "gentilicio": "H??NGARA"},
  {"idpais": "88", "gentilicio": "HIND??"},
  {"idpais": "89", "gentilicio": "INDONESIA"},
  {"idpais": "90", "gentilicio": "IRAQU??"},
  {"idpais": "91", "gentilicio": "IRAN??"},
  {"idpais": "92", "gentilicio": "IRLAND??SA"},
  {"idpais": "93", "gentilicio": "ISLAND??SA"},
  {"idpais": "94", "gentilicio": "COOKIANA"},
  {"idpais": "95", "gentilicio": "MARSHAL??SA"},
  {"idpais": "96", "gentilicio": "SALOMONENSE"},
  {"idpais": "97", "gentilicio": "ISRAEL??"},
  {"idpais": "98", "gentilicio": "ITALIANA"},
  {"idpais": "99", "gentilicio": "JAMAIQUINA"},
  {"idpais": "100", "gentilicio": "JAPON??SA"},
  {"idpais": "101", "gentilicio": "JORDANA"},
  {"idpais": "102", "gentilicio": "KAZAJA"},
  {"idpais": "103", "gentilicio": "KENIATA"},
  {"idpais": "104", "gentilicio": "KIRGUISA"},
  {"idpais": "105", "gentilicio": "KIRIBATIANA"},
  {"idpais": "106", "gentilicio": "KUWAIT??"},
  {"idpais": "107", "gentilicio": "LAOSIANA"},
  {"idpais": "108", "gentilicio": "LESOTENSE"},
  {"idpais": "109", "gentilicio": "LET??NA"},
  {"idpais": "110", "gentilicio": "LIBAN??SA"},
  {"idpais": "111", "gentilicio": "LIBERIANA"},
  {"idpais": "112", "gentilicio": "LIBIA"},
  {"idpais": "113", "gentilicio": "LIECHTENSTEINIANA"},
  {"idpais": "114", "gentilicio": "LITUANA"},
  {"idpais": "115", "gentilicio": "LUXEMBURGU??SA"},
  {"idpais": "116", "gentilicio": "MALGACHE"},
  {"idpais": "117", "gentilicio": "MALASIA"},
  {"idpais": "118", "gentilicio": "MALAU??"},
  {"idpais": "119", "gentilicio": "MALDIVA"},
  {"idpais": "120", "gentilicio": "MALIENSE"},
  {"idpais": "121", "gentilicio": "MALT??SA"},
  {"idpais": "122", "gentilicio": "MARROQU??"},
  {"idpais": "123", "gentilicio": "MARTINIQU??S"},
  {"idpais": "124", "gentilicio": "MAURICIANA"},
  {"idpais": "125", "gentilicio": "MAURITANA"},
  {"idpais": "126", "gentilicio": "MEXICANA"},
  {"idpais": "127", "gentilicio": "MICRONESIA"},
  {"idpais": "128", "gentilicio": "MOLDAVA"},
  {"idpais": "129", "gentilicio": "MONEGASCA"},
  {"idpais": "130", "gentilicio": "MONGOLA"},
  {"idpais": "131", "gentilicio": "MONTENEGRINA"},
  {"idpais": "132", "gentilicio": "MOZAMBIQUE??A"},
  {"idpais": "133", "gentilicio": "NAMIBIA"},
  {"idpais": "134", "gentilicio": "NAURUANA"},
  {"idpais": "135", "gentilicio": "NEPAL??"},
  {"idpais": "136", "gentilicio": "NICARAG??ENSE"},
  {"idpais": "137", "gentilicio": "NIGERINA"},
  {"idpais": "138", "gentilicio": "NIGERIANA"},
  {"idpais": "139", "gentilicio": "NORUEGA"},
  {"idpais": "140", "gentilicio": "NEOZELAND??SA"},
  {"idpais": "141", "gentilicio": "OMAN??"},
  {"idpais": "142", "gentilicio": "NEERLAND??SA"},
  {"idpais": "143", "gentilicio": "PAKISTAN??"},
  {"idpais": "144", "gentilicio": "PALAUANA"},
  {"idpais": "145", "gentilicio": "PALESTINA"},
  {"idpais": "146", "gentilicio": "PANAME??A"},
  {"idpais": "147", "gentilicio": "PAP??"},
  {"idpais": "148", "gentilicio": "POLACA"},
  {"idpais": "149", "gentilicio": "PORTUGU??SA"},
  {"idpais": "150", "gentilicio": "PUERTORRIQUE??A"},
  {"idpais": "151", "gentilicio": "BRIT??NICA"},
  {"idpais": "152", "gentilicio": "CENTROAFRICANA"},
  {"idpais": "153", "gentilicio": "CHECA"},
  {"idpais": "154", "gentilicio": "MACEDONIA"},
  {"idpais": "155", "gentilicio": "CONGOLE??A"},
  {"idpais": "156", "gentilicio": "CONGOLE??A"},
  {"idpais": "157", "gentilicio": "DOMINICANA"},
  {"idpais": "158", "gentilicio": "SUDAFRICANA"},
  {"idpais": "159", "gentilicio": "RUAND??SA"},
  {"idpais": "160", "gentilicio": "RUMANA"},
  {"idpais": "161", "gentilicio": "RUSA"},
  {"idpais": "162", "gentilicio": "SAMOANA"},
  {"idpais": "163", "gentilicio": "CRISTOBALE??A"},
  {"idpais": "164", "gentilicio": "SANMARINENSE"},
  {"idpais": "165", "gentilicio": "SANVICENTINA"},
  {"idpais": "166", "gentilicio": "SANTALUCENSE"},
  {"idpais": "167", "gentilicio": "SANTOTOMENSE"},
  {"idpais": "168", "gentilicio": "SENEGAL??SA"},
  {"idpais": "169", "gentilicio": "SERBIA"},
  {"idpais": "170", "gentilicio": "SEYCHELLENSE"},
  {"idpais": "171", "gentilicio": "SIERRALEON??SA"},
  {"idpais": "172", "gentilicio": "SINGAPURENSE"},
  {"idpais": "173", "gentilicio": "SIRIA"},
  {"idpais": "174", "gentilicio": "SOMAL??"},
  {"idpais": "175", "gentilicio": "CEILAN??SA"},
  {"idpais": "176", "gentilicio": "SUAZI"},
  {"idpais": "177", "gentilicio": "SURSUDAN??SA"},
  {"idpais": "178", "gentilicio": "SUDAN??SA"},
  {"idpais": "179", "gentilicio": "SUECA"},
  {"idpais": "180", "gentilicio": "SUIZA"},
  {"idpais": "181", "gentilicio": "SURINAMESA"},
  {"idpais": "182", "gentilicio": "TAILAND??SA"},
  {"idpais": "183", "gentilicio": "TANZANA"},
  {"idpais": "184", "gentilicio": "TAYIKA"},
  {"idpais": "185", "gentilicio": "TIMORENSE"},
  {"idpais": "186", "gentilicio": "TOGOL??SA"},
  {"idpais": "187", "gentilicio": "TONGANA"},
  {"idpais": "188", "gentilicio": "TRINITENSE"},
  {"idpais": "189", "gentilicio": "TUNECINA"},
  {"idpais": "190", "gentilicio": "TURCOMANA"},
  {"idpais": "191", "gentilicio": "TURCA"},
  {"idpais": "192", "gentilicio": "TUVALUANA"},
  {"idpais": "193", "gentilicio": "UCRANIANA"},
  {"idpais": "194", "gentilicio": "UGAND??SA"},
  {"idpais": "195", "gentilicio": "UZBEKA"},
  {"idpais": "196", "gentilicio": "VANUATUENSE"},
  {"idpais": "197", "gentilicio": "VIETNAMITA"},
  {"idpais": "198", "gentilicio": "YEMEN??"},
  {"idpais": "199", "gentilicio": "YIBUTIANA"},
  {"idpais": "200", "gentilicio": "ZAMBIANA"},
  {"idpais": "201", "gentilicio": "ZIMBABUENSE"}
];

class Strings {
  static const String appName = 'Payment Card Demo';
  static const String fieldReq = 'This field is required';
  static const String numberIsInvalid = 'Card is invalid';
  static const String pay = 'Pay';
}
