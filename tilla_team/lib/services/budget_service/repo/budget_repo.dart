import 'dart:convert';

import 'package:tilla_team/services/budget_service/budget_api.dart';
import 'package:tilla_team/services/local_storage/local_storage.dart';

class BudgetRepo {
  BudgetApi budgetApi = BudgetApi();

  Future<String> addBudget(String type, String accountID, String utilized,
      double goalAmount, String endDate, String description) async {
    try {
      var result = await budgetApi.addBudget(
          type: type,
          accountID: accountID,
          utilized: utilized,
          goalAmount: goalAmount,
          endDate: endDate,
          description: description);

      // var localSaved = LocalStorage();
      // await localSaved.addValues('budgets', result);

      if (result.body != "Budget Added Successfully") {
        String errorMsg = "Coudln't add budget";
        return errorMsg;
      }
      return result.body.toString();
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Future<List> getAllBudgets() async {
    final result = await budgetApi.getAll();

    if (result.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(result.body);

      List actual = jsonResponse['budgets'];

      return actual;
    } else {
      throw Exception("Failed to load - Repo");
    }
  }
}
