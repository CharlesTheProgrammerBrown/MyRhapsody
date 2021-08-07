import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(cubit, error, stackTrace);
  }

  @override
  void onEvent(Bloc cubit, Object event) {
    print(event);
    super.onEvent(cubit, event);
  }

  @override
  void onTransition(Bloc cubit, Transition transition) {
    print(transition);
    super.onTransition(cubit, transition);
  }
}
