// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../nav/nav.dart';
import '../global/transaction_listView.dart';

class Transaction extends StatefulWidget {
  const Transaction({Key? key}) : super(key: key);

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transactions"),
        backgroundColor: Color(0xFF1F2633),
      ),
      body: Container(
        color: Color(0xFFEEEEEE),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                constraints: BoxConstraints(maxWidth: 400),
                child: buildSearchField(),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Last Month",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                  ),
                  InkWell(
                    child: Icon(
                      Icons.add_circle_outline,
                      size: 36,
                      color: Color(0xFFEE8042),
                    ),
                    onTap: () {
                      GoRouter.of(context).push(Routes.addTransaction);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 420,
                child: TransactionsListView(),
              ),
            ],
          ),
        ),
      ),
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

  Widget buildSearchField() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(17),
      child: TextField(
        style: TextStyle(color: Colors.blueGrey),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.blueGrey),
          prefixIcon: Icon(Icons.search, color: Colors.blueGrey),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.7)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.7)),
          ),
        ),
      ),
    );
  }
}
