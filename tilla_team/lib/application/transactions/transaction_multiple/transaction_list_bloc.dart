import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tilla_team/services/transaction_service.dart/repo/transaction_repo.dart';

part 'transaction_list_event.dart';
part 'transaction_list_state.dart';

class TransactionListBloc
    extends Bloc<TransactionListEvent, TransactionsListState> {
  final TransactionRepo transactionRepo;
  TransactionListBloc(this.transactionRepo)
      : super(TransactionListStateInitial()) {
    on<TransactionListEventLoaded>((event, emit) async {
      emit(TransactionListStateLoading());
      add(TransactionListEventRefresh());
    });

    on<TransactionListEventRefresh>((event, emit) async {
      final allTransaction = await transactionRepo.getAllTransactions();

      emit(TransactionListStateSuccess(allTransaction));
    });
  }
}
