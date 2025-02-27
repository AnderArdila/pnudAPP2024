import 'package:flutter/material.dart';


class OutlineLabel extends StatelessWidget{

  final String textLabel;
  final Widget child;
  
  OutlineLabel({Key key, this.textLabel, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[        
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),                  
          decoration: BoxDecoration(

            border: Border.all(color: Theme.of(context).textTheme.body1.color),
          ),
          child: this.child,
        ),        
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor
          ),
          child: this.textLabel != null ? Text(this.textLabel) : null,
        ),
      ],
    );
  }

}