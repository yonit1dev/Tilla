part of 'account_bloc.dart';

class AccountListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AccountListStateInital extends AccountListState {}

class AccountListStateLoading extends AccountListState {}

class AccountListStateSuccess extends AccountListState {
  List<dynamic> accounts;

  AccountListStateSuccess(this.accounts);
}

class AccountListStateFailure extends AccountListState {}
