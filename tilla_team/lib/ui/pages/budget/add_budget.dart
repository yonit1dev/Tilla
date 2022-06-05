// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tilla_team/services/budget_service/repo/budget_repo.dart';
import 'package:tilla_team/services/transaction_service.dart/repo/transaction_repo.dart';
import 'package:tilla_team/ui/styles/buttons.dart';
import 'package:tilla_team/ui/styles/textfields.dart';

import '../../nav/nav.dart';

class BudgetAdd extends StatefulWidget {
  const BudgetAdd({Key? key}) : super(key: key);

  @override
  State<BudgetAdd> createState() => _BudgetAddState();
}

class _BudgetAddState extends State<BudgetAdd> {
  int activeIndex = 0;

  var typeController = 'Monthly';

  var accountController = 'AC001';

  TextEditingController goalAmountController = TextEditingController();

  TextEditingController endDateController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        title: const Text(
          'Back',
          style: TextStyle(color: Color(0xFF1F2633)),
        ),
        elevation: 0,
        backgroundColor: const Color(0xFFEEEEEE),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Start Saving',
                style: TextStyle(
                    color: Color(0xFF1F2633),
                    fontWeight: FontWeight.w600,
                    fontSize: 22),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.money,
                        color: Color(0xFFEE8042),
                      ),
                      title: TextField(
                        controller: goalAmountController,
                        decoration: InputDecoration(hintText: 'Goal Amount'),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.calendar_month,
                        color: Color(0xFFEE8042),
                      ),
                      title: TextField(
                        controller: endDateController,
                        decoration: InputDecoration(hintText: 'End Date'),
                        onTap: () async {
                          var date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100),
                          );
                          endDateController.text =
                              date.toString().substring(0, 10);
                        },
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.merge_type_rounded,
                        color: Color(0xFFEE8042),
                      ),
                      title: DropdownButton<String>(
                        value: typeController,
                        elevation: 16,
                        onChanged: (String? newValue) {
                          setState(() {
                            typeController = newValue!;
                          });
                        },
                        items: <String>[
                          'Monthly',
                          'Weekly',
                          'Yearly',
                          'Long-term'
                        ].map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.account_balance_wallet,
                        color: Color(0xFFEE8042),
                      ),
                      title: DropdownButton<String>(
                        value: accountController,
                        elevation: 16,
                        onChanged: (String? newValue) {
                          setState(() {
                            accountController = newValue!;
                          });
                        },
                        items: <String>['AC001', 'AC002', 'AC003']
                            .map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Details',
                style: TextStyle(
                    color: Color(0xFF1F2633),
                    fontWeight: FontWeight.w600,
                    fontSize: 22),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white),
                child: Column(
                  children: [
                    ListTile(
                        leading: Icon(
                          Icons.padding,
                          color: Color(0xFFEE8042),
                        ),
                        title: TextField(
                          controller: descriptionController,
                          decoration: InputDecoration(hintText: 'Description'),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              AffirmButtons(
                text: 'Add',
                onPressed: () async {
                  BudgetRepo budgetRepo = BudgetRepo();

                  await budgetRepo.addBudget(
                      typeController,
                      accountController,
                      '0.46',
                      double.parse(goalAmountController.text),
                      endDateController.text,
                      descriptionController.text);

                  GoRouter.of(context).push(Routes.allBudget);
                },
                size: const Size(double.infinity * 0.5, 50),
              )
            ],
          ),
        ),
      ),
    );
  }
}
