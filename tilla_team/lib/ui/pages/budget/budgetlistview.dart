// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tilla_team/application/budget/budget_multiple/budget_list_bloc.dart';
import 'package:tilla_team/services/budget_service/repo/budget_repo.dart';
import 'package:tilla_team/ui/styles/monoicons.dart';

import '../../nav/nav.dart';

class BudgetListView extends StatefulWidget {
  const BudgetListView({Key? key}) : super(key: key);

  @override
  State<BudgetListView> createState() => _BudgetListViewState();
}

class _BudgetListViewState extends State<BudgetListView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BudgetListBloc(
        RepositoryProvider.of<BudgetRepo>(context),
      )..add(
          BudgetListEventLoaded(),
        ),
      child: BlocBuilder<BudgetListBloc, BudgetListState>(
        builder: (context, state) {
          if (state is BudgetListStateSuccess) {
            if (state.budgets.isEmpty) {
              return const Center(
                child: Text(
                    'No Budgets! Head over to the add button to start your saving journey'),
              );
            }
            return FutureBuilder<List>(
              future: _fetchBudgets(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data;
                  return _budgetListView(data);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const CircularProgressIndicator();
              }),
            );
          }
          if (state is BudgetListStateFailure) {
            return const Center(
              child: Text('Failed to load budget'),
            );
          }
          return const Align(
              alignment: Alignment.center, child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<List> _fetchBudgets() async {
    final BudgetRepo budgetRepo = BudgetRepo();
    final response = await budgetRepo.getAllBudgets();

    return response;
  }

  ListView _budgetListView(data) {
    return ListView.separated(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return buildBudgetItem(
            text1: data[index]['description'],
            icon: MonoIcons.check,
            text2: (data[index]['goalAmount']),
            util: data[index]['utilized'],
            dateEnd: data[index]['endDate']);
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );
  }

  Widget buildBudgetItem(
      {required String text1,
      required IconData icon,
      required int text2,
      required String util,
      required String dateEnd}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        color: Color(0xFFCCCCCC),
        padding: EdgeInsets.symmetric(horizontal: 35, vertical: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      color: Color(0xFF1F2633),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      text1,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    )
                  ],
                ),
                InkWell(
                  child: const Text(
                    'Edit',
                    style: TextStyle(
                      color: Color(0xFF1F2630),
                    ),
                  ),
                  onTap: () {
                    GoRouter.of(context).push(Routes.editBudget);
                  },
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "Your goal amount -> " + text2.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFFEE8042),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Utilization",
                  style: TextStyle(
                      color: Color(0xFF1F2630), fontWeight: FontWeight.w500),
                ),
                Text(
                  util.toString(),
                  style: TextStyle(
                      color: Color(0xFF1F2630), fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 15,
              child: LinearProgressIndicator(
                value: double.parse(util),
                backgroundColor: Color(0xFFEEEEEE),
                color: Colors.green,
              ),
            )
          ],
        ),
      ),
    );
  }
}
