import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tilla_team/services/transaction_service.dart/repo/transaction_repo.dart';

part 'transaction_sum_state.dart';
part 'transaction_sum_event.dart';

class TransactionSumBloc
    extends Bloc<TransactionSumEvent, TransactionSumState> {
  final TransactionRepo transactionRepo;

  TransactionSumBloc(this.transactionRepo) : super(TransactionSumInital()) {
    on<TransactionSumReq>((event, emit) async {
      final sum = await transactionRepo.sumTransactions();

      emit(TransactionSumDone(sum));
    });
  }
}
