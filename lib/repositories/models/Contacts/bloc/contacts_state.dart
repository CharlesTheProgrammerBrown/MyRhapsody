part of 'contacts_bloc.dart';

abstract class ContactsState extends Equatable {
  const ContactsState();
}

class ContactsInitial extends ContactsState {
  @override
  List<Object> get props => [];
}
