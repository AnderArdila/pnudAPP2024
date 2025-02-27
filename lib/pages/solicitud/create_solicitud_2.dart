import 'package:flutter/material.dart';

import '../../api/SolicitudApi.dart';
import '../../api/PerfilApi.dart';
import '../../model/Solicitud.dart';
import '../../model/Persona.dart';
import '../../model/TipoServicio.dart';
import '../../widget/persona_widget.dart';
import '../../widget/dialog.dart';

class CreateSolicitudPage2 extends StatefulWidget {
  final Persona solicitante;
  final Persona solicitado;

  CreateSolicitudPage2({Key key, this.solicitante, this.solicitado})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => new _CreateSolicitudPage2State(
      solicitud: new Solicitud(
          solicitante: this.solicitante,
          solicitado: this.solicitado,
          servicios: []));
}

class _CreateSolicitudPage2State extends State<CreateSolicitudPage2> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final PerfilApi _perfilApi = new PerfilApi();
  final SolicitudApi _solicitudApi = new SolicitudApi();

  Solicitud solicitud;

  _CreateSolicitudPage2State({this.solicitud});

  @override
  initState() {
    super.initState();
    if (this.solicitud.solicitado.perfil.servicios == null ||
        this.solicitud.solicitado.perfil.servicios.isEmpty) {
      this
          ._perfilApi
          .getPerfil(this.solicitud.solicitado.perfil.idPerfil)
          .then((perfil) {
        setState(() {
          this.solicitud.solicitado.perfil = perfil;
        });
      });
    }
  }

  Widget _buildTipoServicioItem(
      BuildContext context, TipoServicio tipoServicio) {
    bool isSelected = this.solicitud.servicios.contains(tipoServicio);
    return Card(
        child: ListTile(
      title: Text(tipoServicio.nombre),
      subtitle: tipoServicio.observaciones != null
          ? Text(tipoServicio.observaciones)
          : null,
      trailing: Icon(
        isSelected ? Icons.check : Icons.close,
        color: isSelected ? Colors.green : Colors.red,
      ),
      onTap: () {
        setState(() {
          if (this.solicitud.servicios.contains(tipoServicio)) {
            this.solicitud.servicios.remove(tipoServicio);
          } else {
            this.solicitud.servicios.add(tipoServicio);
          }
        });
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = new List<Widget>();
    items.add(new PersonaWidget(
        showEstrellas: false, persona: this.solicitud.solicitado));
    items.add(Padding(
      padding: EdgeInsets.all(10.0),
      child: Text(
        "2. Seleccione los servicios",
        style: Theme.of(context).textTheme.subtitle,
      ),
    ));
    if (this.solicitud.solicitado.perfil.servicios != null) {
      for (TipoServicio tipoServicio
          in this.solicitud.solicitado.perfil.servicios) {
        items.add(this._buildTipoServicioItem(context, tipoServicio));
      }
    }
    items.add(RaisedButton(
      child: Text("Enviar"),
      shape: StadiumBorder(),
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      onPressed: () async {
        if (this._formKey.currentState.validate()) {
          _formKey.currentState.save();
          try {
            await _solicitudApi.postSolicitud(this.solicitud);
            showAlertDialog(
                context: context,
                title: "Solicitud",
                message: "Solicitud enviada.",
                level: LEVEL_INFO,
                onPressed: () {
                  Navigator.of(context).pop();
                });
          } on Exception catch (e) {
            showAlertDialog(
              context: context,
              title: "Solicitud",
              message: "Error inesperado $e",
              level: LEVEL_ERROR,
            );
          }
        } else {
          showAlertDialog(
            context: context,
            title: "Solicitud",
            message:
                "Por favor revise los errores en el formulario antes de enviar",
            level: LEVEL_WARNING,
          );
        }
      },
    ));

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('ENVIAR SOLICITUD'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: ListView(children: items.toList()),
        ),
      ),
    );
  }
}
