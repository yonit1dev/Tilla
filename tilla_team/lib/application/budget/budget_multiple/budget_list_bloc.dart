import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tilla_team/services/budget_service/repo/budget_repo.dart';

part 'budget_list_state.dart';
part 'budget_list_event.dart';

class BudgetListBloc extends Bloc<BudgetListEvent, BudgetListState> {
  final BudgetRepo budgetRepo;
  BudgetListBloc(this.budgetRepo) : super(BudgetListStateInital()) {
    on<BudgetListEventLoaded>((event, emit) async {
      emit(BudgetListStateLoading());
      add(BudgetListEventRefresh());
    });

    on<BudgetListEventRefresh>((event, emit) async {
      final allTransaction = await budgetRepo.getAllBudgets();

      emit(BudgetListStateSuccess(allTransaction));
    });
  }
}
