part of 'budget_list_bloc.dart';

class BudgetListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BudgetListStateInital extends BudgetListState {}

class BudgetListStateLoading extends BudgetListState {}

class BudgetListStateSuccess extends BudgetListState {
  List<dynamic> budgets;

  BudgetListStateSuccess(this.budgets);
}

class BudgetListStateFailure extends BudgetListState {}
