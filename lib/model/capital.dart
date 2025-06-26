import 'package:prestapp/utils/constants/constants.dart';

class CapitalModel {
  final double capital;
  final String admin;
  final double totalInterest;
  final double totalLoan;
  final double ganancias;
  final double historyCapital;

  CapitalModel( {
    required this.capital,
    required this.admin,
    required this.totalInterest,
    required this.totalLoan,
    required this.ganancias,
    required this.historyCapital,
  });

  static CapitalModel empty () => CapitalModel(
    capital: 0.0,
    totalInterest: 0.0,
    totalLoan: 0.0,
    ganancias: 0.0,
    historyCapital: 0.0,
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
      totalLoan: json[Constants.totalLoan] ?? 0.0,
      historyCapital: json[Constants.capitalHistory] ?? 0.0,
      ganancias: json[Constants.ganancias] ?? 0.0
    );
  }

  Map<String, dynamic> toJson() {
    return {
      Constants.capital: capital,
      Constants.admin: admin,
      Constants.totalInterest: totalInterest,
      Constants.totalLoan : totalLoan,
      Constants.ganancias: ganancias,
      Constants.capitalHistory: historyCapital
    };
  }
}

extension CapitalModelCopy on CapitalModel {
  CapitalModel copyWith({
    double? capital,
    String? admin,
    double? totalInterest,
    double? totalLoan,
    double? ganancias,
    double? historyCapital
  }) {
    return CapitalModel(
      capital: capital ?? this.capital,
      admin: admin ?? this.admin,
      totalInterest: totalInterest ?? this.totalInterest,
      totalLoan: totalLoan ?? this.totalLoan,
      ganancias: ganancias ?? this.ganancias,
      historyCapital: historyCapital ?? this.historyCapital
    );
  }
}

