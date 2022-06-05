class Account {
  final String bankName;
  final double balance;
  final String type;
  final String assocCard;
  final String assocCardExp;

  Account({
    required this.bankName,
    required this.balance,
    required this.type,
    required this.assocCard,
    required this.assocCardExp,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      bankName: json['bankName'],
      balance: json['balance'],
      type: json['type'],
      assocCard: json['assocCard'],
      assocCardExp: json['assocCardExp'],
    );
  }

  Map<String, dynamic> toJson() => {
        'bankName': bankName,
        'balance': balance,
        'type': type,
        'assocCard': assocCard,
        'assocCardExp': assocCardExp,
      };
}
