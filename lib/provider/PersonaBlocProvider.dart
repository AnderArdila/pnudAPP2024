import 'package:flutter/widgets.dart';

import '../bloc/PersonaBloc.dart';

class PersonaBlocProvider extends InheritedWidget{

  final PersonaBloc personaBloc;

  PersonaBlocProvider({Key key, this.personaBloc, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static PersonaBloc personaBlocOf(BuildContext context) =>(context.inheritFromWidgetOfExactType(PersonaBlocProvider) as PersonaBlocProvider).personaBloc;

}