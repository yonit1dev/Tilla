part of 'account_bloc.dart';

class AccountListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AccountEventInit extends AccountListEvent {}

class AccountEventLoaded extends AccountListEvent {}

class AccountEventRefresh extends AccountListEvent {}
