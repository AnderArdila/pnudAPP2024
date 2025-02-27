import 'package:GestioneSuGas/api/RutaApi.dart';
import 'package:GestioneSuGas/model/Ruta.dart';
import 'package:GestioneSuGas/widget/dialog.dart';
import 'package:flutter/material.dart';

import 'ruta_page.dart';

class RutasPage extends StatelessWidget {
  final RutaApi _rutaApi = RutaApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RUTAS DE RECOLECCIÓN'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _rutaApi.getRutas(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasError) {
                showAlertDialog(
                    context: context,
                    title: "Rutas",
                    message: "Error inesperado ${snapshot.error}",
                    level: LEVEL_ERROR);
                return Text("");
              } else {
                if (snapshot.data.length == 0) {
                  showAlertDialog(
                    context: context,
                    title: "Rutas",
                    message: "No hay rutas creadas",
                    level: LEVEL_WARNING,
                  );
                  return Text("");
                }
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  itemBuilder: (BuildContext context, int index) {
                    return _ruta(context, snapshot.data[index]);
                  },
                );
              }
          }
        },
      ),
    );
  }

  Widget _ruta(BuildContext context, Ruta ruta) {
    return GestureDetector(
      onTap: () async {
        var d = await _rutaApi.getRuta(ruta.idRutas);
        ruta.points = d.points;
        ruta.inicio = d.inicio;
        ruta.fin = d.fin;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RutaPage(ruta: ruta),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Card(
          child: ListTile(
            title: Text(ruta.nombreR),
            subtitle: Text(ruta.descripcion),
            trailing: Icon(Icons.arrow_right),
          ),
        ),
      ),
    );
  }
}
