class LoanModel {
  final String id;
  final String clientId;
  final double totalLoan;
  final double interest;
  final double paymentAmount;
  final String status;
  final List<dynamic> history;
  final String? dueDate;     

  LoanModel({
    required this.id,
    required this.clientId,
    required this.totalLoan,
    required this.interest,
    required this.paymentAmount,
    required this.status,
    required this.history,
    this.dueDate,
  });

  factory LoanModel.fromJson(Map<String, dynamic> json) {
    return LoanModel(
      id: json['_id'] ?? '',
      clientId: json['client_id'] ?? '',
      totalLoan: (json['total_loan'] as num).toDouble(),
      interest: (json['interest'] as num).toDouble(),
      paymentAmount: (json['payment_amount'] as num).toDouble(),
      status: json['status'] ?? 'pendiente',
      history: json['history'] ?? [],
      dueDate: json['due_date'], // Puede ser null si no está presente
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'client_id': clientId,
      'total_loan': totalLoan,
      'interest': interest,
      'payment_amount': paymentAmount,
      'status': status,
      'history': history,
      'due_date': dueDate,
    };
  }
}
