
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../model/Persona.dart';
import '../../model/Logro.dart';
import '../../api/LogroApi.dart';
import '../../widget/floating_icon.dart';
import '../../constants.dart';

class PersonaLogroPage extends StatefulWidget{

  final Persona persona;  

  PersonaLogroPage({this.persona});

  @override
  State<StatefulWidget> createState() => new _PersonaLogroPageState();

}
 
class _PersonaLogroPageState extends State<PersonaLogroPage>{
  
  final LogroApi logroApi = new LogroApi();

  Logro logroEnt = new Logro(estrellas: 0.0, co2: 0.0, o3: 0.0);

  Logro logroGes = new Logro(estrellas: 0.0, co2: 0.0, o3: 0.0);

  _PersonaLogroPageState();

  void _reloadLogro() async {
    try{
      Logro newLogroEnt = await logroApi.getLogro(idPersonaEnt: widget.persona.idPersona);
      Logro newLogroGes = await logroApi.getLogro(idPersonaGes: widget.persona.idPersona);
      setState(() {
        this.logroEnt = newLogroEnt;
        this.logroGes = newLogroGes;
      });
    }
    on Exception catch( e ){
      print("$e");
    }
    
  }

  @override
  void initState(){
    super.initState();
    this._reloadLogro();
  }
 
  
  @override
  Widget build(BuildContext context) {
    
    List<Widget> colItems = new List<Widget>();
    List<Widget> rowItems = new List<Widget>();

    
    rowItems.add(
      new FloatingIcon(
        iconData: FontAwesomeIcons.thermometerQuarter, 
        cantidad: logroEnt.co2,           
        unidades: "Tn Eq CO2",
        color: Colors.white
      )        
    );
    rowItems.add(
      new FloatingIcon(
        assetPath: "assets/co2.png",            
        cantidad: logroEnt.o3,
        unidades: "Tn PAO",
        color: Colors.white
      )
    );        
    if(widget.persona.perfil.rol == "USUARIO" || widget.persona.perfil.rol == "TECNICO"){
      rowItems.add(
        new FloatingIcon(
          iconData: Icons.star,            
          cantidad: logroEnt.estrellas,
          unidades: "Estrellas",
          color: COLOR_YELLOW,
        )        
      );      
    }
    colItems.add(
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: rowItems,
      )
    );    
    if(widget.persona.perfil.rol == "GESTOR"){
      colItems.add(Divider());
      if(widget.persona.perfil.idPerfil == "CA" || widget.persona.perfil.idPerfil == "CAD"){
        colItems.add(
          ListTile(            
            title: Text("Acopió/Recolección de gas recuperado apto para regenerar", style: Theme.of(context).textTheme.headline, softWrap: true,),
            trailing: Text("${logroGes.regenerado}"),
          )
        );
        if(widget.persona.perfil.idPerfil == "CA"){
            colItems.add(
            ListTile(            
              title: Text("Acopió/Recolección de gas recuperado no apto para regenerar (Destrucción)", style: Theme.of(context).textTheme.headline, softWrap: true,),
              trailing: Text("${logroGes.noRegenerado}"),
            )
          );
        }
        else{
          colItems.add(
            ListTile(            
              title: Text("Gas refrigerante No apto para regenerar (Destrucción)", style: Theme.of(context).textTheme.headline, softWrap: true,),
              trailing: Text("${logroGes.noRegenerado}"),
            )
          );
        }
        

        colItems.add(
          ListTile(            
            title: Text("Suministró gas regenerado reutilizado", style: Theme.of(context).textTheme.headline, softWrap: true,),
            trailing: Text("${logroGes.reuso}"),
          )
        );
      }
      else{
        colItems.add(
          ListTile(            
            title: Text("Gas refrigerante regenerado", style: Theme.of(context).textTheme.headline, softWrap: true,),
            trailing: Text("${logroGes.regenerado}"),
          )
        );
        colItems.add(
          ListTile(            
            title: Text("Gas refrigerante No apto para regenerar (Destrucción)", style: Theme.of(context).textTheme.headline, softWrap: true,),
            trailing: Text("${logroGes.noRegenerado}"),
          )
        );
        colItems.add(
          ListTile(            
            title: Text("Suministró gas regenerado reutilizado", style: Theme.of(context).textTheme.headline, softWrap: true,),
            trailing: Text("${logroGes.reuso}"),
          )
        );
        
        
      }      
    }
    colItems.add(Divider());
    return new Container(      
      margin: EdgeInsets.symmetric(vertical: 5.0),
      padding: EdgeInsets.symmetric(vertical: 5.0),
      color: Theme.of(context).canvasColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: colItems,
      )
    );
  }

}