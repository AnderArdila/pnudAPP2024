import 'package:flutter/material.dart';

import '../api/LogroApi.dart';
import '../model/Logro.dart';
import '../widget/floating_icon.dart';

class LogrosPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LogrosPageState();
}

class _LogrosPageState extends State<LogrosPage> {
  final LogroApi logroApi = new LogroApi();

  Logro logro = new Logro(estrellas: 0.0, co2: 0.0, o3: 0.0);

  void _reloadLogro() async {
    try {
      Logro newLogro = await logroApi.getLogro();
      setState(() {
        this.logro = newLogro;
      });
    } on Exception catch (e) {
      print("$e");
    }
  }

  @override
  void initState() {
    super.initState();
    this._reloadLogro();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FloatingIcon(
              assetPath: "assets/mercury.png",
              cantidad: logro.co2,
              unidades: "Tn Eq CO2",
              color: Colors.white),
          FloatingIcon(
              //iconData: FontAwesomeIcons.globe,
              assetPath: "assets/globe.png",
              cantidad: logro.o3,
              unidades: "Tn PAO",
              color: Colors.white),
          /*
          new FloatingIcon(
            iconData: FontAwesomeIcons.star,
            cantidad: logro.estrellas,
            unidades: "Estrellas",
            color: COLOR_YELLOW,
          ),
          */
        ],
      ),
      onTap: _reloadLogro,
    );
  }
}
