import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'contacts_form_event.dart';
part 'contacts_form_state.dart';

class ContactsFormBloc extends Bloc<ContactsFormEvent, ContactsFormState> {
  ContactsFormBloc() : super(ContactsFormInitial());

  @override
  Stream<ContactsFormState> mapEventToState(
    ContactsFormEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
