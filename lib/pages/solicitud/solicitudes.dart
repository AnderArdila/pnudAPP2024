import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../api/SolicitudApi.dart';
import '../../constants.dart';
import '../../model/Persona.dart';
import '../../model/Solicitud.dart';
import '../../widget/stack_icon.dart';
import 'solicitud.dart';

class SolicitudesPage extends StatefulWidget {
  final Persona solicitante;
  final Persona solicitado;

  SolicitudesPage({Key key, this.solicitante, this.solicitado})
      : super(key: key);

  @override
  State<SolicitudesPage> createState() => new _SolicitudesPageState();
}

class _SolicitudesPageState extends State<SolicitudesPage> {
  final SolicitudApi solicitudApi = new SolicitudApi();

  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  List<Solicitud> solicitudes = new List<Solicitud>();

  Widget _buildItem(BuildContext context, Solicitud solicitud) {
    final DateFormat dateFormat = new DateFormat("d/M/y H:m:s");

    String titulo = (widget.solicitante != null
            ? solicitud.solicitado
            : solicitud.solicitante)
        .nombre;
    String subtitulo;
    Color color;
    IconData iconData;
    if (solicitud.fechaResuelta != null) {
      subtitulo = "Resuelta el: " + dateFormat.format(solicitud.fechaResuelta);
      iconData = FontAwesomeIcons.check;
      color = COLOR_YELLOW_DARK;
    } else if (solicitud.fechaVisto != null) {
      subtitulo = "Vista el: " + dateFormat.format(solicitud.fechaVisto);
      iconData = FontAwesomeIcons.eye;
      color = COLOR_YELLOW;
    } else {
      subtitulo = "Enviada el: " + dateFormat.format(solicitud.fechaEnvio);
      iconData = FontAwesomeIcons.question;
      color = COLOR_YELLOW_LIGHT;
    }
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: ListTile(
        leading: new StackIcon(
          bgIconData: FontAwesomeIcons.commentAlt,
          iconData: iconData,
        ),
        title: Text(
          titulo,
          style: Theme.of(context).textTheme.headline,
        ),
        subtitle: Text(subtitulo),
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => new SolicitudPage(
                    solicitud: solicitud,
                    solicitado: widget.solicitado,
                    solicitante: widget.solicitante)),
          );
          _updateSolicitudes();
        },
      ),
    );
  }

  Future<Null> _updateSolicitudes() async {
    List<Solicitud> newSolicitudes = await this.solicitudApi.getSolicitudes(
          idPersonaDe: widget.solicitante?.idPersona,
          idPersonaPara: widget.solicitado?.idPersona,
        );
    setState(() {
      this.solicitudes = newSolicitudes;
    });
    return null;
  }

  @override
  void initState() {
    super.initState();
    _updateSolicitudes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SOLICITUDES'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        key: _refreshKey,
        child: ListView.builder(
          itemCount: this.solicitudes.length,
          itemBuilder: (BuildContext context, int index) {
            return this._buildItem(context, this.solicitudes[index]);
          },
        ),
        onRefresh: _updateSolicitudes,
      ),
    );
  }
}
