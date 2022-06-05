import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tilla_team/application/auth/auth_bloc.dart';
import 'package:tilla_team/ui/auth/login.dart';
import 'package:tilla_team/ui/auth/register.dart';
import 'package:tilla_team/ui/pages/budget/budget_all.dart';
import 'package:tilla_team/ui/pages/transaction/add_transaction.dart';
import 'package:tilla_team/ui/pages/transaction/transaction.dart';
import 'package:tilla_team/ui/pages/welcome.dart';

import '../nav/nav.dart';
import 'budget/add_budget.dart';
import 'global/homepage.dart';

class TillaRoute extends StatelessWidget {
  late final GoRouter router;
  late final SharedPreferences sharedPreferences;
  final AuthBloc authBloc;
  TillaRoute({Key? key, required this.authBloc}) : super(key: key) {
    router = GoRouter(
      refreshListenable: GoRouterRefreshStream(authBloc.stream),
      initialLocation: Routes.splash,
      redirect: (state) {
        if (state is Authenticated &&
            state.location != Routes.splash &&
            state.location != Routes.login) {
          return state.location;
        }
        if (state is Authenticated &&
            state.location != Routes.splash &&
            state.location != Routes.login &&
            state.location != Routes.signup) {
          return Routes.dash;
        }
        if (state is AuthInitial &&
            state.location != Routes.dash &&
            state.location != Routes.signup &&
            state.location != Routes.dash) {
          return Routes.splash;
        }
        if (state is Authenticated && state.location != Routes.dash) {
          return state.location;
        }
        if (state is AuthInitial &&
            state.location != Routes.splash &&
            state.location != Routes.dash) {
          return Routes.dash;
        }
        if (state is AuthInitial && state.location == Routes.dash) {
          return Routes.dash;
        }
        if (state is Authenticated && state.location == Routes.dash) {
          return Routes.dash;
        }
        return null;
      },
      routes: [
        GoRoute(
          path: Routes.dash,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: Routes.splash,
          builder: (context, state) => const WelcomePage(),
        ),
        GoRoute(
          path: Routes.login,
          builder: (context, state) => LoginPage(),
        ),
        GoRoute(
          path: Routes.signup,
          builder: (context, state) => RegisterPage(),
        ),
        GoRoute(
          path: Routes.allBudget,
          builder: (context, state) => const BudgetAll(),
        ),
        GoRoute(
          path: Routes.allTransaction,
          builder: (context, state) => const Transaction(),
        ),
        GoRoute(
          path: Routes.addTransaction,
          builder: (context, state) => const TransactionAdd(),
        ),
        GoRoute(
          path: Routes.addBudget,
          builder: (context, state) => const BudgetAdd(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Tilla',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFEE8042),
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}
