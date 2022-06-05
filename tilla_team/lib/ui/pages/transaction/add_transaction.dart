// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tilla_team/services/transaction_service.dart/repo/transaction_repo.dart';
import 'package:tilla_team/ui/styles/buttons.dart';
import 'package:tilla_team/ui/styles/textfields.dart';

import '../../nav/nav.dart';

class TransactionAdd extends StatefulWidget {
  const TransactionAdd({Key? key}) : super(key: key);

  @override
  State<TransactionAdd> createState() => _TransactionAddState();
}

class _TransactionAddState extends State<TransactionAdd> {
  int activeIndex = 0;

  TextEditingController amountController = TextEditingController();

  TextEditingController dateController = TextEditingController();

  var typeController = 'Income';

  TextEditingController descriptionController = TextEditingController();

  var accountController = 'AC001';

  var categoryController = 'CA001';

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
                'Add a Transaction',
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
                        controller: amountController,
                        decoration: InputDecoration(hintText: 'Amount'),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.calendar_month,
                        color: Color(0xFFEE8042),
                      ),
                      title: TextField(
                        controller: dateController,
                        decoration: InputDecoration(hintText: 'Date'),
                        onTap: () async {
                          var date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100),
                          );
                          dateController.text =
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
                        items: <String>['Income', 'Expense']
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
                    ListTile(
                      leading: Icon(
                        Icons.book,
                        color: Color(0xFFEE8042),
                      ),
                      title: DropdownButton<String>(
                        value: categoryController,
                        elevation: 16,
                        onChanged: (String? newValue) {
                          setState(() {
                            categoryController = newValue!;
                          });
                        },
                        items: <String>['CA001', 'CA002', 'CA003']
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
              AffirmButtons(
                text: 'Add',
                onPressed: () async {
                  TransactionRepo transactionRepo = TransactionRepo();

                  await transactionRepo.addTransaction(
                      dateController.text,
                      accountController,
                      typeController,
                      double.parse(amountController.text),
                      descriptionController.text,
                      categoryController);

                  GoRouter.of(context).push(Routes.allTransaction);
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
