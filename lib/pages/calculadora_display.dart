import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DisplayCalculadora extends StatelessWidget {
  final double value;
  final String units;

  DisplayCalculadora({Key key, this.value, this.units}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Text(
                getTextByInit(this.units),
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 10,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  NumberFormat.decimalPattern().format(value),
                  style: TextStyle(fontSize: 50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getTextByInit(String unit) {
    if (unit == 'CO2') {
      return 'Tn Eq CO2';
    } else if (unit == 'O3') {
      return 'Tn PAO';
    } else if (unit == 'Estrellas') {
      return 'Estrellas';
    } else {
      return '';
    }
  }
}
