import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tilla_team/services/account_service/repo/account_repo.dart';

part 'account_state.dart';
part 'account_event.dart';

class AccountBloc extends Bloc<AccountListEvent, AccountListState> {
  final AccountRepo accountRepo;
  AccountBloc(this.accountRepo) : super(AccountListStateInital()) {
    on<AccountEventLoaded>((event, emit) async {
      emit(AccountListStateLoading());
      add(AccountListEvent());
    });

    on<AccountEventRefresh>((event, emit) async {
      final allTransaction = await accountRepo.getAllAccounts();

      emit(AccountListStateSuccess(allTransaction));
    });
  }
}
