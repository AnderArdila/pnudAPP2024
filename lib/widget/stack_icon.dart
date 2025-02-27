import 'package:flutter/material.dart';

class StackIcon extends StatelessWidget{

  final IconData bgIconData;

  final IconData iconData;

  StackIcon({this.bgIconData, this.iconData});

  @override
  Widget build(BuildContext context) {
    final double size = Theme.of(context).iconTheme.size ?? 24.0;    
    return Stack(
      children: <Widget>[
        Icon(bgIconData),
        Positioned(
          top: (size/6),
          left: (size/4),
          child: Icon(iconData, size: (size/2),),
        )
      ],
    );
  }

}