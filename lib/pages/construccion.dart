import 'package:flutter/material.dart';

class ConstruccionPage extends StatelessWidget {
  final String title;

  ConstruccionPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(this.title),
        centerTitle: true,
      ),
      body: new Container(
        padding: EdgeInsets.all(10.0),
        child: new Stack(
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      image: new AssetImage('assets/under-construction.jpg'),
                      fit: BoxFit.cover)),
            ),
            Center(
                child: ListView(
              children: <Widget>[
                new Image.asset('assets/logo_construccion.png'),
                Center(
                  child: Text(
                    "En construcción",
                    style: Theme.of(context).textTheme.display1,
                  ),
                ),
                Text("Nos encontramos construyendo esta funcionalidad",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.body1),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
