class Transactions {
  final String date;
  final String accountID;
  final String type;
  final String amount;
  final String description;
  final String categoryID;

  Transactions(
      {required this.date,
      required this.accountID,
      required this.type,
      required this.amount,
      required this.description,
      required this.categoryID});

  factory Transactions.fromJson(Map<String, dynamic> json) {
    return Transactions(
      date: json['date'],
      accountID: json['accountID'],
      type: json['type'],
      amount: json['amount'],
      description: json['description'],
      categoryID: json['categoryID'],
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date,
        'accountID': accountID,
        'type': type,
        'amount': amount,
        'description': description,
        'categoryID': categoryID,
      };
}
