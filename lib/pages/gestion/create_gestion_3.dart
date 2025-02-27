import 'package:flutter/material.dart';

import '../../model/Gestion.dart';
import '../../model/TipoGas.dart';
import '../../model/TipoGasGestionado.dart';
import '../../widget/outline_label.dart';
import '../../widget/dialog.dart';


class AddTipoGasGestionadoPage extends StatefulWidget{

  final Gestion gestion;

  final List<TipoGas> tiposGas;

  AddTipoGasGestionadoPage({Key key, this.gestion, this.tiposGas}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _AddTipoGasGestionadoState();

}

class _AddTipoGasGestionadoState extends State<AddTipoGasGestionadoPage>{

  final GlobalKey<ScaffoldState> _scaffoldKey  = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState>     _formKey      = new GlobalKey<FormState>();

  TipoGasGestionado tipoGasGestionado = new TipoGasGestionado(regenerado: 0.0,noRegenerado: 0.0,reuso: 0.0);

  List<TipoGas> tiposGas = new List<TipoGas>();

  @override
  void initState(){
    super.initState();
    //
    if(tiposGas.isEmpty){
      List<TipoGas> oldTiposGas = new List<TipoGas>();
      for( TipoGasGestionado tipoGasGestionado in widget.gestion.tiposGasGestionados ){
        oldTiposGas.add(tipoGasGestionado.tipoGas);
      }
      List<TipoGas> newTiposGas = new List<TipoGas>();
      for(TipoGas tipoGas in widget.tiposGas){
        if( !oldTiposGas.contains( tipoGas ) ){
          newTiposGas.add(tipoGas);
        }
      }
      setState(() {
          this.tiposGas = newTiposGas;      
      });
    }
  }

  List<DropdownMenuItem<TipoGas>> _buildDropDownMenuItems(){
    List<DropdownMenuItem<TipoGas>> dropDownMenuItems = new List<DropdownMenuItem<TipoGas>>();
    for( TipoGas tipoGas in tiposGas ){
      dropDownMenuItems.add(
        new DropdownMenuItem<TipoGas>(
          value: tipoGas,
          child: new Text(tipoGas.idTipoGas)
        )
      );
    }   
    return dropDownMenuItems; 
  }



  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(        
        scaffoldBackgroundColor: Colors.white
      ),
      child: Scaffold(   
        key: _scaffoldKey,     
        appBar: AppBar(
          title: Text('Registrar gestión x Tipo Gas'),
        ), 
        body: Form(
          key: _formKey,
          child: new Container(
            padding: EdgeInsets.all(10.0),          
            child: new ListView(          
              reverse: true,   
              shrinkWrap: true,
              children: <Widget>[ 
                Text("Tipo de gas",style: Theme.of(context).textTheme.headline,),
                new OutlineLabel(
                  textLabel: null,
                  child: Column(                    
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[                      
                      DropdownButtonHideUnderline(                        
                        child: DropdownButton<TipoGas>(                          
                          value: tipoGasGestionado.tipoGas,
                          items: _buildDropDownMenuItems(),
                          onChanged: (TipoGas tipoGas){
                            setState(() {
                              tipoGasGestionado.tipoGas = tipoGas;
                            });
                          },
                        ),
                      ),                      
                    ],
                  ),
                ),
                Divider(height: 40.0,),
                /*new OutlineLabel(
                //  textLabel: 'Gas regenerado reutilizado',                              
                  child:*/ TextFormField(
                    decoration: InputDecoration(
                      hintText: '##.##',             
                      labelText: 'Gas regenerado reutilizado',       
                      suffixText: '(Kg)',              
                    ),
                    keyboardType: TextInputType.number,  
                    textAlign: TextAlign.right,
                    maxLength: 11,            
                    validator: (value) {
                      if (value.isNotEmpty) {
                        try{
                          double.parse(value);
                        } on Exception catch (e){
                          print(e);
                          return 'Por favor ingrese número valido';
                        }
                      }
                    },
                    initialValue: tipoGasGestionado.reuso.toString(),
                    onSaved: (String value){                      
                      tipoGasGestionado.reuso = double.parse(value);                      
                    },
                  ),
                /*),
                //new OutlineLabel(
                //  textLabel: 'Gas recuperado apto para regenerar',                              
                  child:*/ TextFormField(
                    decoration: InputDecoration(
                      hintText: '##.##',
                      labelText: 'Gas recuperado apto para regenerar',
                      suffixText: '(Kg)',              
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.right,                  
                    maxLength: 11,            
                    validator: (value) {
                      if (value.isNotEmpty) {
                        try{
                          double.parse(value);
                        } on Exception catch (e){
                          print(e);
                          return 'Por favor ingrese número valido';
                        }
                      }
                    },
                    initialValue: tipoGasGestionado.regenerado.toString(),
                    onSaved: (String value){                                          
                      tipoGasGestionado.regenerado = double.parse(value);                      
                    },
                  ),
                //),
                /*new OutlineLabel(
                //  textLabel: 'Gas recuperado no apto para regenerar',                              
                  child:*/ TextFormField(
                    decoration: InputDecoration(
                      hintText: '##.##',
                      labelText: 'Gas recuperado no apto para regenerar',
                      suffixText: '(Kg)',              
                    ),
                    keyboardType: TextInputType.number,    
                    textAlign: TextAlign.right,              
                    maxLength: 11,            
                    validator: (value) {
                      if (value.isNotEmpty) {
                        try{
                          double.parse(value);
                        } on Exception catch (e){
                          print(e);
                          return 'Por favor ingrese número valido';
                        }
                      }
                    },
                    initialValue: tipoGasGestionado.noRegenerado.toString(),
                    onSaved: (String value){                                            
                      tipoGasGestionado.noRegenerado = double.parse(value);                        
                    },
                  ),
                //),
                Divider(),
                RaisedButton(
                  child: Text("Registrar"),
                  onPressed: (){
                    if(_formKey.currentState.validate()){
                      _formKey.currentState.save();
                      if(tipoGasGestionado.noRegenerado+tipoGasGestionado.regenerado+tipoGasGestionado.reuso>0.0){
                        Navigator.pop(context, tipoGasGestionado);
                      }
                      else{
                        showAlertDialog(
                          context: context,
                          title: "Gestión",
                          message: "Por favor ingrese las cantidades en el formulario antes de enviarlo..",
                          level: LEVEL_WARNING,
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
                ),                
              ].reversed.toList(),
            ),
          ),
        ),
      ),
    );
  }

}