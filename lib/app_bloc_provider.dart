

import 'package:flutter/widgets.dart';

import 'bloc/SecurityBloc.dart';
import 'bloc/MensajesBloc.dart';

class AppBlocProvider extends InheritedWidget{

  final SecurityBloc securityBloc = new SecurityBloc();

  final MensajesBloc mensajesBloc = new MensajesBloc();

  AppBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static SecurityBloc securityBlocOf(BuildContext context) =>(context.inheritFromWidgetOfExactType(AppBlocProvider) as AppBlocProvider).securityBloc;

  static MensajesBloc mensajesBlocOf(BuildContext context) =>(context.inheritFromWidgetOfExactType(AppBlocProvider) as AppBlocProvider).mensajesBloc;

}