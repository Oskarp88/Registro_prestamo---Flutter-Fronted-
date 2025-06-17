class CapitalHistoryModel {
  final String id;
  final double amount;
  final String state;
  final String clientName;
  final DateTime creationDate;

  CapitalHistoryModel({
    required this.id,
    required this.amount,
    required this.state,
    required this.clientName,
    required this.creationDate,
  });

  static CapitalHistoryModel empty() => CapitalHistoryModel(
        id: '',
        amount: 0.0,
        state: '',
        clientName: '',
        creationDate: DateTime.now(),
      );

  bool isEmpty() => id.isEmpty;
  bool isNotEmpty() => !isEmpty();

  // Factory para mapear desde JSON
  factory CapitalHistoryModel.fromJson(Map<String, dynamic> json) {
    return CapitalHistoryModel(
      id: json['_id'] ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      state: json['state'] ?? '',
      clientName: json['client_name'] ?? '',
      creationDate: DateTime.tryParse(json['creation_date'] ?? '') ?? DateTime.now(),
    );
  }

  //convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'amount': amount,
      'state': state,
      'client_name': clientName,
      'creation_date': creationDate.toIso8601String(),
    };
  }
}

extension CapitalHistoryModelCopy on CapitalHistoryModel {
  CapitalHistoryModel copyWith({
    String? id,
    double? amount,
    String? state,
    String? clientName,
    DateTime? creationDate,
  }) {
    return CapitalHistoryModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      state: state ?? this.state,
      clientName: clientName ?? this.clientName,
      creationDate: creationDate ?? this.creationDate,
    );
  }
}
