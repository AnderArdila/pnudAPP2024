import 'package:flutter/material.dart';

import '../../api/PerfilApi.dart';
import '../../model/Perfil.dart';

class RegistroPerfil extends StatefulWidget {
  final Perfil perfil;

  final ValueChanged<Perfil> onChanged;

  RegistroPerfil({Key key, this.perfil, this.onChanged}) : super(key: key);

  @override
  _RegistroPerfilState createState() =>
      new _RegistroPerfilState(perfil: this.perfil, onChanged: this.onChanged);
}

class _RegistroPerfilState extends State<RegistroPerfil> {
  final PerfilApi _perfilApi = new PerfilApi();

  Perfil perfil;

  final ValueChanged<Perfil> onChanged;

  List<Perfil> _perfiles = new List<Perfil>();

  _RegistroPerfilState({this.perfil, this.onChanged});

  @override
  initState() {
    super.initState();
    if (this._perfiles.isEmpty) {
      this
          ._perfilApi
          .getPerfiles(roles: ["USUARIO", "TECNICO"]).then((perfiles) {
        setState(() {
          this._perfiles = perfiles;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        shrinkWrap: true,
        itemCount: this._perfiles.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              color: (this.perfil == this._perfiles[index]
                  ? Colors.deepOrange
                  : Colors.grey),
              child: new ListTile(
                  leading: new Image(
                      image: new AssetImage(
                          'assets/${this._perfiles[index].idPerfil}.png'
                              .toLowerCase()),
                      width: 50.0),
                  title: Text(this._perfiles[index].nombre,
                      style: TextStyle(color: Colors.white)),
                  selected: (this.perfil == this._perfiles[index]),
                  onTap: () {
                    setState(() {
                      this.perfil = this._perfiles[index];
                    });
                    this.onChanged(this._perfiles[index]);
                  }));
        });
  }
}
