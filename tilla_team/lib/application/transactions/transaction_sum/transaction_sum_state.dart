part of 'transaction_sum_bloc.dart';

class TransactionSumState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TransactionSumInital extends TransactionSumState {}

class TransactionSumDone extends TransactionSumState {
  final sum;

  TransactionSumDone(this.sum);
}

class TransactionSumFailed extends TransactionSumState {}
