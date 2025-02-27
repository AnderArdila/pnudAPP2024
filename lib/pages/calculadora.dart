import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/TipoGas.dart';
import 'calculadora_display.dart';
import 'calculadora_tiposgas.dart';

class CalculadoraPage extends StatefulWidget {
  @override
  State<CalculadoraPage> createState() => new _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  double value = 0.0;

  double reu = 0.0;

  double reg = 0.0;

  double nre = 0.0;

  String units = "Estrellas";

  TipoGas tipoGas;

  @override
  void initState() {
    super.initState();
  }

  void _updateValue() {
    setState(() {
      if (tipoGas != null) {
        double reu = (this.reu < 0.0 ? 0.0 : this.reu);
        double reg = (this.reg < 0.0 ? 0.0 : this.reg);
        double nre = (this.nre < 0.0 ? 0.0 : this.nre);
        if (units == "Estrellas") {
          print(
              "cuenta Estrellas $tipoGas:: ${tipoGas.factorEstrellasReuso}*$reu + ${tipoGas.factorEstrellasRegenerado}*$reg + ${tipoGas.factorEstrellasNoRegenerado}*$nre");
          this.value = (tipoGas.factorEstrellasReuso * reu +
              tipoGas.factorEstrellasRegenerado * reg +
              tipoGas.factorEstrellasNoRegenerado * nre);
        }
        if (units == "CO2") {
          print(
              "cuenta CO2 $tipoGas:: ${tipoGas.factorCo2Reuso}*$reu + ${tipoGas.factorCo2Regenerado}*$reg + ${tipoGas.factorCo2NoRegenerado}*$nre");
          this.value = (tipoGas.factorCo2Reuso * reu +
              tipoGas.factorCo2Regenerado * reg +
              tipoGas.factorCo2NoRegenerado * nre);
        }
        if (units == "O3") {
          print(
              "cuenta O3 $tipoGas: ${tipoGas.factorO3Reuso}*$reu + ${tipoGas.factorO3Regenerado}*$reg + ${tipoGas.factorO3NoRegenerado}*$nre");
          this.value = (tipoGas.factorO3Reuso * reu +
              tipoGas.factorO3Regenerado * reg +
              tipoGas.factorO3NoRegenerado * nre);
        }
      } else {
        this.value = 0.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CALCULE SUS ESTRELLAS'), centerTitle: true),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: ListView(children: <Widget>[
          DisplayCalculadora(value: this.value, units: this.units),
          Row(
            children: <Widget>[
              _createButton('Estrellas', 'ESTRELLAS'),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                  child: RaisedButton(
                    shape: StadiumBorder(),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: Text("PAO"),
                    onPressed: () {
                      this.units = "O3";
                      _updateValue();
                    },
                  ),
                ),
              ),
              _createButton('CO2', 'PCG (CO2)'),
            ],
          ),
          _createTitle('Tipo de gas'),
          Container(
            decoration: BoxDecoration(color: Colors.grey[200]),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: CalculadoraTipoGas(
              value: tipoGas,
              onChanged: (value) {
                this.tipoGas = value;
                _updateValue();
              },
            ),
          ),
          SizedBox(height: 20),
          _createTitle('Gas regenerado reutilizado'),
          Container(
            decoration: BoxDecoration(color: Colors.grey[200]),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: TextField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixText: '(Kg)',
                  errorText: (this.reu < 0.0) ? 'El valor no es valido' : null),
              onChanged: (value) {
                try {
                  this.reu = double.parse(value);
                } on Exception catch (e) {
                  print('Error: $e');
                  this.reu = -1.0;
                }
                _updateValue();
              },
            ),
          ),
          SizedBox(height: 20),
          _createTitle('Gas recuperado apto para regenerar'),
          Container(
            decoration: BoxDecoration(color: Colors.grey[200]),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: TextField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixText: '(Kg)',
                  errorText: (this.reu < 0.0) ? 'El valor no es valido' : null),
              onChanged: (value) {
                try {
                  this.reg = double.parse(value);
                } on Exception catch (e) {
                  print('Error: $e');
                  this.reg = -1.0;
                }
                _updateValue();
              },
            ),
          ),
          SizedBox(height: 20),
          _createTitle('Gas recuperado no apto para regenerar'),
          Container(
            decoration: BoxDecoration(color: Colors.grey[200]),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: TextField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixText: '(Kg)',
                  errorText: (this.reu < 0.0) ? 'El valor no es valido' : null),
              onChanged: (value) {
                try {
                  this.nre = double.parse(value);
                } on Exception catch (e) {
                  print('Error: $e');
                  this.nre = -1.0;
                }
                _updateValue();
              },
            ),
          ),
        ]),
      ),
    );
  }

  Widget _createTitle(String title) {
    return Text(title, style: TextStyle(fontSize: 18));
  }

  Widget _createButton(String unit, String text) {
    return Expanded(
      child: RaisedButton(
        shape: StadiumBorder(),
        padding: EdgeInsets.symmetric(horizontal: 15),
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        child: Text(text),
        onPressed: () {
          this.units = unit;
          _updateValue();
        },
      ),
    );
  }
}
