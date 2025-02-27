import 'package:GestioneSuGas/pages/rutas_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_bloc_provider.dart';
import 'pages/calculadora.dart';
import 'pages/retos.dart';
import 'pages/login.dart';
import 'pages/mapa.dart';
import 'pages/noticias.dart';
import 'pages/persona/personas.dart';
import 'pages/notificacion/NotificacionesPage.dart';

import 'pages/arcgis_map.dart'; // Ander
import 'pages/certificado/CertificadoInteresPage.dart'; // Ander

class GestioneSuGasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBlocProvider(
      child: MaterialApp(
        title: 'Red R&R&R – Gestión de gases refrigerantes',
        debugShowCheckedModeBanner: false,
        locale: Locale('es', ''),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        theme: ThemeData(
            primaryColor: Colors.deepOrange,
            accentColor: Colors.grey,
            primaryColorLight: Color(0xFFCCB),
            dividerColor: Colors.blueGrey,
            appBarTheme: AppBarTheme(
              textTheme: TextTheme(
                title: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            errorColor: Colors.red[400]),
        home: new MapaPage(),
        routes: <String, WidgetBuilder>{
          '/login': (BuildContext context) => new LoginPage(),
          '/noticias': (BuildContext context) => new NoticiasPage(),
          '/calculadora': (BuildContext context) => new CalculadoraPage(),
          '/verdes': (BuildContext context) => new PersonasPage(
              titulo: "TÉCNICOS Y EMPRESAS VERDES",
              roles: ["USUARIO", "TECNICO"],
              orden: "-estrellas"),
          '/gestores': (BuildContext context) => new PersonasPage(
                titulo: "GESTIONE SU GAS REFRIGERANTE",
                roles: ["GESTOR"],
              ),
          '/retos': (BuildContext context) => new RetosPage(),
          '/notificaciones': (BuildContext context) => new NotificacionesPage(),
          '/rutas': (BuildContext context) => new RutasPage(), 

          // Ander
          '/arcgis_map': (BuildContext context) => new arcgisMapPage(),

          // Ander
          '/certificadoInteres': (BuildContext context) => new CertificadoInteresPage(),


        },
      ),
    );
  }
}
