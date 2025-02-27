import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app_bloc_provider.dart';

import 'persona_logro.dart';
import 'UpdatePersonaPage.dart';
import '../../constants.dart';
import '../../model/Persona.dart';
import '../../model/Telefono.dart';

class PersonaPage extends StatelessWidget {
  final Persona persona;

  PersonaPage({this.persona});

  Widget _buildInfoItem(BuildContext context) {
    final defaultImage = new Image(
      image:
          new AssetImage('assets/${persona.perfil.idPerfil}.png'.toLowerCase()),
      color: null,
      fit: BoxFit.scaleDown,
      alignment: Alignment.center,
      width: 140.0,
      height: 140.0,
    );

    Widget imagenWidget = Container(
        margin: EdgeInsets.all(10.0),
        child: (persona.imagen != null)
            ? new CachedNetworkImage(
                imageUrl: BASE_IMG_PERSONA_URL + persona.imagen,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => defaultImage,
                width: 140.0,
                height: 140.0,
              )
            : defaultImage);

    Widget nombreWidget = Container(
        margin:
            EdgeInsets.only(left: 160.0, top: 15.0, bottom: 15.0, right: 15.0),
        constraints: new BoxConstraints.expand(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              persona.nombre,
              style: Theme.of(context).textTheme.headline,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
            Divider(),
            Text(persona.perfil.nombre)
          ],
        ));

    return new Container(
      height: 160.0,
      child: Stack(
        children: <Widget>[
          new Hero(
            tag: 'persona-${persona.idPersona}',
            child: imagenWidget,
          ),
          nombreWidget
        ],
      ),
    );
  }

  List<Widget> _buildEmailInfo(BuildContext context) {
    List<Widget> retValue = new List<Widget>();
    //for( Usuario usuario in this.persona.usuarios ){
    if (this.persona.usuario != null) {
      retValue.add(ListTile(
        leading: Icon(FontAwesomeIcons.envelope),
        title: Text(this.persona.usuario.correo),
        onTap: () async {
          if (await canLaunch('mailto:${this.persona.usuario.correo}')) {
            await launch('mailto:${this.persona.usuario.correo}');
          }
        },
      ));
    }
    //}
    return retValue;
  }

  List<Widget> _buildPhoneInfo(BuildContext context) {
    List<Widget> retValue = new List<Widget>();
    for (Telefono telefono in this.persona.telefonos) {
      retValue.add(ListTile(
        leading: Icon(FontAwesomeIcons.phone),
        title: Text("${telefono.numero}"),
        onTap: () async {
          if (await canLaunch('tel:${telefono.numero}')) {
            await launch('tel:${telefono.numero}');
          }
        },
      ));
    }
    return retValue;
  }

  List<Widget> _buildLocationInfo(BuildContext context) {
    List<Widget> retValue = new List<Widget>();
    retValue.add(ListTile(
      leading: Icon(FontAwesomeIcons.mapMarkerAlt),
      title: Text(persona.ubicacion.nombre),
      subtitle: (persona.ubicacion.padre != null
          ? Text(persona.ubicacion.padre.nombre)
          : null),
    ));
    return retValue;
  }

  @override
  Widget build(BuildContext context) {
    final securityBloc = AppBlocProvider.securityBlocOf(context);
    return Scaffold(
      appBar: new AppBar(
        title: Text(persona.perfil.nombre),
        centerTitle: true,
        actions: <Widget>[
          StreamBuilder<Persona>(
              stream: securityBloc.persona,
              initialData: null,
              builder: (context, snapshot) {
                Persona persona = snapshot.data;
                if (persona != null && persona == this.persona) {
                  return IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                UpdatePersonaPage(persona: persona)),
                      );
                    },
                  );
                }
                return Container();
              })
        ],
      ),
      body: ListView(
        children: <Widget>[
          Card(
            elevation: 2,
            margin: EdgeInsets.all(10.0),
            child: _buildInfoItem(context),
          ),
          Card(
            elevation: 2.0,
            margin: EdgeInsets.all(10.0),
            child: ExpansionTile(
              title: Text("Logros"),
              children: <Widget>[new PersonaLogroPage(persona: persona)],
            ),
          ),
          Card(
            elevation: 2.0,
            margin: EdgeInsets.all(10.0),
            child: ExpansionTile(
              title: Text("Correos electrónicos"),
              children: _buildEmailInfo(context),
            ),
          ),
          Card(
            elevation: 2.0,
            margin: EdgeInsets.all(10.0),
            child: ExpansionTile(
              title: Text("Telefonos"),
              children: _buildPhoneInfo(context),
            ),
          ),
          Card(
            elevation: 2.0,
            margin: EdgeInsets.all(10.0),
            child: ExpansionTile(
              title: Text("Ubicación"),
              children: _buildLocationInfo(context),
            ),
          ),
        ],
      ),
    );
  }
}
