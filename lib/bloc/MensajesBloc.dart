import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rxdart/rxdart.dart';

import '../model/Notificacion.dart';
import '../main.dart';

class MensajesBloc{

  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();  

  List<Notificacion> _notificaciones = new List<Notificacion>();

  final StreamController<List<Notificacion>> _messageController      = new StreamController<List<Notificacion>>();
  final StreamController<int>                _messageCountController = new StreamController<int>();

  final BehaviorSubject<List<Notificacion>> _messages      = BehaviorSubject<List<Notificacion>>(onListen: (){new List<Notificacion>();});
  final BehaviorSubject<int>                _messagesCount = BehaviorSubject<int>();

  Stream<List<Notificacion>> get messages      => this._messages.stream;
  Stream<int>                get messagesCount => this._messagesCount.stream;


  _onMessage(Notificacion notificacion){
    print("Llego un mensaje: $notificacion");    
    this._notificaciones.add(notificacion);
    _messageController.add( this._notificaciones );
    _messageCountController.add( this._notificaciones.length );
  }

  removeMessage(Notificacion notificacion){
    print("Llego una solicitud para eliminar un mensaje: $notificacion"); 
    this._notificaciones.remove(notificacion);
    _messageController.add( this._notificaciones );
    _messageCountController.add( this._notificaciones.length );
  }

  MensajesBloc(){    
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) => _onMessage( Notificacion.fromJson(message) ),
      onResume: (Map<String, dynamic> message) => _onMessage( Notificacion.fromJson(message) ),
      onLaunch: (Map<String, dynamic> message) => _onMessage( Notificacion.fromJson(message) ),
    );
    _firebaseMessaging.requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true));    
    _firebaseMessaging.getToken().then(      
      (token){
        fcmKey = token;        
      }
    );    
    this._messageController.stream.listen( (notificaciones) => this._messages.add(notificaciones) );
    this._messageCountController.stream.listen( (countNotificaciones) => this._messagesCount.add(countNotificaciones) );
  }

  void dispose(){    
    _messageController.close();    
    _messages.close();
    //
    _messageCountController.close();    
    _messagesCount.close();
  }

}