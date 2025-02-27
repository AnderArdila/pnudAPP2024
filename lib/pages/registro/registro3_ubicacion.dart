import 'package:flutter/material.dart';
import 'package:groovin_widgets/groovin_widgets.dart';

import '../../api/UbicacionApi.dart';
import '../../model/Persona.dart';
import '../../model/Telefono.dart';
import '../../model/Ubicacion.dart';

class RegistroUbicacion extends StatefulWidget {
  final Persona persona;

  final GlobalKey<FormState> formKey;

  RegistroUbicacion({Key key, this.persona, this.formKey}) : super(key: key);

  @override
  _RegistroUbicacionState createState() =>
      new _RegistroUbicacionState(persona: this.persona, formKey: this.formKey);
}

class _RegistroUbicacionState extends State<RegistroUbicacion> {
  final UbicacionApi _ubicacionApi = new UbicacionApi();

  final GlobalKey<FormState> formKey;

  Persona persona;

  List<DropdownMenuItem<Ubicacion>> _dropDownMenuItemsDpto;

  List<DropdownMenuItem<Ubicacion>> _dropDownMenuItemsMncp;

  _RegistroUbicacionState({this.persona, this.formKey}) {
    this._dropDownMenuItemsDpto = [
      _buildMenuItem(
          persona.ubicacion != null && persona.ubicacion.padre != null
              ? persona.ubicacion.padre
              : null)
    ];
    this._dropDownMenuItemsMncp = [
      _buildMenuItem(persona.ubicacion, 'Seleccione un departamento')
    ];
  }

  DropdownMenuItem<Ubicacion> _buildMenuItem(Ubicacion ubicacion,
      [String textLabel = "Cargando..."]) {
    return new DropdownMenuItem<Ubicacion>(
        value: ubicacion,
        child: new Text(
          ubicacion != null && ubicacion.nombre != null
              ? ubicacion.nombre
              : textLabel,
          softWrap: true,
        ));
  }

  @override
  initState() {
    super.initState();
    this._ubicacionApi.getDepartamentos().then(_buildDropDownMenuItemsDpto);
    if (persona.ubicacion != null &&
        persona.ubicacion.padre != null &&
        persona.ubicacion.padre.idUbicacion != null) {
      this
          ._ubicacionApi
          .getMunicipios(persona.ubicacion.padre.idUbicacion)
          .then(_buildDropDownMenuItemsMncp);
    }
  }

  void _buildDropDownMenuItemsDpto(List<Ubicacion> ubicaciones) {
    List<DropdownMenuItem<Ubicacion>> dropDownMenuItems =
        new List<DropdownMenuItem<Ubicacion>>();
    for (Ubicacion ubicacion in ubicaciones) {
      dropDownMenuItems.add(_buildMenuItem(ubicacion));
    }
    setState(() {
      this._dropDownMenuItemsDpto = dropDownMenuItems;
    });
  }

  void _buildDropDownMenuItemsMncp(List<Ubicacion> ubicaciones) {
    List<DropdownMenuItem<Ubicacion>> dropDownMenuItems =
        new List<DropdownMenuItem<Ubicacion>>();
    for (Ubicacion ubicacion in ubicaciones) {
      dropDownMenuItems.add(_buildMenuItem(ubicacion));
    }
    setState(() {
      this._dropDownMenuItemsMncp = dropDownMenuItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        shrinkWrap: true,
        reverse: true,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.grey),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.phone, color: Colors.white),
                    labelText: 'Teléfono',
                    labelStyle: TextStyle(color: Colors.white)),
                // autofocus: true,
                autocorrect: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Por favor ingrese un número de teléfono';
                  }
                  if (value.length < 7) {
                    return 'Por favor ingrese un número de teléfono valido';
                  }
                  try {
                    int.parse(value);
                  } on Exception catch (e) {
                    print(e);
                    return 'Por favor ingrese un número de teléfono valido';
                  }
                },
                initialValue: (this.persona.telefonos.isNotEmpty &&
                        this.persona.telefonos[0] != null
                    ? this.persona.telefonos[0].numero.toString()
                    : ""),
                onSaved: (String value) {
                  this.persona.telefonos = <Telefono>[
                    new Telefono(numero: int.parse(value))
                  ];
                }),
          ),
          SizedBox(height: 10.0),
          Container(
            decoration: BoxDecoration(color: Colors.grey),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: OutlineDropdownButton(
              items: _dropDownMenuItemsDpto,
              isExpanded: true,
              hint: Text("Departamento"),
              value:
                  (persona.ubicacion != null ? persona.ubicacion.padre : null),
              onChanged: (newUbicacion) {
                setState(() {
                  persona.ubicacion = new Ubicacion(padre: newUbicacion);
                  this._dropDownMenuItemsMncp = [
                    _buildMenuItem(persona.ubicacion)
                  ];
                  this
                      ._ubicacionApi
                      .getMunicipios(persona.ubicacion.padre.idUbicacion)
                      .then(_buildDropDownMenuItemsMncp);
                });
              },
              // style: TextStyle(color: Colors.white),

              inputDecoration: InputDecoration(
                  icon: Icon(
                    Icons.place,
                    color: Colors.white,
                  ),
                  border: InputBorder.none),
            ),
          ),

          /*  Text('Departamento', style: Theme.of(context).accentTextTheme.button),
          DropdownButton<Ubicacion>(
            value: (persona.ubicacion != null ? persona.ubicacion.padre : null),
            items: _dropDownMenuItemsDpto,
            onChanged: (Ubicacion newUbicacion) {
              setState(() {
                persona.ubicacion = new Ubicacion(padre: newUbicacion);
                this._dropDownMenuItemsMncp = [
                  _buildMenuItem(persona.ubicacion)
                ];
                this
                    ._ubicacionApi
                    .getMunicipios(persona.ubicacion.padre.idUbicacion)
                    .then(_buildDropDownMenuItemsMncp);
              });
            },
          ),*/
          SizedBox(height: 10.0),
           Container(
            decoration: BoxDecoration(color: Colors.grey),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: OutlineDropdownButton(
              items: _dropDownMenuItemsMncp,
              isExpanded: true,
              hint: Text("Municipio"),
               value: (persona.ubicacion != null &&
                    persona.ubicacion.idUbicacion != null
                ? persona.ubicacion
                : null),
              onChanged: (newUbicacion) {
                setState(() {
                persona.ubicacion = newUbicacion;
              });
              },
              // style: TextStyle(color: Colors.white),
              inputDecoration: InputDecoration(
                  icon: Icon(
                    Icons.person_pin,
                    color: Colors.white,
                  ),
                  border: InputBorder.none),
            ),
          ),
          /* Text('Municipio', style: Theme.of(context).accentTextTheme.button),
          DropdownButton<Ubicacion>(
            value: (persona.ubicacion != null &&
                    persona.ubicacion.idUbicacion != null
                ? persona.ubicacion
                : null),
            items: _dropDownMenuItemsMncp,
            onChanged: (Ubicacion newUbicacion) {
              setState(() {
                persona.ubicacion = newUbicacion;
              });
            },
          ) */
        ].reversed.toList(),
      ),
    );
  }
}
