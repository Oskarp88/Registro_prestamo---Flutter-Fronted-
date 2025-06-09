import 'package:get_storage/get_storage.dart'; 

class UtilLocalStorage {
  // Implementación de Singleton: garantiza que solo exista una instancia de esta clase
  static final UtilLocalStorage  _instance = UtilLocalStorage ._internal();

  // Constructor de fábrica que devuelve la misma instancia única
  factory UtilLocalStorage () {
    return _instance;
  }

  // Constructor privado que se usa solo dentro de la clase
  UtilLocalStorage ._internal();

  // Instancia de GetStorage para acceder al almacenamiento local
  final _storage = GetStorage();

  // Método para guardar datos en el almacenamiento local
  // Parámetros:
  // - key: la clave con la que se almacenarán los datos
  // - value: el valor que se desea almacenar
  Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key, value); // Escribe la clave y el valor en el almacenamiento
  }

  // Método para leer datos del almacenamiento local
  // Parámetro:
  // - key: la clave que se usa para recuperar los datos
  // Retorno:
  // - El valor almacenado, o `null` si no se encuentra la clave
  T? readData<T>(String key) {
    return _storage.read<T>(key); // Lee los datos asociados a la clave proporcionada
  }

  // Método para eliminar un dato específico del almacenamiento
  // Parámetro:
  // - key: la clave que se usa para identificar los datos que se quieren eliminar
  Future<void> removeData(String key) async {
    await _storage.remove(key); // Elimina el valor asociado a la clave proporcionada
  }

  // Método para borrar todos los datos del almacenamiento local
  Future<void> clearAll() async {
    await _storage.erase(); // Borra todo el almacenamiento local
  }
}
