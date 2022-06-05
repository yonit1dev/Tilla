part of 'transaction_list_bloc.dart';

class TransactionListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TransactionListEventInit extends TransactionListEvent {}

class TransactionListEventLoaded extends TransactionListEvent {}

class TransactionListEventRefresh extends TransactionListEvent {}
