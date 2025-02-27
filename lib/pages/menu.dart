import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../app_bloc_provider.dart';
import '../bloc/SecurityBloc.dart';
import '../constants.dart';
import '../model/Persona.dart';
import '../widget/stack_icon.dart';
import 'gestion/create_gestion_1.dart';
import 'gestion/gestiones.dart';
import 'solicitud/create_solicitud_1.dart';
import 'solicitud/solicitudes.dart';
import 'persona/persona.dart';
import 'pregunta/PreguntasPage.dart';
import 'certificado/CertificadosPage.dart';

//import 'package:google_maps_flutter/google_maps_flutter.dart';

class Menu extends StatelessWidget {
/*
  final GoogleMapOverlayController controller;

  Menu({Key key, this.controller}) : super(key: key);*/

  Widget _buildDrawerHeader(BuildContext context, Persona persona) {
    if (persona != null) {
      final defaultImage = new Image(
        image: new AssetImage(
            'assets/${persona.perfil.idPerfil}.png'.toLowerCase()),
        color: null,
        fit: BoxFit.scaleDown,
        alignment: Alignment.center,
      );
      return UserAccountsDrawerHeader(
          accountName: Text(
            persona.nombre,
            softWrap: true,
            overflow: TextOverflow.clip,
            style: TextStyle(color: Colors.white),
          ),
          accountEmail: Text(
            persona.usuario.correo,
            style: TextStyle(color: Colors.white),
          ),
          currentAccountPicture: (persona.imagen != null)
              ? new CachedNetworkImage(
                  imageUrl: BASE_IMG_PERSONA_URL + persona.imagen,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => defaultImage,
                )
              : (defaultImage),
          onDetailsPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PersonaPage(persona: persona)),
            );
          });
    } else {
      return Container();
    }
  }

  Widget _buildSolicitarServicioOption(
      BuildContext context, Persona solicitante) {
    return ListTile(
        leading: new StackIcon(
            bgIconData: FontAwesomeIcons.commentAlt,
            iconData: FontAwesomeIcons.plus),
        title: Text('Solicitar servicio de gestión'),
        onTap: () async {
          if (solicitante != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        new CreateSolicitudPage1(solicitante: solicitante)));
          } else {
            await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return new AlertDialog(
                      title: Text('Solicitar servicio de gestión'),
                      content: Text(
                          'Para solicitar un servicio de gestión es necesario acceder con su usuario/contraseña. Si no lo tiene puede crear una cuenta de usuario, sólo llevará un minuto.'),
                      actions: <Widget>[
                        FlatButton(
                            child: Text("Entendido"),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pushNamed('/login');
                            }),
                        FlatButton(
                            child: Text("Tal vez despues"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            })
                      ]);
                });
          }
        });
  }

  Widget _buildConsultarServiciosOption(BuildContext context, Persona persona) {
    return ListTile(
        leading: Icon(persona.perfil.rol == "GESTOR"
            ? FontAwesomeIcons.commentAlt
            : Icons.list),
        title: Text(persona.perfil.rol == "GESTOR"
            ? 'Consultar servicios de gestión'
            : 'Mis gestiones'),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return persona.perfil.rol == "GESTOR"
                ? new SolicitudesPage(
                    solicitado: persona,
                  )
                : new GestionesPage(persona: persona);
          }));
        });
  }

  Widget _buildRegistrarGestionOption(BuildContext context, Persona persona) {
    return ListTile(
        leading: Icon(FontAwesomeIcons.clipboardCheck),
        title: Text('Registrar gestión'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    new CreateGestionPage1(personaQueGestiona: persona)),
          );
        });
  }

  Widget _buildTecnicosEmpresasVerdesOption(BuildContext context) {
    return ListTile(
        leading: Icon(FontAwesomeIcons.envira, color: Colors.green),
        title: Text('Técnicos y empresas verdes'),
        onTap: () {
          Navigator.of(context).pushNamed('/verdes');
        });
  }

  Widget _buildCalculadoraEstrellasOption(BuildContext context) {
    return ListTile(
        leading: Icon(Icons.star, color: Theme.of(context).primaryColor),
        title: Text('Calcule sus estrellas'),
        onTap: () {
          Navigator.of(context).pushNamed('/calculadora');
        });
  }

  Widget _buildRetosOption(BuildContext context) {
    return ListTile(
        leading: Image(
          image: AssetImage('assets/support.png'),
          width: 20,
        ),
        title: Text('Retos.'),
        onTap: () {
          Navigator.of(context).pushNamed('/retos');
        });
  }

  Widget _buildRutasOption(BuildContext context) {
    return ListTile(
        leading: Icon(
          FontAwesomeIcons.route,
        ),
        title: Text('Mis rutas de recolección'),
        onTap: () {
          Navigator.of(context).pushNamed('/rutas');
        });
  }

  Widget _buildNoticiasOption(BuildContext context) { 
    return ListTile(
        leading: Icon(Icons.library_books, color: Colors.black),
        title: Text('Noticias'),
        onTap: () { 
          Navigator.of(context).pushNamed('/noticias'); //
        });
  }

  //Ander
  Widget _buildArcgisMap(BuildContext context) { 
    return ListTile(
        leading: Icon(Icons.library_books, color: Colors.black),
        title: Text('Arcgis Map'),
        onTap: () { 
          Navigator.of(context).pushNamed('/arcgis_map'); //
        });
  }

  //Ander
  Widget _buildCertificationInterest(BuildContext context) { 
    return ListTile(
        leading: Icon(Icons.library_books, color: Colors.black),
        title: Text('Quiero certificarme'),
        onTap: () { 
          Navigator.of(context).pushNamed('/certificadoInteres'); //
        });
  }


  Widget _buildPreguntasOption(BuildContext context, Persona persona) {
    return ListTile(
        leading: Icon(Icons.help_outline),
        title: Text('Pregunte a un experto'),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => new PreguntasPage(persona: persona)));
        });
  }

  Widget _buildCertificadosOption(BuildContext context, Persona persona) {
    return ListTile(
        leading: Icon(FontAwesomeIcons.certificate, color: Colors.orange),
        title: Text('Certificados'),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      new CertificadosPage(persona: persona)));
        });
  }

  Widget _buildAccessOptions(
      BuildContext context, SecurityBloc securityBloc, Persona persona) {
    if (persona != null) {
      return ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Cerrar sesión'),
          onTap: () async {
            await securityBloc.logout();
          });
    } else {
      return ListTile(
          leading: Icon(Icons.input),
          title: Text('Acceso'),
          onTap: () {
            Navigator.of(context).pushNamed('/login');
          });
    }
  }

  Widget _buildAboutOption(BuildContext context) {
    return AboutListTile(
        icon: Icon(Icons.info_outline),
        applicationLegalese:
            'Ministerio de Ambiente y Desarrollo Sostenible, todos los derechos reservados',
        applicationIcon: Image(
            image: AssetImage('assets/logo.png'),
            width: 60.0,
            height: 60.0,
            color: null,
            fit: BoxFit.scaleDown,
            alignment: Alignment.center),
        applicationVersion: '1.1.3');
  }

  @override
  Widget build(BuildContext context) {
    final securityBloc = AppBlocProvider.securityBlocOf(context);
    return SafeArea(
        child: Drawer(
            child: StreamBuilder<Persona>(
                stream: securityBloc.persona,
                initialData: null,
                builder: (BuildContext buildContex,
                    AsyncSnapshot<Persona> snapshot) {
                  Persona persona = snapshot.data;
                  final List<Widget> opciones = new List<Widget>();
                  //1. Header o en
                  opciones.add(_buildDrawerHeader(context, persona));
                  //2. Opciones de usuario
                  //2.1 Solicitar Servicio de gestión
                  if (persona == null ||
                      (<String>["USUARIO", "TECNICO"])
                          .contains(persona.perfil.rol)) {
                    opciones
                        .add(_buildSolicitarServicioOption(context, persona));
                  }
                  //2.2 Consultar Servicios solicitados
                  if (persona != null &&
                      (<String>["USUARIO", "TECNICO", "GESTOR"])
                          .contains(persona.perfil.rol)) {
                    opciones
                        .add(_buildConsultarServiciosOption(context, persona));
                  }
                  //2.3 Registrar Gestión
                  if (persona != null &&
                      (<String>["GESTOR"]).contains(persona.perfil.rol)) {
                    opciones
                        .add(_buildRegistrarGestionOption(context, persona));
                  }
                  //2.4 Tecnicos y empresas verdes
                  opciones.add(_buildTecnicosEmpresasVerdesOption(context));
                  //2.5 Calcule sus estrellas
                  opciones.add(_buildCalculadoraEstrellasOption(context));
                  //2.6 Retos
                  opciones.add(_buildRetosOption(context));
                  //2.7 Noticias
                  opciones.add(_buildNoticiasOption(context));
                  //2.8 Preguntas & Respuestas
                  if (persona != null) {
                    opciones.add(_buildPreguntasOption(context, persona));
                  }

                  //2.9 Rutas
                  //TODO: && (<String>["GESTOR"]).contains(persona.perfil.rol) Falta validar que aparezca con este usuario
                  if (persona != null) {
                    opciones.add(_buildRutasOption(context));
                  }


                  //Ander
                  //2.10 Arcgis Map
                  opciones.add(_buildArcgisMap(context));

                  //Ander
                  //2.11 Interesados en certificación
                  opciones.add(_buildCertificationInterest(context));


                  //3. Opciones de usuario
                  opciones.add(Divider());
                  if (persona != null &&
                      (<String>["TECNICO"]).contains(persona.perfil.rol)) {
                    opciones.add(_buildCertificadosOption(context, persona));
                  }
                  opciones.add(_buildAccessOptions(
                      context, securityBloc, snapshot.data));

                  //4. El about
                  opciones.add(_buildAboutOption(context));
                  //Fin, retorna el listado:
                  return ListView(
                      // padding: EdgeInsets.only(top: 30),
                      children: opciones);
                })));
  }
}
