import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../model/Noticia.dart';

import 'package:webview_flutter/webview_flutter.dart'; // Ander


class arcgisMapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ArcGIS Map'),
        centerTitle: true,
      ),
      body: const WebView(
        initialUrl: 'https://www.arcgis.com/home/webmap/viewer.html', //Url de la pagina de ArcGIS
        //initialUrl: 'http://35.233.223.132/lab_arcgis_php/', //Url Adison
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}






