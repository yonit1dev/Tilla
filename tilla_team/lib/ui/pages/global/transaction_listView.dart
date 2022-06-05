// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tilla_team/application/transactions/transaction_multiple/transaction_list_bloc.dart';
import 'package:tilla_team/services/transaction_service.dart/repo/transaction_repo.dart';
import 'package:tilla_team/ui/styles/monoicons.dart';

import '../../../services/transaction_service.dart/transaction_api.dart';

class TransactionsListView extends StatefulWidget {
  const TransactionsListView({Key? key}) : super(key: key);

  @override
  State<TransactionsListView> createState() => _TransactionsListViewState();
}

class _TransactionsListViewState extends State<TransactionsListView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TransactionListBloc(RepositoryProvider.of<TransactionRepo>(context))
            ..add(TransactionListEventLoaded()),
      child: BlocBuilder<TransactionListBloc, TransactionsListState>(
        builder: (context, state) {
          if (state is TransactionListStateSuccess) {
            if (state.transactions.isEmpty) {
              return Center(
                child: Text(
                    'No Transactions! Head over to the add button to start adding transactions'),
              );
            }
            return FutureBuilder<List>(
              future: _fetchTransactions(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data;
                  return _transactionListView(data);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              }),
            );
          }
          if (state is TransactionListStateFailure) {
            return Center(
              child: Text('Failed to load transactions'),
            );
          }
          return Align(
              alignment: Alignment.center, child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<List> _fetchTransactions() async {
    final TransactionRepo transactionRepo = TransactionRepo();
    final response = await transactionRepo.getAllTransactions();

    return response;
  }

  ListView _transactionListView(data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return buildMenuItem(
          text1: data[index]['description'],
          icon: MonoIcons.shopping_cart,
          text2: data[index]['date'],
          trans: data[index]['amount'].toString(),
        );
      },
    );
  }

  Widget buildMenuItem({
    required String text1,
    required IconData icon,
    required String text2,
    required String trans,
  }) {
    const color = Colors.black;
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
        color: color,
      ),
      title: Text(
        text1,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: Text(
        trans,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        text2,
      ),
    );
  }
}
