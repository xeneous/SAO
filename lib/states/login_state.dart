import 'package:base/services/members.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LoginType { welcomeScreen, Google, emailRegister, emailLogin }
enum FormType { Register, NewMember, Update }

class LoginState with ChangeNotifier {
  // variables de firebase
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;

  SharedPreferences _sharedPreferences;

  bool _isLoggedIn = false;

  bool _isIdentified = false; // Elige identificarse
  bool _isAnonymous = false; // Elige no identificarse
  bool _isMember = false; // es Miembro

  bool _loading = true;
  String _loginError = '';
  LoginType _loginType = LoginType.welcomeScreen;
  FormType _formType=FormType.Register;

  int _socio = 0;
  int getSocio() => _socio;

  int _iduserapp = 0;
  int getiduserapp() => _iduserapp;

  String _nacionalidad = '';
  String getNacionalidad() => _nacionalidad;

  String _tipodocumento;
  String getTipoDocumento() => _tipodocumento;

  String _nombre = '';
  String getNombre() => _nombre;

  String _apellido = '';
  String getApellido() => _apellido;

  String _domicilio = '';
  String getDomicilio() => _domicilio;

  String _localidad = '';
  String getLocalidad() => _localidad;

  String _provincia = '';
  String getProvincia() => _provincia;

  String _codigopostal = '';
  String getCodigoPostal() => _codigopostal;

  int _idPais = 0;
  int getidPais() => _idPais;

  String getNyap() => _apellido + ', ' + _nombre;

  double _saldo = 0.0;
  double getSaldo() => _saldo;

  void setSaldo(double value) {
    _saldo = value;
    notifyListeners();
  }

  double _pago = 0.0;
  double getPago() => _pago;
  void setPago(double value) {
    _pago = value;
  }

  String _documento;
  String getDocumento() => _documento == null ? '' : _documento;

  int _residente = 0;
  int getResidente() => _residente;

  String _inicioResidencia = '';
  String getInicioResidencia() => _inicioResidencia;

  String _nacio = '';
  String getNacio() => _nacio;

  String _matricula;
  String getMatricula() => _matricula == null ? '' : _matricula;

  String _matriculaprovincia;
  String getmatriculaProvincia() =>
      _matriculaprovincia == null ? '' : _matriculaprovincia;

  String _telefono = '';
  String getTelefono() => _telefono;

  String _urlCertificado = '';
  String geturlCertificado() => _urlCertificado;

  int _aceptoSeguro = 9; // 9 si no acepto
  int getAceptoSeguro() => _aceptoSeguro;
  void setAceptaSeguro(int value) {
    _aceptoSeguro = value;
    notifyListeners();
  }

  bool isLoggedIn() => _isLoggedIn;
  bool isLoading() => _loading;
  bool isAnonymous() => _isAnonymous;

  bool isIdentified() {
    if (_sharedPreferences.containsKey('isIdentified')) {
      _isIdentified = _sharedPreferences.getBool('isIdentified');
    } else {
      _isIdentified = false;
    }
    return _isIdentified;
  }

  //_isIdentified;
  bool isMember({bool esSocio,int socio}) {
    _isMember=esSocio;
    _socio=socio;
  }

  bool getIsMember() => _isMember;

  LoginType userLoginType() => _loginType;
  FormType uFormType() => _formType;
  String getLoginError() => _loginError;

  FirebaseUser currentUser() => _user;

  void setFormType(FormType formType)
  {
    _formType=formType;
  }

  LoginState() {
    loginState();
  }

  void googleSignIn() async {
    _loading = true;
    notifyListeners();

    try {
      _user = await _handleSignIn();
    } catch (e) {
      print(e);
      _isLoggedIn = false;
      notifyListeners();
    }

    _loading = false;

    if (_user != null) {
      _sharedPreferences.setBool('isLoggedIn', true);
      _isLoggedIn = true;
      bool _wasIdentified;
      _wasIdentified = await wasIdentified();
      if (_wasIdentified) {
        setIsIdentified(true);
      }
      notifyListeners();
    } else {
      _isLoggedIn = false;
      notifyListeners();
    }
  }

  void userLogOut() {
    _loginType = LoginType.welcomeScreen;
    _isIdentified = false;
    _sharedPreferences.clear();
    _googleSignIn.signOut();
    _isLoggedIn = false;
    signOut();
    notifyListeners();
  }

  Future<FirebaseUser> _handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    return user;
  }

  void loginEmail() {
    _loginType = LoginType.emailLogin;
    notifyListeners();
  }

  void registerEmail() {
    _loginType = LoginType.emailRegister;
    notifyListeners();
  }

  Future<bool> toWelcomeScreen() async {
    _loginType = LoginType.welcomeScreen;
    notifyListeners();
    return false;
  }

  Future<bool> emailSignIn(String email, String password) async {
    _loading = true;
    try {
      AuthResult authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _user = authResult.user;
    } catch (e) {
      _loginError = e.code;
      _user = null;
    }
    _loading = false;
    if (_user != null) {
      _sharedPreferences.setBool('isLoggedIn', true);
      _isLoggedIn = true;
      bool _wasIdentified;
      _wasIdentified = await wasIdentified();
      if (_wasIdentified) {
        setIsIdentified(true);
      }
      notifyListeners();
      return true;
    } else {
      _isLoggedIn = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> emailSignUp(String email, String password) async {
    _loading = true;
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      _user = authResult.user;
    } catch (e) {
      _loginError = e.code;
      _user = null;
    }

    _loading = false;
    if (_user != null) {
      _sharedPreferences.setBool('isLoggedIn', true);
      _isLoggedIn = true;
      bool _wasIdentified;
      _wasIdentified = await wasIdentified();
      if (_wasIdentified) {
        setIsIdentified(true);
      }
      notifyListeners();
      return true;
    } else {
      _isLoggedIn = false;
      notifyListeners();
      return false;
    }
  }

  Future signOut() async {

    _user = null;
    _auth.signOut();
    _apellido = '';
    _nombre = '';
    _tipodocumento = '';
    _documento = '';
    _nacionalidad = '';
    _nacio = '';
    _matricula = '';
    _matriculaprovincia = '';
    _domicilio = '';
    _localidad = '';
    _codigopostal = '';
    _provincia = '';
    _saldo = 0;
    _socio = 0;
    _aceptoSeguro = null;
    _telefono = '';
    _urlCertificado = '';
    _residente = null;
    _inicioResidencia = '19000101';

    notifyListeners();
    return Future.delayed(Duration.zero);

  }

  void loginState() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    if (_sharedPreferences.containsKey('isLoggedIn')) {
      _user = await _auth.currentUser();
      _isIdentified = _sharedPreferences.containsKey('isIdentified');
      _isLoggedIn = _user != null;
      _loading = false;
      notifyListeners();
    } else {
      _loading = false;
      notifyListeners();
    }
  }

  void setIsIdentified(bool identified) async {
    _isIdentified = identified;
    _sharedPreferences.setBool('isIdentified', true);
    notifyListeners();
  }

  void setIsNotIdentified() async {
    _isIdentified = false;
    _sharedPreferences.setBool('isIdentified', false);
    notifyListeners();
  }

  Future<bool> wasIdentified() async {
    String _userParams = 'e=' + _user.email;
    MemberModel member = MemberModel();
    bool isIdentified = await member.getWasIdentified(
        urlSufix: '//wswasidentified.php', parameters: _userParams);
    return isIdentified;
  }

  Future<dynamic> getDatawasIdentified() async {
    String _userParams = 'e=' + _user.email;
    MemberModel member = MemberModel();
    dynamic data = await member.getWasIdentifiedData(
        urlSufix: '//wswasidentifiedgetData.php', parameters: _userParams);
    if (data[0]['documento']!='0') {
      _apellido = data[0]['apellido'];
      _nombre = data[0]['nombre'];
      _tipodocumento = data[0]['tipodocumento'];
      _documento = data[0]['documento'];
      _nacionalidad = data[0]['nacionalidad']?? '';
      _nacio = data[0]['nacio']?? '';
      _matricula = data[0]['matricula']?? '';
      _matriculaprovincia = data[0]['matriculaprovincia']?? '';
      _domicilio = data[0]['domicilio']?? '';
      _localidad = data[0]['localidad']?? '';
      _codigopostal = data[0]['codigopostal']?? '';
      _provincia = data[0]['provincia'] ?? '';
      _saldo = double.parse(data[0]['saldo'] ?? 0);
      _socio = int.parse(data[0]['socio']) ?? 0;
      _iduserapp = int.parse(data[0]['iduserapp']);
      _isMember= data[0]['grupo']=='S' ? true : false;
      _aceptoSeguro = int.parse(data[0]['aceptoSeguro'] ?? false);
      _telefono = data[0]['celular'] ?? 0;
      _urlCertificado = data[0]['urlCertificado'] ?? '';
      _residente = int.parse(data[0]['residente'] ?? '0');
      _inicioResidencia = data[0]['inicioresidencia'].toString() ?? '19000101';
    } else {
      setIsNotIdentified();
      notifyListeners();
    }
    return data;
  }

  Future<bool> wasIdentifiedCors() async {
    Map<String, dynamic> _userParams = {'email': _user.email};
    MemberModel member = MemberModel();
    bool isIdentified = await member.getWasIdentified_Cors(
        urlSufix: '//wswasidentified.php', parameters: _userParams);
    return isIdentified;
  }

  Future<dynamic> getDatawasIdentifiedCors() async {
    Map<String, dynamic> _userParams = {'email': _user.email};
    MemberModel member = MemberModel();
    dynamic data = await member.getWasIdentifiedDataCors(
        urlSufix: '//wswasidentifiedgetData.php', parameters: _userParams);
    _apellido = data[0]['apellido'];
    _nombre = data[0]['nombre'];
    _tipodocumento = data[0]['tipodocumento'];
    _documento = data[0]['documento'];
    _nacionalidad = data[0]['nacionalidad'];
    _nacio = data[0]['nacio'];
    _matricula = data[0]['matricula'];
    _matriculaprovincia = data[0]['matriculaprovincia'];
    _domicilio = data[0]['domicilio'];
    _localidad = data[0]['localidad'];
    _codigopostal = data[0]['codigopostal'];
    _provincia = data[0]['provincia'];
    _saldo = double.parse(data[0]['saldo']);
    _socio = int.parse(data[0]['socio']);
    _aceptoSeguro = int.parse(data[0]['aceptoSeguro']);
    _telefono = data[0]['celular'];
    _urlCertificado = data[0]['urlCertificado'];
    _residente = data[0]['residente'];
    _inicioResidencia = data[0]['inicioresidencia'].toString();
    return data;
  }
}
