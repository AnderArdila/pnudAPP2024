


import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../api/PersonaApi.dart';
import '../model/Persona.dart';

class PersonaBloc{

  final PersonaApi personaApi = new PersonaApi();

  final StreamController<List<Persona>> _resultsController = new StreamController<List<Persona>>();
  final StreamController<int>      _resultsCountController = new StreamController<int>();

  final ReplaySubject<String> _query = ReplaySubject<String>();

  final List<String> roles;
  final String sort;

  Stream<int> get personasCount => this._resultsCountController.stream;
  Stream<List<Persona>> get personas => this._resultsController.stream;

  Sink<String> get query => _query;

  PersonaBloc({this.roles, this.sort}){
    _query.distinct().listen(
      (queryString) => personaApi.getPersonas(roles: this.roles, query: queryString, sort: this.sort).then(_notifyControllers)
    );
    personaApi.getPersonas(roles:this.roles, sort:this.sort).then(_notifyControllers);
  }

  void _notifyControllers(List<Persona> personas){
    _resultsController.add(personas); 
    _resultsCountController.add(personas.length);
  }

  void dispose(){
    _query.close();
    _resultsController.close();
    _resultsCountController.close();
  }


}