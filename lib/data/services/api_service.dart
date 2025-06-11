import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:registro_prestamos/model/client.dart';
import 'package:registro_prestamos/model/loan.dart';
 

class ApiService {

  Future<List<ClientModel>> fetchClassicalRatings() async {
    try {
      final Uri url = Uri.parse('${dotenv.env['BASE_URL']}/user/client/all');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print('response.statusCode ${response.statusCode} ${jsonDecode(response.body)}');
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
      
        List<ClientModel> clients = jsonList.map((json) => ClientModel.fromJson(json)).toList();

        return clients;
      } else {
        print('lista vacia');
        return []; // Retorna una lista vacía si la respuesta no es exitosa
      }
    } catch (e) {
      throw 'Something went wrong while fetching and sorting users. Please try again. Error: $e';
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
  
}

