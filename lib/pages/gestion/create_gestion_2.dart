import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../api/GestionApi.dart';
import '../../api/TipoGasApi.dart';
import '../../model/Gestion.dart';
import '../../model/Persona.dart';
import '../../model/TipoGas.dart';
import '../../model/TipoGasGestionado.dart';
import '../../widget/persona_widget.dart';
import 'create_gestion_3.dart';
import '../../widget/dialog.dart';

class CreateGestionPage2 extends StatefulWidget{

  final Persona personaQueEntrega;
  final Persona personaQueGestiona;

  CreateGestionPage2({Key key, this.personaQueEntrega, this.personaQueGestiona}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _CreateGestionPage2State(
    gestion: new Gestion(
      personaQueEntrega: this.personaQueEntrega,
      personaQueGestiona: this.personaQueGestiona,      
      tiposGasGestionados: new List<TipoGasGestionado>(),
    )
  );

}

class _CreateGestionPage2State extends State<CreateGestionPage2>{

  final GlobalKey<ScaffoldState> _scaffoldKey  = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState>     _formKey      = new GlobalKey<FormState>();
  final TipoGasApi               _tipoGasApi   = new TipoGasApi();
  final GestionApi               _gestionApi   = new GestionApi();

  List<TipoGas> tiposGas = new List<TipoGas>();

  Gestion gestion;

  _CreateGestionPage2State({this.gestion});

  @override
  initState() {
    super.initState();        
    if( tiposGas.isEmpty ){
      this._tipoGasApi.getTiposGas().then(
        (tiposGas){          
          setState(() {
             this.tiposGas = tiposGas;
          });
        }
      );
    }    
  }

  Widget _buildTipoGasGestionadoItem(BuildContext context, TipoGasGestionado tipoGasGestionado){
    return Card(      
      margin: EdgeInsets.symmetric(vertical:10.0),
      child: ExpansionTile(
        title: Text(tipoGasGestionado.tipoGas.idTipoGas),
        children: <Widget>[
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Recuperado apto para regenerar", softWrap: true,),
                Text("${tipoGasGestionado.regenerado}") 
              ],
            ),
          ),              
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Recuperado no apto para regenerar", softWrap: true,),
                Text("${tipoGasGestionado.noRegenerado}") 
              ],
            ),
          ),                
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Regenerado reutilizado", softWrap: true,),
                Text("${tipoGasGestionado.reuso}")  
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: FlatButton(
              child: Text("Eliminar"),
              onPressed: (){
                setState(() {
                  gestion.tiposGasGestionados.remove(tipoGasGestionado);                  
                });
              },
            ),
          ),
        ],

      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> items = new List<Widget>();
    items.add(
      new PersonaWidget(
        persona: this.gestion.personaQueEntrega,
        showDocument: true,
      )      
    );
    items.add(
      Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          "2. Agregue las cantidades segun el tipo de gas",
          textAlign: TextAlign.justify,
          softWrap: true,
          style: Theme.of(context).textTheme.headline,
        ),
      )
    );  
    if(gestion.tiposGasGestionados != null && gestion.tiposGasGestionados.isNotEmpty){
      for(TipoGasGestionado tipoGasGestionado in gestion.tiposGasGestionados){
        items.add(this._buildTipoGasGestionadoItem(context, tipoGasGestionado));
      }
    }         
    FloatingActionButton fab;
    if( gestion.tiposGasGestionados.length < this.tiposGas.length ){
      fab = new FloatingActionButton(
        child: Icon(FontAwesomeIcons.plus),
        onPressed: () async{
            TipoGasGestionado tipoGasGestionado = await Navigator.push(
              context,            
              MaterialPageRoute(
                builder: (context) => new AddTipoGasGestionadoPage(gestion: gestion, tiposGas: tiposGas)
              ),
            );
            if( tipoGasGestionado != null ){
              gestion.tiposGasGestionados.add(tipoGasGestionado);
            }
          },
      );      
    }
    if( gestion.tiposGasGestionados.isNotEmpty ){
      items.add(
        RaisedButton(
          child: Text("Registrar"),
          elevation: 10.0,
          onPressed: () async{
            if (this._formKey.currentState.validate()) {
                  _formKey.currentState.save();                         
                try{
                  await _gestionApi.postGestion(this.gestion);                          
                  showAlertDialog(
                    context: context,
                    title: "Gestión",
                    message: "La gestión ha sido registrada.",
                    level: LEVEL_INFO,
                    onPressed: (){
                      Navigator.of(context).pop();
                    }
                  );
                } on Exception catch( e ){
                  showAlertDialog(
                      context: context,
                      title: "Gestión",
                      message: "Error inesperado $e",
                      level: LEVEL_ERROR,                      
                    );
                }                        
              }
              else{
                showAlertDialog(
                  context: context,
                  title: "Gestión",
                  message: "Por favor revise los errores en el formulario antes de enviarlo.",
                  level: LEVEL_WARNING,                      
                );
              }
          },
        )
      );
    }
    

    return Theme(
      data: Theme.of(context).copyWith(        
        cardColor: Colors.white,
      ),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Registrar gestión'),
        ), 
        body: Form(
          key: _formKey,
          child: new Container(
            padding: EdgeInsets.all(10.0),          
            child: new ListView(                           
              children: items
            ),
          ),
        ),
        floatingActionButton: fab,        
      ),
    );
  }

}