import 'package:flutter/material.dart';
import 'package:registro_prestamos/model/client.dart';
import 'package:registro_prestamos/model/loan.dart';

class ClientProvider with ChangeNotifier{
  static final ClientProvider _instance = ClientProvider._internal();
  factory ClientProvider() => _instance;
  ClientProvider._internal();
  static ClientProvider get instance => _instance;

  ClientModel _clientModel = ClientModel.empty();
  ClientModel? get clientModel => _clientModel;

  LoanModel _loanModel = LoanModel.empty();
  LoanModel? get loanModel => _loanModel;

  void setClient(ClientModel client){
    _clientModel = client;
    notifyListeners();
  }

  void setLoan(LoanModel loan){
    _loanModel = loan;
    notifyListeners();
  }
}