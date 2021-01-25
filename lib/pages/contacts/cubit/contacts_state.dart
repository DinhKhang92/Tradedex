part of 'contacts_cubit.dart';

@immutable
abstract class ContactsState {
  final Map contacts;
  ContactsState({this.contacts});
}

class ContactsInitial extends ContactsState {
  final Map contacts;
  ContactsInitial({@required this.contacts});
}

class ContactsLoading extends ContactsState {
  final Map contacts;
  ContactsLoading({@required this.contacts});
}

class ContactsLoaded extends ContactsState {
  final Map contacts;
  ContactsLoaded({@required this.contacts});
}

class ContactsError extends ContactsState {}
