import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tilla_team/services/transaction_service.dart/transaction_api.dart';

class TransactionRepo {
  TransactionApi transactionApi = TransactionApi();

  Future<String> addTransaction(String date, String accountID, String type,
      double amount, String description, String categoryID) async {
    try {
      var result = await transactionApi.addTransaction(
          date: date,
          accountID: accountID,
          type: type,
          amount: amount,
          description: description,
          categoryID: categoryID);

      if (result.body != "Transaction Added Successfully") {
        String errorMsg = "Couldn't add transaction";
        return errorMsg;
      }
      return result.body.toString();
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Future<List> getAllTransactions() async {
    final result = await transactionApi.getAll();

    if (result.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(result.body);

      List actual = jsonResponse['transactions'];

      return actual;
    } else {
      throw Exception("Failed to load");
    }
  }

  Future<String> sumTransactions() async {
    final result = await transactionApi.getSum();

    if (result.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(result.body);

      String sumResult = jsonResponse['sum'].toString();

      return sumResult;
    } else {
      throw Exception("Failed to sum");
    }
  }
}
