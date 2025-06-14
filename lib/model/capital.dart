import 'package:registro_prestamos/utils/constants/constants.dart';

class CapitalModel {
  final double capital;
  final String admin;
  final double totalInterest;
  final double totalLoan;
  CapitalModel({
    required this.capital,
    required this.admin,
    required this.totalInterest,
    required this.totalLoan
  });

  static CapitalModel empty () => CapitalModel(
    capital: 0.0,
    totalInterest: 0.0,
    totalLoan: 0.0,
    admin: '',
  );
  
    bool isEmpty() {
    return admin.isEmpty;
  }

  bool isNotEmpty() {
    return !isEmpty();
  }

  factory CapitalModel.fromJson(Map<String, dynamic> json) {
    return CapitalModel(
      capital: json['capital'] ?? 0.0,
      admin: json['admin'] ?? '',
      totalInterest: json['total_interest'] ?? 0.0,
      totalLoan: json[Constants.totalLoan] ?? 0.0
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'capital': capital,
      'admin': admin,
      'total_interest': totalInterest,
      Constants.totalLoan : totalLoan
    };
  }
}

extension CopitalModelCopy on CapitalModel {
  CapitalModel copyWith({
    double? capital,
    String? admin,
    double? totalInterest,
    double? totalLoan
  }) {
    return CapitalModel(
      capital: capital ?? this.capital,
      admin: admin ?? this.admin,
      totalInterest: totalInterest ?? this.totalInterest,
      totalLoan: totalLoan ?? this.totalLoan
    );
  }
}

