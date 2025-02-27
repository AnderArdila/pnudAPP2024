import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../model/Noticia.dart';

class NoticiaPage extends StatelessWidget {
  final Noticia noticia;
  NoticiaPage({Key key, @required this.noticia}) : super(key: key);
  final DateFormat dateFormat = DateFormat("dd/MM/y HH:mm:ss");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NOTICIA'),
        centerTitle: true,
      ),
      body: Card(
        margin: EdgeInsets.all(10.0),
        color: Colors.grey[200],
        child: ListView(
          padding: EdgeInsets.all(10.0),
          children: <Widget>[
            Text('${noticia.titulo}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Hero(
                    tag: 'noticia-${noticia.idNoticia}',
                    child: FadeInImage.assetNetwork(
                      fit: BoxFit.contain,
                      placeholder: 'assets/img/loading.gif',
                      image: BASE_IMG_NOTICIA_URL + noticia.imagen,
                    )),
              ),
            ),
            //
            Text(
              dateFormat.format(noticia.fechaPublicacion),
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.body1,
            ),
            Divider(),
            Text(
              '${noticia.descripcion}',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.body1,
            ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton.icon(
                    color: Theme.of(context).primaryColor,
                    onPressed: () async {
                      if (await canLaunch('${noticia.url}')) {
                        await launch('${noticia.url}');
                      }
                    },
                    icon: Icon(Icons.link),
                    label: Text('VER')),
                FlatButton.icon(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Share.share(
                          'Consulte la noticia completa en ${noticia.url}');
                    },
                    icon: Icon(Icons.share),
                    label: Text('COMPARTIR')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
