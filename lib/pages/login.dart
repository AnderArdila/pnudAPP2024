import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'dart:async';

import '../app_bloc_provider.dart';
import '../model/Usuario.dart';
import 'registro/registro.dart';
import 'LostPasswordPage.dart';
import '../widget/dialog.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _usernameCtrl = new TextEditingController();
  final _passwordCtrl = new TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  void _doLogin(BuildContext context) async {
    final securityBloc = AppBlocProvider.securityBlocOf(context);
    setState(() {
      this.isLoading = true;
    });
    try {
      Usuario usuario =
          await securityBloc.login(_usernameCtrl.text, _passwordCtrl.text);
      if (usuario != null) {
        await new Future.delayed(const Duration(seconds: 1));
        Navigator.pop(context);
      } else {
        showAlertDialog(
            context: context,
            title: "Acceso",
            message:
                "El usuario o el password es incorrecto, verifique e intente nuevamente, si el problema persiste contacte al servicio de soporte.",
            level: LEVEL_WARNING);
      }
    } on Exception catch (e) {
      showAlertDialog(
          context: context,
          title: "Acceso",
          message: "Error inesperado $e",
          level: LEVEL_ERROR);
    }
    setState(() {
      this.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('ACCESO'), centerTitle: true),
      body: (this.isLoading)
          ? new Center(child: new CircularProgressIndicator())
          : new SafeArea(
              child: ListView(
                  padding: const EdgeInsets.all(10),
                  shrinkWrap: true,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image.asset('assets/logo.png'))),
                    SizedBox(height: 10.0),
                    Container(
                        decoration: BoxDecoration(color: Colors.grey),
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(FontAwesomeIcons.solidUserCircle,
                                  color: Colors.white),
                              labelText: 'Usuario',
                              labelStyle: TextStyle(color: Colors.white)),
                          controller: _usernameCtrl,
                        )),
                    SizedBox(height: 10.0),
                    Container(
                        decoration: BoxDecoration(color: Colors.grey),
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                Icons.vpn_key,
                                color: Colors.white,
                              ),
                              labelText: 'Contraseña',
                              labelStyle: TextStyle(color: Colors.white)),
                          controller: _passwordCtrl,
                          obscureText: true,
                        )),
                    SizedBox(height: 15.0),
                    RaisedButton(
                        color: Theme.of(context).primaryColor,
                        shape: StadiumBorder(),
                        //padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text('INGRESAR'),
                        textColor: Colors.white,
                        onPressed: () => _doLogin(context)),
                    Center(
                        child: FlatButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LostPasswordPage(),
                                  ));
                            },
                            child: Text(
                              'Olvidé mi clave',
                              style: TextStyle(
                                  color: Colors.black54,
                                  decoration: TextDecoration.underline),
                            ))),
                    RaisedButton(
                        color: Colors.black54,
                        shape: StadiumBorder(),
                        child: Text('REGISTRARSE'),
                        textColor: Colors.white,
                        onPressed: () async {
                          this._usernameCtrl.clear();
                          this._passwordCtrl.clear();
                          Usuario usuario = await Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new RegistroPage()));
                          if (usuario != null) {
                            this._usernameCtrl.text = usuario.correo;
                            this._passwordCtrl.text = usuario.clave;
                            this._doLogin(context);
                          }
                        })
                  ]),
            ),
    );
  }
}
