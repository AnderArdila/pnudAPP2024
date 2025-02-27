import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FloatingIcon extends StatelessWidget {
  final IconData iconData;

  final String assetPath;

  final double cantidad;

  final String unidades;

  final Color color;

  final NumberFormat numberFormat = new NumberFormat("0.00");

  FloatingIcon(
      {this.iconData,
      this.assetPath,
      this.cantidad,
      this.unidades,
      this.color});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = new List<Widget>();
    //
    Widget icon;
    if (this.iconData != null) {
      icon = Icon(iconData, size: 50.0, color: color);
    } else {
      icon = Image(
        image: AssetImage(this.assetPath),
        width: 55.0,
        height: 55.0,
      );
    }
    //
    children.add(icon);

    if (cantidad != null) {
      children.add(Text(
        numberFormat.format(cantidad),
        style:
            Theme.of(context).textTheme.caption.copyWith(color: Colors.white),
      ));
    }

    if (unidades != null) {
      children.add(Text(
        "$unidades",
        style: Theme.of(context).textTheme.button.copyWith(color: color),
        softWrap: true,
      ));
    }

    return Container(
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(color: Colors.grey.withOpacity(0.7)),
        padding: EdgeInsets.all(8),
        width: 65,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: children,
        ));
  }
}
