import 'package:flutter_bloc/flutter_bloc.dart';

class AppObserver extends BlocObserver {
  // @override
  // void onCreate(BlocBase bloc) {
  //   print('bloc created $bloc');
  //   super.onCreate(bloc);
  // }

  // @override
  // void onEvent(Bloc bloc, Object? event) {
  //   print('Event on $bloc : $event');
  //   super.onEvent(bloc, event);
  // }

  // @override
  // void onTransition(Bloc bloc, Transition transition) {
  //   print('on transition $bloc : $transition');
  //   super.onTransition(bloc, transition);
  // }

  @override
  void onChange(BlocBase bloc, Change change) {
    print('${bloc.runtimeType} $change');
    super.onChange(bloc, change);
  }
}
