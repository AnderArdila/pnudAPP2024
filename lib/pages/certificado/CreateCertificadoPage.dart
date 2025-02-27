import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import '../../model/Persona.dart';
import '../../model/Certificado.dart';
import '../../api/CertificadoApi.dart';
import '../../widget/dialog.dart';

class CreateCertificadoPage extends StatefulWidget {
  final Persona persona;

  CreateCertificadoPage({Key key, this.persona}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _CreateCertificadoPageState(
      certificado: new Certificado(persona: this.persona, valido: false));
}

class _CreateCertificadoPageState extends State<CreateCertificadoPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final CertificadoApi _certificadoApi = new CertificadoApi();

  Certificado certificado;

  _CreateCertificadoPageState({this.certificado});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text("NUEVO CERTIFICADO"),
        centerTitle: true,
      ),
      key: _scaffoldKey,
      body: Form(
        key: this._formKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(20.0),
          children: <Widget>[
            this.certificado.imageFile == null
                ? FlatButton.icon(
                    label: Text("Cargar imagen"),
                    color: Theme.of(context).primaryColor,
                    shape: StadiumBorder(),
                    icon: Icon(Icons.camera_alt),
                    textColor: Colors.white,
                    onPressed: () async {
                      var pickedImg = await ImagePicker.pickImage(
                          source: ImageSource.camera);
                      setState(() {
                        this.certificado.imageFile = pickedImg;
                      });
                    },
                  )
                : AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.file(this.certificado.imageFile),
                  ),
            Divider(),
            this.certificado.imageFile == null
                ? Divider()
                : FlatButton.icon(
                    color: Theme.of(context).primaryColor,
                    shape: StadiumBorder(),
                    textColor: Colors.white,
                    icon: Icon(Icons.file_upload),
                    label: Text("Enviar certificado"),
                    onPressed: () async {
                      try {
                        await this
                            ._certificadoApi
                            .postCertificado(this.certificado);
                        showAlertDialog(
                            context: context,
                            title: "Certificado",
                            message:
                                "Su certificado ha sido enviado para validación.",
                            level: LEVEL_INFO,
                            onPressed: () {
                              Navigator.of(context).pop();
                            });
                      } on Exception catch (e) {
                        showAlertDialog(
                          context: context,
                          title: "Certificado",
                          message: "Error inesperado $e",
                          level: LEVEL_ERROR,
                        );
                      }
                    },
                  )
          ],
        ),
      ),
    );
  }
}
