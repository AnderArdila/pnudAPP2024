import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';



class StarsIcon extends StatelessWidget{


  final double size;
  
  final Color color;

  final double cantidad;

  final NumberFormat numberFormat = new NumberFormat("0");

  StarsIcon({@required this.cantidad, @required this.color, @required this.size});

  @override
  Widget build(BuildContext context) {    
    final cantidadStr = numberFormat.format(cantidad);
    Random random = new Random();
    final List<Widget> widgets = new List<Widget>();        
      for( var i = 0; i < min(cantidad,100); i++ ){
        var left = random.nextBool();
        var top  = random.nextBool();
        var x    = random.nextDouble()*(0.9*size);
        var y    = random.nextDouble()*(0.9*size);
        widgets.add(
          Positioned(
            child: Icon(Icons.star, size: (0.2*size), color: color,),
            left: (left ? x : null),
            right: (!left ? x : null),
            top: (top ? y : null),
            bottom: (!top ? y : null),
          )
        );
      }
      widgets.add(      
        Text(
            cantidadStr,
            style: Theme.of(context).textTheme.headline.copyWith(fontSize: 0.7*size),
            textAlign: TextAlign.left,            
        )        
      );


    return new Container(
      width: size,
      height: size,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: widgets,
      ),
    );

    
  }

}