import 'package:flutter/material.dart';

import '../api/PersonaApi.dart';
import '../api/LogroApi.dart';
import '../constants.dart';
import '../model/Logro.dart';
import '../model/Persona.dart';

class PersonaWidget extends StatelessWidget {
  final PersonaApi personaApi = new PersonaApi();

  final LogroApi logroApi = new LogroApi();

  final Persona persona;

  final bool showDocument;

  final bool showEstrellas;

  final GestureTapCallback onTap;

  PersonaWidget(
      {this.persona,
      this.showEstrellas = true,
      this.showDocument = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    final defaultImage = Image.asset(
      'assets/${persona.perfil.idPerfil}.png'.toLowerCase(),
      width: 50,
    );

    Widget imagenWidget = defaultImage;

    if (persona.imagen != null) {
      imagenWidget = FadeInImage.assetNetwork(
          fit: BoxFit.contain,
          placeholder: 'assets/img/loading.gif',
          width: 60,
          image: BASE_IMG_PERSONA_URL + persona.imagen);
    }

    Widget subtitle = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          (showDocument
              ? persona.identificacion.toString()
              : persona.perfil.nombre == null
                  ? persona.usuario.correo
                  : persona.perfil.nombre),
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        persona.ubicacion.nombre == null
            ? Container()
            : Text(
                persona.ubicacion.nombre +
                    (persona.ubicacion.padre != null
                        ? ', ' + persona.ubicacion.padre.nombre
                        : ''),
                style: Theme.of(context).textTheme.caption,
              )
      ],
    );

    return Card(
      child: ListTile(
        isThreeLine: true,
        leading: Hero(tag: 'persona-${persona.idPersona}', child: imagenWidget),
        title: Text(
          persona.nombre,
          softWrap: true,
        ),
        subtitle: subtitle,
        trailing: (this.showEstrellas &&
                (persona.perfil.rol == "USUARIO" ||
                    persona.perfil.rol == "TECNICO"))
            ? FutureBuilder(
                future: logroApi.getLogro(idPersonaEnt: persona.idPersona),
                builder: (BuildContext context, AsyncSnapshot<Logro> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Icon(
                        Icons.error_outline,
                        size: 40.0,
                        color: Colors.red,
                      );
                    } else {
                      return FlatButton(
                        onPressed: () => {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              size: 30,
                            ),
                            SizedBox(height: 5),
                            Text(
                              snapshot.data.estrellas.ceilToDouble().toString(),
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            )
                          ],
                        ),
                      );
                      /* return AnimatedStarsIcon(
                        cantidad: snapshot.data.estrellas.ceilToDouble(),
                        color: COLORS_PROFILE[persona.perfil.idPerfil],
                        size: 40.0,
                      );*/
                    }
                  }
                  return Icon(
                    Icons.star,
                    color: Theme.of(context).primaryColor,
                    size: 40.0,
                  );
                },
              )
            : null,
        onTap: onTap,
      ),
    );
  }
  //FloatingIcon
}
