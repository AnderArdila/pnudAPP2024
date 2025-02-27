import 'package:flutter/material.dart';

import '../api/TipoGasApi.dart';
import '../model/TipoGas.dart';

class CalculadoraTipoGas extends StatefulWidget {
  final TipoGas value;

  final ValueChanged<TipoGas> onChanged;

  CalculadoraTipoGas({Key key, this.value, this.onChanged}) : super(key: key);

  @override
  _CalculadoraTipoGasState createState() => new _CalculadoraTipoGasState(
      value: this.value, onChanged: this.onChanged);
}

class _CalculadoraTipoGasState extends State<CalculadoraTipoGas> {
  final TipoGasApi tipoGasApi = new TipoGasApi();

  TipoGas value;

  final ValueChanged<TipoGas> onChanged;

  List<DropdownMenuItem<TipoGas>> _dropDownMenuItems =
      <DropdownMenuItem<TipoGas>>[
    new DropdownMenuItem<TipoGas>(value: null, child: new Text("Cargando..."))
  ];

  _CalculadoraTipoGasState({this.value, this.onChanged});

  @override
  initState() {
    super.initState();
    this.tipoGasApi.getTiposGas().then(_buildDropDownMenuItems);
  }

  void _buildDropDownMenuItems(List<TipoGas> tiposGas) {
    List<DropdownMenuItem<TipoGas>> dropDownMenuItems =
        new List<DropdownMenuItem<TipoGas>>();
    for (TipoGas tipoGas in tiposGas) {
      dropDownMenuItems.add(new DropdownMenuItem<TipoGas>(
          value: tipoGas, child: new Text(tipoGas.idTipoGas)));
    }
    setState(() {
      this._dropDownMenuItems = dropDownMenuItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        DropdownButtonHideUnderline(
            child: new DropdownButton<TipoGas>(
          value: this.value,
          items: _dropDownMenuItems,
          onChanged: (value) {
            setState(() {
              this.value = value;
            });
            this.onChanged(value);
          },
        )),
      ],
    );
  }
}
