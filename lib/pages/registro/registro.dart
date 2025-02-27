import 'package:flutter/material.dart';

import '../../api/PersonaApi.dart';
import '../../model/Perfil.dart';
import '../../model/Persona.dart';
import '../../model/Telefono.dart';
import '../../model/Usuario.dart';
import 'registro1_perfiles.dart';
import 'registro2_identificacion.dart';
import 'registro3_ubicacion.dart';
import 'registro4_usuario.dart';
import '../../widget/dialog.dart';

class RegistroPage extends StatefulWidget {
  @override
  _RegistroPageState createState() => new _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final PersonaApi personaApi = new PersonaApi();

  int currentStep = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formIdKey = new GlobalKey<FormState>();
  final GlobalKey<FormState> _formUbcKey = new GlobalKey<FormState>();
  final GlobalKey<FormState> _formUsrKey = new GlobalKey<FormState>();

  Persona _persona = new Persona(
    usuario: new Usuario(),
    telefonos: new List<Telefono>(),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Stepper(
        currentStep: this.currentStep,
        type: StepperType.horizontal,
        steps: <Step>[
          Step(
              title: Text(this.currentStep != 0 ? "" : "Perfil"),
              content: new RegistroPerfil(
                perfil: _persona.perfil,
                onChanged: (Perfil newPerfil) {
                  setState(() {
                    this._persona.perfil = newPerfil;
                  });
                },
              ),
              isActive: (this.currentStep == 0),
              state: (this.currentStep == 0
                  ? StepState.indexed
                  : StepState.complete)),
          Step(
              title: Text(this.currentStep != 1 ? "" : "Identificación"),
              content: (this.currentStep == 1
                  ? new RegistroIdentificacion(
                      formKey: _formIdKey,
                      persona: _persona,
                    )
                  : Container()),
              isActive: (this.currentStep == 1),
              state: (this.currentStep == 1
                  ? StepState.indexed
                  : (this.currentStep < 1
                      ? StepState.disabled
                      : StepState.complete))),
          Step(
              title: Text(this.currentStep != 2 ? "" : "Ubicación"),
              content: (this.currentStep == 2
                  ? new RegistroUbicacion(
                      formKey: _formUbcKey,
                      persona: _persona,
                    )
                  : Container()),
              isActive: (this.currentStep == 2),
              state: (this.currentStep == 2
                  ? StepState.indexed
                  : (this.currentStep < 2
                      ? StepState.disabled
                      : StepState.complete))),
          Step(
            title: Text(this.currentStep != 3 ? "" : "Usuario"),
            content: (this.currentStep == 3
                ? new RegistroUsuario(
                    formKey: _formUsrKey,
                    persona: _persona,
                  )
                : Container()),
          )
        ],
        onStepTapped: (newCurrentStep) {
          if (this.currentStep >= newCurrentStep) {
            setState(() {
              this.currentStep = newCurrentStep;
            });
          }
        },
        onStepContinue: () async {
          switch (this.currentStep) {
            case 0:
              {
                if (this._persona.perfil != null) {
                  setState(() {
                    this.currentStep++;
                  });
                } else {
                  showAlertDialog(
                    context: context,
                    title: "Registro",
                    message: "Error: debe seleccionar un perfil!!!",
                    level: LEVEL_WARNING,
                  );
                }
              }
              break;
            case 1:
              {
                if (_formIdKey.currentState.validate()) {
                  _formIdKey.currentState.save();
                  List<Persona> valPersona = await this.personaApi.getPersonas(
                      identificacion: this._persona.identificacion);
                  if (valPersona.isEmpty) {
                    setState(() {
                      this.currentStep++;
                    });
                  } else {
                    showAlertDialog(
                      context: context,
                      title: "Registro",
                      message:
                          "Error: Ya existe un usuario registrado con el mismo número de identificación",
                      level: LEVEL_WARNING,
                    );
                  }
                } else {
                  showAlertDialog(
                    context: context,
                    title: "Registro",
                    message: "Error: debe corregir los errores de validación",
                    level: LEVEL_WARNING,
                  );
                }
              }
              break;
            case 2:
              {
                if (_formUbcKey.currentState.validate() &&
                    _persona.ubicacion != null &&
                    _persona.ubicacion.idUbicacion != null) {
                  _formUbcKey.currentState.save();
                  setState(() {
                    this.currentStep++;
                  });
                } else {
                  showAlertDialog(
                    context: context,
                    title: "Registro",
                    message: "Error: debe corregir los errores de validación",
                    level: LEVEL_WARNING,
                  );
                }
              }
              break;
            case 3:
              {
                if (_formUsrKey.currentState.validate()) {
                  _formUsrKey.currentState.save();
                  _scaffoldKey.currentState.showSnackBar(new SnackBar(
                    content: Text("Registrando usuario..."),
                    duration: Duration(seconds: 2),
                  ));
                  try {
                    await personaApi.postPersona(this._persona);
                    showAlertDialog(
                        context: context,
                        title: "Registro",
                        message: "Registro exitoso",
                        level: LEVEL_INFO,
                        onPressed: () {
                          Navigator.pop(context, this._persona.usuario);
                        });
                  } on Exception catch (e) {
                    showAlertDialog(
                      context: context,
                      title: "Registro",
                      message: "Error inesperado $e",
                      level: LEVEL_ERROR,
                    );
                  }
                } else {
                  showAlertDialog(
                    context: context,
                    title: "Registro",
                    message: "Error: debe corregir los errores de validación",
                    level: LEVEL_WARNING,
                  );
                }
              }
              break;
          }
        },
        onStepCancel: () {
          if (this.currentStep > 0) {
            setState(() {
              this.currentStep--;
            });
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
