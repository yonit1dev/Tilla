import 'dart:convert';
import 'package:tilla_team/services/local_storage/local_storage.dart';

import '../account_api.dart';

class AccountRepo {
  AccountApi accountApi = AccountApi();

  Future<String> addAccount(String bankName, double balance, String type,
      String assocCard, String assocCardExp) async {
    try {
      var result = await accountApi.addAccount(
          bankName: bankName,
          balance: balance,
          type: type,
          assocCard: assocCard,
          assocCardExp: assocCardExp);

      // var localSaved = LocalStorage();
      // await localSaved.addValues('accounts', result);

      if (result.body != "Account Added Successfully") {
        String errorMsg = "Coudln't add account";
        return errorMsg;
      }
      return result.body.toString();
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Future<List> getAllAccounts() async {
    final result = await accountApi.getAll();

    if (result.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(result.body);

      List actual = jsonResponse['accounts'];

      return actual;
    } else {
      throw Exception("Failed to load - Repo");
    }
  }
}
