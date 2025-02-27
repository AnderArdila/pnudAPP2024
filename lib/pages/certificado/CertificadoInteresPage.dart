import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/Persona.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:validate/validate.dart';

import '../LostPasswordPage.dart';
import '../../widget/dialog.dart';




/*   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Certificado de Interés'),
      ),
      body: Center(
        child: Text('Hello, World!'),
      ),
    );
  } */

 // class CertificadoInteresPage extends StatefulWidget {

// class CertificadoInteresPage extends StatelessWidget {
class CertificadoInteresPage extends StatefulWidget {
  final Persona persona;
  final GlobalKey<FormState> formKey;

  CertificadoInteresPage({Key key, this.persona, this.formKey}) : super(key: key);

  @override
  _CertificadoInteresPageState createState() =>
      new _CertificadoInteresPageState(persona: this.persona, formKey: this.formKey);
}

// 
class _CertificadoInteresPageState extends State<CertificadoInteresPage> {
  final GlobalKey<FormState> formKey;

  Persona persona;

  _CertificadoInteresPageState({this.persona, this.formKey});

  @override
  initState() {
    super.initState();
  }
  
  /*
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Certificado de Interés'),
      ),
      body: Center(
        child: Text('Hello, World!'),
      ),
    );
  } */

  // create a widget with a form and filed called "mail" and button called "send interest"
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Certificado de Interés'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          shrinkWrap: true,
          //reverse: true,
          children: <Widget>[

            SizedBox(height: 10.0),
            SizedBox(height: 10.0),

            Container(
              decoration: BoxDecoration(color: Colors.white),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                  '¿Quieres certificarte como Técnico en Gas Refrigerante y abrir nuevas oportunidades laborales? :',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  Text('Beneficios de formarte con el SENA:'),
                  SizedBox(height: 10.0),
                  Text('- Educación gratuita y de alta calidad.'),
                  Text('- Certificación reconocida a nivel nacional e internacional.'),
                  Text('- Asesoría personalizada para tu crecimiento profesional.'),
                ],
              ),
            ),

            SizedBox(height: 10.0),
            SizedBox(height: 10.0),

            Container(
              decoration: BoxDecoration(color: Colors.grey),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(FontAwesomeIcons.solidUserCircle,
                        color: Colors.white),
                    labelText: 'Correo electrónico',
                    labelStyle: TextStyle(color: Colors.white)),
                autocorrect: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Por favor ingrese un correo eléctronico';
                  }
                  try {
                    Validate.isEmail(value);
                  } catch (e) {
                    return 'Por favor ingrese un correo eléctronico válido';
                  }
                  return null;
                },
                onSaved: (value) {
                  //persona.email = value;
                },
              ),
            ),
            
            SizedBox(height: 10.0),
            SizedBox(height: 10.0),


                  RaisedButton(
                        color: Theme.of(context).primaryColor,
                        shape: StadiumBorder(),
                        //padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text('Contáctenme por favor'),
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
                              'Mas información',
                              style: TextStyle(
                                  color: Colors.black54,
                                  decoration: TextDecoration.underline),
                            )
                        )
                  ),


          ],
          
        ),

      ),

    );
  } // build
} // _CertificadoInteresPageState



  void _doLogin(BuildContext context) async {
    
    try {
        showAlertDialog(
            context: context,
            title: "Acceso",
            message:
                "aaaaaaaaaa",
            level: LEVEL_WARNING);
      
    } on Exception catch (e) {
      showAlertDialog(
          context: context,
          title: "Acceso",
          message: "Error inesperado $e",
          level: LEVEL_ERROR);
    }

  }