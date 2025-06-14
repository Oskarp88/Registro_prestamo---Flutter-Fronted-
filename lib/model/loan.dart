class LoanModel {
  final String id;
  final String clientId;
  final String name;
  final double totalLoan;
  final double interest;
  final double paymentAmount;
  final String status;
  final List<dynamic> history;
  final String? dueDate;  
  final bool interest10;   

  LoanModel({
    required this.id,
    required this.clientId,
    required this.totalLoan,
    required this.interest,
    required this.paymentAmount,
    required this.status,
    required this.history,
    required this.name,
    this.dueDate,
    required this.interest10,
  });

  static LoanModel empty () => LoanModel(
    id: '',
    clientId: '',
    name: '',
    interest: 0,
    paymentAmount: 0,
    totalLoan: 0,
    dueDate: '',
    history: [],
    status: '',
    interest10: false
  );
  
    bool isEmpty() {
    return id.isEmpty;
  }

  bool isNotEmpty() {
    return !isEmpty();
  }

  factory LoanModel.fromJson(Map<String, dynamic> json) {
    return LoanModel(
      id: json['_id'] ?? '',
      clientId: json['client_id'] ?? '',
      totalLoan: (json['total_loan'] as num).toDouble(),
      interest: (json['interest'] as num).toDouble(),
      paymentAmount: (json['payment_amount'] as num).toDouble(),
      status: json['status'] ?? 'pendiente',
      history: json['history'] ?? [],
      dueDate: json['due_date'], 
      interest10: json['interest10'],
      name: json['name']
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
      'interest10' : interest10,
      'name': name,
    };
  }
}

extension LoanModelCopy on LoanModel {
  LoanModel copyWith({
    String? id,
    String? clientId,
    double? totalLoan,
    double? interest,
    double? paymentAmount,
    String? status,
    List<dynamic>? history,
    String? dueDate, 
    bool? interest10,
    String? name,
  }) {
    return LoanModel(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      totalLoan: totalLoan ?? this.totalLoan,
      interest: interest ?? this.interest,
      paymentAmount: paymentAmount ?? this.paymentAmount,
      status: status ?? this.status,
      history: history ?? this.history,
      dueDate: dueDate ?? this.dueDate,
      interest10: interest10 ?? this.interest10,
      name: name ?? this.name,
    );
  }
}

