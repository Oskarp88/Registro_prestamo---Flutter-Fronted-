import 'package:flutter/material.dart';
import 'package:registro_prestamos/model/client.dart';

class ClientProvider with ChangeNotifier{
  static final ClientProvider _instance = ClientProvider._internal();
  factory ClientProvider() => _instance;
  ClientProvider._internal();
  static ClientProvider get istance => _instance;

  ClientModel _clientModel = ClientModel.empty();

  ClientModel? get clientModel => _clientModel;

  void setClient(ClientModel client){
    _clientModel = client;
    notifyListeners();
  }
}