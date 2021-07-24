import 'package:base/common/customDropDown.dart';
import 'package:base/common/customTextFormField.dart';
import 'package:base/constants.dart';
import 'package:base/functions/alertas.dart';
import 'package:base/services/members.dart';
import 'package:base/states/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Ficha extends StatefulWidget {
  @override
  _FichaState createState() => _FichaState();
}

enum SingingCharacter { Si, No }

SingingCharacter _character;

class _FichaState extends State<Ficha> {
  final _formKey = GlobalKey<FormState>();
  FocusNode myFocusNode;

  final _url = 'https://www.sao.org.ar/socios/asociese';
  void _launchURL() async {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
    Navigator.of(context).pop();
    Provider.of<LoginState>(context, listen: false).userLogOut();
  }

//  DateTime _selectedDateNacio = DateTime.now();
  MemberModel socios = MemberModel();

  DateTime _today = DateTime.now();

  TextEditingController _emailController;
  String _email;
  TextEditingController _telefonoController;
  String _telefono;
  TextEditingController _nombreController;
  String _nombre;
  TextEditingController _apellidoController;
  String _apellido;
  TextEditingController _nacionalidadController;
  String _nacionalidad;
  TextEditingController _nacioController;
  String _nacio; // _0 _no _1 _si
  TextEditingController _tipoDocumentoController;
  int _tipoDocumento;
  TextEditingController _documentoController;
  int _documento;
  TextEditingController _domicilioController;
  String _domicilio;
  TextEditingController _localidadController;
  String _localidad;
  TextEditingController _codigoPostalController;
  String _codigoPostal;
  TextEditingController _provinciaController;
  String _provincia;
  TextEditingController _paisController;
  String _pais;
  TextEditingController _celularController;
  String _celular;
  TextEditingController _matriculaNacionalController;
  String _matriculaNacional;
  TextEditingController _matriculaProvincialController;
  String _matriculaProvincial;
  TextEditingController _residenteController;
  int _residente; // _0 _no _1 _si
  TextEditingController _inicioResidenciaController;
  String _inicioResidencia; // _0 _no _1 _si
  String _naciodate, _inicioresidenciadate;
  TextEditingController _aceptaseguroController;
  int _aceptaSeguro;

  List<String> added = [];
  String currentText = "";

  @override
  void initState() {
    myFocusNode = FocusNode();
    myFocusNode.addListener(() async {
      if (!myFocusNode.hasFocus) {
        String _userParams = _documentoController.text;
        MemberModel member = MemberModel();
        // TODO: ver si ya existe en sociosApp
        // ver si es Socio el Documento
        var memberdata = await member.getDocumento(
            urlSufix: '//wsismember.php', document: _userParams);
        final _saldo = memberdata[0]['saldo'];
        // Provider.of<LoginState>(context, listen: false).setSaldo(_saldo);
        if (Provider.of<LoginState>(context, listen: false).uFormType() ==
            FormType.Register) {
          if (memberdata[0]['socioapp'] != '0') {
            showMyDialog(
                context: context,
                title: 'Registro Nuevo Usuario',
                line1: 'Documento asociado a otro email',
                boton: 'OK');
          } else if (memberdata[0]['Grupo'] == 'S') {
            if (double.parse(_saldo) == 0.00) {
              Provider.of<LoginState>(context, listen: false).isMember(
                  esSocio: true, socio: int.parse(memberdata[0]['socio']));
              showMyDialog(
                  context: context,
                  title: 'Socio SAO',
                  line1: 'Bienvenido al portal Administrativo',
                  boton: 'OK');
            } else {
              final int _years=int.parse(memberdata[0]['years']);
              if ( _years< 3) {
                Provider.of<LoginState>(context, listen: false).isMember(
                    esSocio: true, socio: int.parse(memberdata[0]['socio']));
                showMyDialog(
                    context: context,
                    title: 'Socio SAO',
                    line1: 'Bienvenido al portal Administrativo\n',
                    line2: 'Al abonar sumaremos el monto de \$' + _saldo + ' Correspondiente a Cuota Social',
                    boton: 'OK');
              } else {
                showMyDialog(
                    context: context,
                    title: 'Socio SAO',
                    line1: 'Bienvenido al portal Administrativo',
                    line2:
                        'Por favor comuniquese con nosotros para regularizar su estado.\ntesoreria@sao.org.ar',
                    boton: 'OK');
              }
            }
          } else {
            Provider.of<LoginState>(context, listen: false)
                .isMember(esSocio: false, socio: 0);
            showMyDialogLink(
                context: context,
                title: 'Beneficio Socio SAO',
                line1:
                    'Puede acceder a un valor preferencial asociandose a la SAO',
                boton: 'CONTINUE COMO NO SOCIO',
                ontap: _launchURL);
          }
        }

        setState(() {
          if (memberdata[0]['documento'] != '0') {
            _apellidoController.text = memberdata[0]['apellido'];
            _nombreController.text = memberdata[0]['nombre'];
            _tipoDocumento = 1;
            Provider.of<LoginState>(context, listen: false)
                .isMember(esSocio: true, socio: memberdata[0]['socio']);
          } else {
            _apellidoController.text = '';
            _nombreController.text = '';
            _tipoDocumento = 1;
          }
        });
      }
    });
    // TOD: implement initState
    super.initState();
    _apellidoController = TextEditingController(
        text: Provider.of<LoginState>(context, listen: false).getApellido());
    _nombreController = TextEditingController(
        text: Provider.of<LoginState>(context, listen: false).getNombre());
    _emailController = TextEditingController(
        text: Provider.of<LoginState>(context, listen: false)
            .currentUser()
            .email
            .toString());
    _documentoController = TextEditingController(
        text: Provider.of<LoginState>(context, listen: false)
            .getDocumento()
            .toString());
    _matriculaNacionalController = TextEditingController(
        text: Provider.of<LoginState>(context, listen: false)
            .getMatricula()
            .toString());
    _matriculaProvincialController = TextEditingController(
        text: Provider.of<LoginState>(context, listen: false)
            .getmatriculaProvincia()
            .toString());
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  void _submit() async {
    if (_validateAndSaveForm()) {
      try {
        Map<String, dynamic> _userParams;
        _userParams = {
          'socio': Provider.of<LoginState>(context, listen: false).getSocio(),
          'email': Provider.of<LoginState>(context, listen: false)
              .currentUser()
              .email,
          'apellido': _apellido,
          'nombre': _nombre,
          'documento': _documento,
          'tipodocumento': _tipoDocumento,
          'nacio': _naciodate == '' ? '19000101' : _naciodate,
          'nacionalidad': _nacionalidad,
          'domicilio': _domicilio,
          'codigopostal': _codigoPostal,
          'localidad': _localidad,
          'provincia': _provincia,
          'pais': _pais,
          'matricula': _matriculaNacional,
          'matriculaprovincia': _matriculaProvincial,
          'celular': _telefono,
          'residente': _residente,
          'inicioresidencia':
              _inicioresidenciadate == '' ? '19000101' : _inicioresidenciadate
        };

        bool received = await socios.postJson(
            parameters: _userParams, urlSufix: '/wsUpdateFichaData.php');
        if (received) {
          if (Provider.of<LoginState>(context, listen: false).getSocio() == 0) {
            Provider.of<LoginState>(context, listen: false)
                .setIsIdentified(true);
            Provider.of<LoginState>(context, listen: false)
                .getDatawasIdentified();
          }
        }
        if (Provider.of<LoginState>(context, listen: false).uFormType() ==
            FormType.Register) {
          Provider.of<LoginState>(context, listen: false).setIsIdentified(true);
        } else {
          Navigator.pop(context);
        }
        return;
      } catch (e) {
        print(e.toString());
      }
    }
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3.0,
        backgroundColor: kAppBarColor,
        title: Text(
          'INGRESE SUS DATOS',
          style: TextStyle(fontSize: 16.0, fontFamily: 'Roboto'),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: _submit,
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    final valueStyle = Theme.of(context).textTheme.headline1;
    return [
      CustomTextFormField(
        fieldController: _emailController,
        boolReadOnly: true,
        labelText: 'Email',
        onSaveCallback: (value) {
          setState(() {
            _email = value;
          });
        },
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: DropdownButtonFormField(
              isDense: true,
              decoration: InputDecoration(labelText: 'Tipo Documento'),
              value: 1,
              // _tipoDocumento,
              items: [
                DropdownMenuItem(
                  child: Text(
                    "Tipo Doc.",
                    style: TextStyle(color: Colors.grey),
                  ),
                  value: 0,
                ),
                DropdownMenuItem(
                  child: Text("DNI"),
                  value: 1,
                ),
                DropdownMenuItem(
                  child: Text("Pas."),
                  value: 2,
                ),
              ],
              onSaved: (value) {
                setState(
                  () {
                    _tipoDocumento = value;
                  },
                );
              },
              onChanged: (value) {
                setState(
                  () {
                    _tipoDocumento = value;
                  },
                );
              },
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 4,
            child: TextFormField(
              focusNode: myFocusNode,
              controller: _documentoController,
              decoration: InputDecoration(
                  labelText: 'Documento',
                  counterStyle: TextStyle(
                    height: double.minPositive,
                  ),
                  counterText: ""),
              keyboardType: TextInputType.number,
              onSaved: (value) {
                setState(() {
                  _documento = int.parse(value);
                });
              },
            ),
          ),
        ],
      ),
      CustomTextFormField(
        fieldController: _apellidoController,
        labelText: 'Apellido',
        onSaveCallback: (value) {
          setState(() {
            _apellido = value;
          });
        },
      ),
      CustomTextFormField(
        fieldController: _nombreController,
        labelText: 'Nombre',
        onSaveCallback: (value) {
          setState(() {
            _nombre = value;
          });
        },
      ),
      DropDownFormField(
        titleText: 'Nacionalidad',
        hintText: 'Por favor seleccione una opcion',
        value: _nacionalidad,
        onSaved: (value) {
          setState(() {
            _nacionalidad = value;
          });
        },
        onChanged: (value) {
          setState(() {
            _nacionalidad = value;
          });
        },
        dataSource: knacionalidades,
        textField: 'gentilicio',
        valueField: 'idpais',
      ),
      TextFormField(
          maxLength: 30,
          controller: _nacioController,
          onTap: () async {
            FocusScope.of(context).requestFocus(new FocusNode());
            var datePicked = await showDatePicker(
              context: context,
              initialDate: DateTime(1960),
              firstDate: DateTime(1920),
              lastDate: DateTime(_today.year - 20),
              locale: const Locale('es'),
            );
            setState(
              () {
                _nacioController = TextEditingController(
                    text: DateFormat("dd MMMM yyyy", 'es').format(datePicked));
                _naciodate = DateFormat("yyyyMMdd").format(datePicked);
              },
            );
          },
          onSaved: (value) {
            String _nacio = value;
          },
          decoration: InputDecoration(
              labelText: 'Fecha de nacimiento',
              counterStyle: TextStyle(
                height: double.minPositive,
              ),
              counterText: ""),
          validator: (value) =>
              value.isNotEmpty ? null : 'Debe ingresar una Fecha'),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: CustomTextFormField(
              fieldController: _matriculaNacionalController,
              labelText: 'Matricula Nacional',
              textInputType: TextInputType.number,
              onSaveCallback: (value) {
                setState(
                  () {
                    _matriculaNacional = value;
                  },
                );
              },
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 4,
            child: CustomTextFormField(
              fieldController: _matriculaProvincialController,
              labelText: 'Matricula Provincial',
              textInputType: TextInputType.number,
              onSaveCallback: (value) {
                setState(() {
                  _matriculaProvincial = value;
                });
              },
            ),
          ),
        ],
      ),
      CustomTextFormField(
        fieldController: _domicilioController,
        labelText: 'Domicilio',
        onSaveCallback: (value) {
          setState(() {
            _domicilio = value;
          });
        },
      ),
      Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: CustomTextFormField(
              fieldController: _codigoPostalController,
              labelText: 'Codigo Postal',
              onSaveCallback: (value) {
                setState(() {
                  _codigoPostal = value;
                });
              },
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            flex: 4,
            child: CustomTextFormField(
              fieldController: _localidadController,
              labelText: 'Localidad',
              onSaveCallback: (value) {
                setState(() {
                  _localidad = value;
                });
              },
            ),
          )
        ],
      ),
      CustomTextFormField(
        fieldController: _provinciaController,
        labelText: 'Provincia',
        onSaveCallback: (value) {
          setState(() {
            _provincia = value;
          });
        },
      ),
      CustomTextFormField(
        fieldController: _paisController,
        labelText: 'Pais',
        onSaveCallback: (value) {
          setState(() {
            _pais = value;
          });
        },
      ),
      Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text('Residente'),
          ),
          Expanded(
            flex: 2,
            child: ListTile(
              title: const Text('Si'),
              leading: Radio(
                value: SingingCharacter.Si,
                groupValue: _character,
                onChanged: (SingingCharacter value) {
                  setState(
                    () {
                      _character = value;
                      _residente = 1;
                    },
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: ListTile(
              title: const Text('No'),
              leading: Radio(
                value: SingingCharacter.No,
                groupValue: _character,
                onChanged: (SingingCharacter value) {
                  setState(() {
                    _character = value;
                    _residente = 0;
                    _inicioresidenciadate = '19000101';
                    _inicioResidenciaController =
                        TextEditingController(text: '19000101');
                  });
                },
              ),
            ),
          ),
        ],
      ),
      buildInicioResidencia(),
      CustomTextFormField(
        fieldController: _telefonoController,
        labelText: 'Telefono',
        onSaveCallback: (value) {
          setState(() {
            _telefono = value;
          });
        },
      ),
      ElevatedButton(onPressed: _submit, child: Text('Siguiente'))
    ];
  }

  Widget buildInicioResidencia() {
    if (_character == SingingCharacter.Si) {
      return TextFormField(
          maxLength: 30,
          controller: _inicioResidenciaController,
          onTap: () async {
            FocusScope.of(context).requestFocus(new FocusNode());
            var datePicked = await showDatePicker(
              context: context,
              initialDate: DateTime(1974),
              firstDate: DateTime(1920),
              lastDate: DateTime(_today.year - 20),
              locale: const Locale('es'),
            );
            setState(
              () {
                _inicioResidenciaController = TextEditingController(
                    text: DateFormat("dd MMMM yyyy", 'es').format(datePicked));
                _inicioresidenciadate =
                    DateFormat("yyyyMMdd").format(datePicked);
              },
            );
          },
          onSaved: (value) {
            String _inicioResidencia = value;
          },
          decoration: InputDecoration(
              labelText: 'Fecha inicio Residencia',
              counterStyle: TextStyle(
                height: double.minPositive,
              ),
              counterText: ""),
          validator: (value) =>
              value.isNotEmpty ? null : 'Debe ingresar una Fecha');
    } else {
      return Container();
    }
  }
}
