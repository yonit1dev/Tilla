class Budget {
  final String type;
  final String accountID;
  final String utilized;
  final String goalAmount;
  final String endDate;
  final String description;

  Budget(
      {required this.type,
      required this.accountID,
      required this.utilized,
      required this.goalAmount,
      required this.endDate,
      required this.description});

  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(
      type: json['type'],
      accountID: json['accountID'],
      utilized: json['utilized'],
      goalAmount: json['goalAmount'],
      endDate: json['endDate'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'accountID': accountID,
        'utilized': utilized,
        'goalAmount': goalAmount,
        'endDate': endDate,
        'description': description,
      };
}
