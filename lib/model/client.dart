import 'package:prestapp/utils/constants/constants.dart';

class ClientModel {
  String id; // Campo nuevo para MongoDB ID
  String name;
  String lastname;
  int cedula;
  String phoneNumber;

  ClientModel({
    required this.id, // Campo requerido
    required this.name, 
    required this.lastname, 
    required this.cedula, 
    required this.phoneNumber, 
  });

  static ClientModel empty () => ClientModel(
    id: '',
    name: '',
    lastname: '',
    cedula: 0,
    phoneNumber: '',
  );
  
  Map<String, dynamic> toJson() {
    return {
      'id': id, // Asegúrate de incluir el campo id
      Constants.name: name,
      Constants.lastname: lastname,
      Constants.cedula: cedula,
      Constants.phoneNumber: phoneNumber,
    };
  }

 factory ClientModel.fromJson(Map<String, dynamic> json) {
  return ClientModel(
    id: json['id'] ?? '',
    name: json[Constants.name] ?? '',
    lastname: json[Constants.lastname] ?? '',
    cedula: json[Constants.cedula] ?? 0,
    phoneNumber: json[Constants.phoneNumber] ?? '',
  );
}

}

extension UserClientCopy on ClientModel {
  ClientModel copyWith({
    String? id,
    String? name,
    String? lastname,
    int? cedula,
    String? phoneNumber,
  }) {
    return ClientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      lastname: lastname ?? this.lastname,
      cedula: cedula ?? this.cedula,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
