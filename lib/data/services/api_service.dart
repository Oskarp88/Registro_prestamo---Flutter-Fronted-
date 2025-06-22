import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:prestapp/model/capital.dart';
import 'package:prestapp/model/client.dart';
import 'package:prestapp/model/history_capital.dart';
import 'package:prestapp/model/loan.dart';
import 'package:prestapp/provider/auth_provider.dart';
import 'package:prestapp/utils/classes/search_result.dart';
import 'package:prestapp/utils/constants/constants.dart';

class ApiService {

  Future<List<ClientModel>> fetchClient() async {
    try {
      final Uri url = Uri.parse('${dotenv.env['BASE_URL']}/user/client/all');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
      
        List<ClientModel> clients = jsonList.map((json) => ClientModel.fromJson(json)).toList();

        return clients;
      } else {
        return []; 
      }
    } catch (e) {
      throw 'Something went wrong while fetching and sorting users. Please try again. Error: $e';
    }
  }
   
  Future<ClientModel> fetchClientById(String clientId) async {
    try {
      final Uri url = Uri.parse('${dotenv.env['BASE_URL']}/user/client?client_id=$clientId');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
      
        ClientModel client =  ClientModel.fromJson(json);

        return client;
      } else {
        return ClientModel.empty(); 
      }
    } catch (e) {
      throw 'Something went wrong while fetching and sorting users. Please try again. Error: $e';
    }
  }

  Future<SearchResult<List<ClientModel>>> searchClients(String query) async {
  try {
    final Uri url = Uri.parse('${dotenv.env['BASE_URL']}/user/clients/search?query=$query');

    final response = await http.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      final clients = jsonList.map((json) => ClientModel.fromJson(json)).toList();
      return SearchResult(data: clients);
    } else {
      final Map<String, dynamic> errorJson = jsonDecode(response.body);
      return SearchResult(error: errorJson['detail'] ?? 'Error desconocido.');
    }

  } catch (e) {
    return SearchResult(error: 'Error buscando clientes: $e');
  }
}


  Future<LoanModel?> getLoanByClientId(String clientId) async {
    try {
      final Uri url = Uri.parse('${dotenv.env['BASE_URL']}/loan/get-by-client/$clientId');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return LoanModel.fromJson(data);
      } else if (response.statusCode == 404) {
        // No se encontró préstamo para ese cliente
        return null;
      } else {
        throw 'Error del servidor: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Error al obtener el préstamo del cliente: $e';
    }
  }

  Future<CapitalModel> fetchCapital() async {
    try {
      final Uri url = Uri.parse('${dotenv.env['BASE_URL']}/user/capital');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final authProvider = AuthenticateProvider.instance;
        final jsonList = jsonDecode(response.body);
      
        CapitalModel capital = CapitalModel.fromJson(jsonList);
        authProvider.setCapital(capital);
        return capital;
      } else {
        return CapitalModel.empty(); 
      }
    } catch (e) {
      throw 'Something went wrong while fetching and sorting users. Please try again. Error: $e';
    }
  }
  
  Future <List<LoanModel>> fetchInterest() async {
    try {
      final Uri url = Uri.parse('${dotenv.env['BASE_URL']}/loan/get/pending');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final authProvider = AuthenticateProvider.instance;
        final responseInterest = jsonDecode(response.body);
        final List<dynamic> jsonList = responseInterest['pending_loans'];
        final capitalModel = authProvider.capital!.copyWith(
          totalInterest: responseInterest[Constants.totalInterest],
          totalLoan: responseInterest[Constants.totalLoan]
        );
        List<LoanModel> loans = jsonList.map((json) => LoanModel.fromJson(json)).toList();       
        authProvider.setCapital(capitalModel);
        return loans;
      } else {
        return []; 
      }
    } catch (e) {
      throw 'Something went wrong while fetching and sorting users. Please try again. Error: $e';
    }
  }
  
   Future<List<CapitalHistoryModel>> fetchCapitalHistory({String value = 'history-capital'}) async {
    try {
      final Uri url = Uri.parse('${dotenv.env['BASE_URL']}/user/$value');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final history = jsonDecode(response.body);
        List<dynamic> jsonList = history["historial"];
      
        List<CapitalHistoryModel> clients = jsonList.map((json) => CapitalHistoryModel.fromJson(json)).toList();

        return clients;
      } else {
        return []; // Retorna una lista vacía si la respuesta no es exitosa
      }
    } catch (e) {
      throw 'Something went wrong while fetching and sorting users. Please try again. Error: $e';
    }
  }

    Future <List<LoanModel>> fetchLoans() async {
    try {
      final Uri url = Uri.parse('${dotenv.env['BASE_URL']}/loan/get-all-loans');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);    
        List<LoanModel> loans = jsonList.map((json) => LoanModel.fromJson(json)).toList();       
        return loans;
      } else {
        return []; 
      }
    } catch (e) {
      throw 'Something went wrong while fetching and sorting users. Please try again. Error: $e';
    }
  }
   
   
}

