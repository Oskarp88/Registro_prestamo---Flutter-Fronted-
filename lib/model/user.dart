import 'package:prestapp/utils/constants/constants.dart';

class UserModel {
  String id; // Campo nuevo para MongoDB ID
  String name;
  String lastname;
  String username;
  String email;
  String password;
  bool isAdmin;
  bool isActive;

  UserModel({
    required this.id, // Campo requerido
    required this.name, 
    required this.lastname, 
    required this.username, 
    required this.email, 
    required this.password,
    required this.isAdmin,
    required this.isActive 
  });

  static UserModel empty () => UserModel(
    id: '',
    name: '',
    lastname: '',
    username: '',
    email: '',
    password: '',
    isAdmin: false,
    isActive: false,
  );
  
  Map<String, dynamic> toJson() {
    return {
      'id': id, // Asegúrate de incluir el campo id
      'name': name,
      'lastname': lastname,
      'username': username,
      'email': email,
      'isAdmin': isAdmin,
      'isActive': isActive
    };
  }

 factory UserModel.fromJson(Map<String, dynamic> json) {
  return UserModel(
    id: json['id'] ?? '',
    name: json[Constants.name] ?? '',
    lastname: json[Constants.lastname] ?? '',
    username: json[Constants.username] ?? '',
    email: json[Constants.email] ?? '',
    password: json[Constants.password] ?? '',
    isAdmin: json[Constants.isAdmin] ?? false,
    isActive: json[Constants.isActive] ?? false,
  );
}

}

extension UserModelCopy on UserModel {
  UserModel copyWith({
    String? id,
    String? name,
    String? lastname,
    String? username,
    String? email,
    String? password,
    bool? isAdmin,
    bool? isActive
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      lastname: lastname ?? this.lastname,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      isAdmin: isAdmin ?? this.isAdmin,
      isActive: isActive ?? this.isActive
    );
  }
}
