import 'package:flutter/material.dart';

const LEVEL_INFO    = 0;
const LEVEL_WARNING = 1;
const LEVEL_ERROR   = 2;

showAlertDialog({@required BuildContext context, @required String title, @required String message, int level = 0, VoidCallback onPressed}){
  Future.delayed(
    Duration.zero, 
    () => showDialog(
      context: context,
      builder: (BuildContext dialogBuildContext) {
        return new AlertDialog(
          title: Text(title),
          content: Text(
            message,
            style: TextStyle(
              color: level == 0 ? Theme.of(context).primaryColor : 
                     level == 1 ? Colors.grey :
                     level == 2 ? Theme.of(context).errorColor :
                     Theme.of(context).primaryColor
            ),
          ),
          actions: <Widget>[            
            FlatButton(
              child: Text("Entendido"),
              onPressed: (){
                Navigator.of(dialogBuildContext).pop();
                if(onPressed != null){
                  onPressed();
                }                
              },
            ),
          ],
        );
      }
    )
  );  
}