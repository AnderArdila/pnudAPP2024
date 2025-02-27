import 'package:flutter/material.dart';

import '../api/SecurityApi.dart';
import '../constants.dart';
import '../widget/dialog.dart';

class LostPasswordPage extends StatefulWidget {
  @override
  _LostPasswordPageState createState() => new _LostPasswordPageState();
}

class _LostPasswordPageState extends State<LostPasswordPage> {
  final SecurityApi securityApi = new SecurityApi();

  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _usernameCtrl = new TextEditingController();

  bool isLoading = false;

  void _doRecover(BuildContext context) async {
    setState(() {
      this.isLoading = true;
    });
    try {
      await securityApi.recoverPassword(_usernameCtrl.text);
      showAlertDialog(
          context: context,
          title: "Contraseña",
          message: "Se ha enviado un correo de recuperación de contraseña.",
          level: LEVEL_INFO,
          onPressed: () {
            Navigator.of(context).pop();
          });
    } on Exception catch (e) {
      showAlertDialog(
        context: context,
        title: "Contraseña",
        message: "Error inesperado $e",
        level: LEVEL_ERROR,
      );
    }
    setState(() {
      this.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('RECUPERACIÓN DE CONTRASEÑA'),
      ),
      body: (this.isLoading)
          ? new Center(
              child: new CircularProgressIndicator(),
            )
          : new SafeArea(
              child: new ListView(
                padding: const EdgeInsets.all(10),
                shrinkWrap: true,
                reverse: true,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.asset('assets/logo.png'),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    decoration: BoxDecoration(color: Colors.grey),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.mail, color: Colors.white),
                          labelText: 'Correo',
                          labelStyle: TextStyle(color: Colors.white)),
                      controller: _usernameCtrl,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  RaisedButton(
                    color: COLOR_GREEN,
                    shape: StadiumBorder(),
                    child: Text('Recuperar'),
                    textColor: Colors.white,
                    onPressed: () => _doRecover(context),
                  ),
                  FlatButton(
                    child: Text('Volver',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.black54,
                        )),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ].reversed.toList(),
              ),
            ),
    );
  }
}
