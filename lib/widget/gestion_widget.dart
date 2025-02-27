import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../api/GestionApi.dart';
import '../api/LogroApi.dart';
import '../constants.dart';
import '../model/Gestion.dart';
import '../model/Persona.dart';
import '../model/TipoGasGestionado.dart';


class GestionWidget extends StatelessWidget{

  final GestionApi gestionApi = new GestionApi();

  final LogroApi logroApi = new LogroApi();
  
  final Persona persona;

  final Gestion gestion;
  
  final GestureTapCallback onTap;

  GestionWidget({this.persona, this.gestion, this.onTap});

  @override
  Widget build(BuildContext context) {
    
    Widget title = Column(      
      children: <Widget>[
        Text(persona.nombre, style: Theme.of(context).textTheme.title,textAlign: TextAlign.left,softWrap: true,),
        Divider(),
      ],
    );

    String tiposGasGestionados = "";
    for(TipoGasGestionado tipoGasGestionado in gestion.tiposGasGestionados ){
      tiposGasGestionados += " "+tipoGasGestionado.tipoGas.idTipoGas;
    }  
    final DateFormat dateFormat = new DateFormat("d/M/y H:m:s");
    Widget subtitle = Column(      
      children: <Widget>[
        Text(
          dateFormat.format(gestion.horaFecha),
          style: Theme.of(context).textTheme.caption,
          textAlign: TextAlign.left
        ),
        Container(height: 5.0,),        
        Text(
          tiposGasGestionados, 
          style: Theme.of(context).textTheme.caption,
          textAlign: TextAlign.left
        )
      ],
    );
    
    return new Container(      
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.symmetric(vertical: 5.0),      
      decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          border: new Border.all(color:COLOR_YELLOW, width: 3.0),
        ),
      child: ListTile(
        isThreeLine: true,
        title: title,
        subtitle: subtitle,        
        onTap: onTap,
      ),
    ); 
  }
  //FloatingIcon
}