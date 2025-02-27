import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:validate/validate.dart';

import '../../model/Persona.dart';

class RegistroUsuario extends StatefulWidget {
  final Persona persona;

  final GlobalKey<FormState> formKey;

  RegistroUsuario({Key key, this.persona, this.formKey}) : super(key: key);

  @override
  _RegistroUsuarioState createState() =>
      new _RegistroUsuarioState(persona: this.persona, formKey: this.formKey);
}

class _RegistroUsuarioState extends State<RegistroUsuario> {
  final GlobalKey<FormState> formKey;

  Persona persona;

  bool _terminosAceptados = false; // Indica si los términos fueron aceptados
  bool _proteccionDatosAceptada = false; // Indica si la protección de datos fue aceptada

  _RegistroUsuarioState({this.persona, this.formKey});

  @override
  initState() {
    super.initState();
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
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(FontAwesomeIcons.solidUserCircle,
                      color: Colors.white),
                  labelText: 'Correo electrónico',
                  labelStyle: TextStyle(color: Colors.white)),
              autocorrect: true,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Por favor ingrese un correo eléctronico';
                }
                try {
                  Validate.isEmail(value);
                } catch (e) {
                  return 'Por favor ingrese un correo eléctronico valido';
                }
              },
              initialValue: (this.persona.usuario.correo ?? ""),
              onSaved: (String value) {
                this.persona.usuario.correo = value;
              },
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            decoration: BoxDecoration(color: Colors.grey),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.vpn_key,
                    color: Colors.white,
                  ),
                  labelText: 'Contraseña',
                  labelStyle: TextStyle(color: Colors.white)),
              obscureText: true,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Por favor ingrese una contraseña';
                } else if (value.length < 6) {
                  return 'Por favor ingrese una contraseña de 6 o más caracteres';
                }
              },
              initialValue: (this.persona.usuario.clave ?? ""),
              onSaved: (String value) {
                this.persona.usuario.clave = value;
              },
            ),
          ),


          // Ander
          SizedBox(height: 10.0),
          // Enlace para aceptar términos y condiciones
            GestureDetector(
              onTap: () => _mostrarModal( // Función que muestra el modal con los términos y condiciones
                context,
                "Aceptar términos y condiciones", // Título del modal
                "Aquí se describen los términos y condiciones. Este es un texto de ejemplo que puede ser largo y tendrá scroll para visualizar todo el contenido.  Exercitation deserunt dolore anim commodo veniam mollit veniam laboris aute in. Tempor nostrud laborum ullamco ex ipsum. Aute excepteur aliquip nostrud voluptate sunt ad non Lorem fugiat irure laboris. Labore ex cillum voluptate consequat. Tempor enim cupidatat fugiat adipisicing Laborum adipisicing amet esse consequat velit exercitation. Quis nulla voluptate eiusmod minim quis nostrud consequat ex labore sint laborum sit sint tempor. Id commodo commodo et eiusmod cupidatat commodo reprehenderit do pariatur et  Consequat ea occaecat Proident commodo laborum voluptate veniam labore excepteur anim sunt quis. Cupidatat magna fugiat dolor enim voluptate pariatur minim aute dolore ea ea voluptate. Esse exercitation amet proident magna consequat aute culpa esse irure. Nostrud veniam non consectetur pariatur labore dolor id incididunt ea culpa. Ullamco in non esse nostrud. Mollit esse ad excepteur irure sit id cupidatat magna tempor non cillum Lorem culpa ex. Officia sit veniam deserunt cupidatat culpa Lorem ea dolor laborum deserunt reprehenderit ea incididunt.exercitation aliquip. Velit minim sit nisi eu dolore amet ad. Nulla ullamco qui aliqua pariatur proident pariatur ex elit amet culpa.consequat. Ad quis nisi elit magna labore consequat exercitation. In dolor ut sunt do id magna ea velit deserunt. Culpa aliqua enim duis id et aute aliquip minim ipsum deserunt excepteur eiusmod exercitation. aliquip occaecat duis consectetur tempor Enim in sit officia duis est laborum eu dolore non et anim esse nulla commodo. Dolore nulla tempor labore laboris id enim aute incididunt ut aliqua nisi irure cupidatat. In consectetur enim exercitation mollit ea excepteur irure. Ipsum amet voluptate anim est nisi. Ea incididunt qui ut sunt. Consectetur ad est tempor nulla excepteur. irure laboris dolore et. Occaecat magna sit non ullamco commodo esse. Adipisicing occaecat commodo mollit eu excepteur qui cillum enim. Adipisicing veniam laborum aute tempor nulla quis. Cillum pariatur voluptate non cupidatat nulla cillum amet Lorem aliqua duis. Nulla cupidatat ea veniam exercitation aliquip laboris irure.",
                (valor) {
                  setState(() {
                    _terminosAceptados = valor;
                  });
                },
                _terminosAceptados,
              ),
              child: Text(
                "Aceptar términos y condiciones",
                style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
              ),
            ),

            // Ander
            SizedBox(height: 10.0),
            // Enlace para aceptar protección de datos
            GestureDetector(
              onTap: () => _mostrarModal(
                context,
                "Aceptar protección de datos",
                "Aquí se explica cómo protegemos tus datos personales. Este es un texto de ejemplo que puede ser largo y tendrá scroll para visualizar todo el contenido.",
                (valor) {
                  setState(() {
                    _proteccionDatosAceptada = valor;
                  });
                },
                _proteccionDatosAceptada,
              ),
              child: Text(
                "Aceptar protección de datos",
                style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
              ),
            ),

        ].reversed.toList(), // Reversa la lista para que los elementos se muestren en el orden correcto
      ),
    );
  }



  // Función que muestra un modal con los términos y condiciones
   void _mostrarModal(
    BuildContext context, 
    String titulo, 
    String contenido, 
    Function(bool) OnAceptado, 
    bool aceptadoInicial
    ) {
    showDialog( //
      context: context,
      builder: (BuildContext context) {
        bool aceptado = aceptadoInicial; // Estado local para el check
        return StatefulBuilder(
          
          builder: (context, setState) {
            return AlertDialog(
              title: Text(titulo),
              content: SingleChildScrollView(
                
                child: Column(
                  children: <Widget>[
                    Text(contenido),
                    CheckboxListTile(
                      title: Text("Acepto los términos y condiciones"),
                      value: aceptado,
                      onChanged: (bool value) {
                        setState(() {
                          aceptado = value;
                        });
                      },
                    ),
                  ],
                ),
                
              ),

              actions: <Widget>[

                FlatButton( // Botón para aceptar
                  child: Text('Aceptar'),
                  onPressed: () {
                    OnAceptado(aceptado);
                    Navigator.of(context).pop();
                  },
                ), // Botón para aceptar
                FlatButton( // Botón para cancelar
                  child: Text('Cancelar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ), 

              ],



            );
          },
        );


      },
    );
  } 






}
