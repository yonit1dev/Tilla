part of 'transaction_list_bloc.dart';

class TransactionsListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TransactionListStateInitial extends TransactionsListState {}

class TransactionListStateLoading extends TransactionsListState {}

class TransactionListStateSuccess extends TransactionsListState {
  List<dynamic> transactions;

  TransactionListStateSuccess(this.transactions);
}

class TransactionListStateFailure extends TransactionsListState {}
