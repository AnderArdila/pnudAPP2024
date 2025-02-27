import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';



class AnimatedStarsIcon extends StatefulWidget{

  final double size;
  
  final Color color;

  final double cantidad;

  AnimatedStarsIcon({Key key, @required this.size, @required this.color, @required this.cantidad}) : super(key: key);


  @override
  _AnimatedStarsIconState createState() => new _AnimatedStarsIconState();
}

class _AnimatedStarsIconState extends State<AnimatedStarsIcon> with SingleTickerProviderStateMixin{

    
  _AnimatedStarsIconState();

  AnimationController controller;

  Animation<double> animation;

  List<Widget> starList;

  @override
  initState() {
    super.initState();
    this.controller = new AnimationController(
      vsync: this,
      duration: Duration(seconds: 2)
    );
    this.animation = Tween(begin: 0.0, end: this.widget.cantidad).animate(this.controller)..addStatusListener((state) => print("$state"));
    this.controller.forward();
  }

  @override
  dispose(){
    this.controller.dispose();
    super.dispose();
  }

  final NumberFormat numberFormat = new NumberFormat("0");
  final Random random = new Random();
  

  @override
  Widget build(BuildContext context) {        
    return new AnimatedBuilder(
      animation: this.animation,
      builder: (BuildContext abContext, Widget child) {
        if(starList == null){
          starList = new List<Widget>();    
          final cantidadStr = numberFormat.format(this.widget.cantidad);
          starList.add(
            Text(
                cantidadStr,
                style: Theme.of(abContext).textTheme.headline.copyWith(fontSize: 0.7*this.widget.size),
                textAlign: TextAlign.left,            
            )
          );
        }
        var left, top, x, y;        
        while(starList.length <= this.animation.value){
          left = random.nextBool();
          top  = random.nextBool();
          x    = random.nextDouble()*(0.9*this.widget.size);
          y    = random.nextDouble()*(0.9*this.widget.size);
          starList.insert(0, Positioned(
              child: Icon(Icons.star, size: (0.3*random.nextDouble()*this.widget.size), color: this.widget.color,),
              left: (left ? x : null),
              right: (!left ? x : null),
              top: (top ? y : null),
              bottom: (!top ? y : null),
            ));          
        }

        return new Container(
          width: this.widget.size,
          height: this.widget.size,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: starList,
          ),
        );

      },      
    );
    
  }

  

}