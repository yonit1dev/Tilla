// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tilla_team/application/auth/auth_bloc.dart';
import 'package:tilla_team/application/transactions/transaction_multiple/transaction_list_bloc.dart';
import 'package:tilla_team/services/budget_service/repo/budget_repo.dart';
import 'package:tilla_team/services/transaction_service.dart/repo/transaction_repo.dart';
import 'package:tilla_team/services/user_service/repo/user_repo.dart';
import 'package:tilla_team/ui/pages/welcome.dart';
import 'package:go_router/go_router.dart';

import 'application/budget/budget_multiple/budget_list_bloc.dart';
import 'ui/pages/tillaroute.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(() {
    runApp(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => UserRepository(),
          ),
          RepositoryProvider(
            create: (context) => TransactionRepo(),
          ),
          RepositoryProvider(
            create: (context) => BudgetRepo(),
          )
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthBloc(
                userRepository: RepositoryProvider.of<UserRepository>(context),
              ),
            ),
            BlocProvider(
              create: (context) => TransactionListBloc(
                  RepositoryProvider.of<TransactionRepo>(context)),
            ),
            BlocProvider(
              create: (context) =>
                  BudgetListBloc(RepositoryProvider.of<BudgetRepo>(context)),
            ),
            BlocProvider(
              create: (context) => TransactionListBloc(
                  RepositoryProvider.of<TransactionRepo>(context)),
            ),
          ],
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return TillaRoute(
                authBloc: BlocProvider.of<AuthBloc>(context),
              );
            },
          ),
        ),
      ),
    );
  });
}
