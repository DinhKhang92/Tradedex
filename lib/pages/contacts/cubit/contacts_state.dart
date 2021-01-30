part of 'contacts_cubit.dart';

@immutable
abstract class ContactsState {
  final Map contacts;
  final int navIdx;
  ContactsState({this.contacts, this.navIdx});
}

class ContactsInitial extends ContactsState {
  final Map contacts;
  final int navIdx;
  ContactsInitial({
    @required this.contacts,
    @required this.navIdx,
  });
}

class ContactsLoading extends ContactsState {
  final Map contacts;
  final int navIdx;
  ContactsLoading({
    @required this.contacts,
    @required this.navIdx,
  });
}

class ContactsLoaded extends ContactsState {
  final Map contacts;
  final int navIdx;
  ContactsLoaded({
    @required this.contacts,
    @required this.navIdx,
  });
}

class ContactsError extends ContactsState {}
