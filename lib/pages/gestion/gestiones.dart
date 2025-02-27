import 'dart:async';

import 'package:flutter/material.dart';

import '../../api/GestionApi.dart';
import '../../model/Gestion.dart';
import '../../model/Persona.dart';
import '../../widget/gestion_widget.dart';
import 'gestion.dart';

class GestionesPage extends StatefulWidget {
  final Persona persona;

  GestionesPage({Key key, this.persona}) : super(key: key);

  @override
  State<GestionesPage> createState() => new _GestionesPageState();
}

class _GestionesPageState extends State<GestionesPage> {
  final GestionApi gestionApi = new GestionApi();

  List<Gestion> gestiones = new List<Gestion>();

  Widget _buildItem(BuildContext context, Gestion gestion) {
    Persona persona = (widget.persona == gestion.personaQueEntrega
        ? gestion.personaQueGestiona
        : gestion.personaQueEntrega);
    return GestionWidget(
      persona: persona,
      gestion: gestion,
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => new GestionPage(
                    gestion: gestion,
                    persona: persona,
                  )),
        );
        _updateGestiones();
      },
    );
  }

  Future<Null> _updateGestiones() async {
    List<Gestion> newGestiones =
        await this.gestionApi.getGestiones(widget.persona);
    setState(() {
      this.gestiones = newGestiones;
    });
    return null;
  }

  @override
  void initState() {
    super.initState();
    _updateGestiones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('GESTIONES'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        child: ListView.builder(
          itemCount: this.gestiones.length,
          itemBuilder: (BuildContext context, int index) {
            return this._buildItem(context, this.gestiones[index]);
          },
        ),
        onRefresh: _updateGestiones,
      ),
    );
  }
}
