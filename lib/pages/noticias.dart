import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../api/NoticiaApi.dart';
import '../constants.dart';
import '../model/Noticia.dart';
import '../widget/dialog.dart';
import 'noticia.dart';

class NoticiasPage extends StatelessWidget {
  final NoticiaApi _noticiaApi = NoticiaApi();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: new Text('NOTICIAS'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _noticiaApi.getNoticias(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                    title: "Noticias",
                    message: "Error inesperado ${snapshot.error}",
                    level: LEVEL_ERROR);
                return Text("");
              } else {
                if (snapshot.data.length == 0) {
                  showAlertDialog(
                      context: context,
                      title: "Noticias",
                      message:
                          "No hay noticias en este momento... intenta de nuevo más tarde",
                      level: LEVEL_WARNING);
                  return Text("");
                }
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  itemBuilder: (BuildContext context, int index) {
                    return _noticia(context, snapshot.data[index]);
                  },
                );
              }
          }
        },
      ),
    );
  }

  Widget _noticia(BuildContext context, Noticia noticia) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[200]),
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(color: Colors.white),
          padding: EdgeInsets.all(10),
          child: Hero(
            tag: 'noticia-${noticia.idNoticia}',
            child: FadeInImage.assetNetwork(
              fit: BoxFit.cover,
              placeholder: 'assets/img/loading.gif',
              image: BASE_IMG_NOTICIA_URL + noticia.imagen,
            ),
          ),
        ),
        title: Text(noticia.titulo),
        subtitle:
            Text(DateFormat("dd/MM/yyyy").format(noticia.fechaPublicacion)),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NoticiaPage(noticia: noticia)));
        },
      ),
    );
  }
}
