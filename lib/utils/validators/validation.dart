class Validator {
  static String? validateEmail(String? value){
    if(value == null || value.isEmpty){
      return 'Email is required.';
    }

    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if(!emailRegExp.hasMatch(value)){
      return 'Invalid email address';
    }

    return null;
  }

  static String? validatePassword(String? value){
    if(value == null || value.isEmpty){
      return 'Password is required';
    }

    if(value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }

    if(!value.contains(RegExp(r'[A-Z]'))){
      return 'Password must contain at least one appercase letter.';
    }
   
    if(!value.contains(RegExp(r'[0-9]'))){
      return 'Password must contain at least one number.';
    }

    if(!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))){
      return 'Password must contain at least one special character.';
    }

    return null;
  }

  static String? validateOnlyNumbers(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es obligatorio';
    }

    final numberRegExp = RegExp(r'^\d+$'); // solo números

    if (!numberRegExp.hasMatch(value)) {
      return 'Solo se permiten números';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'El número de teléfono es obligatorio';
    }

    final phoneRegExp = RegExp(r'^\d{10}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Formato inválido (se requieren 10 dígitos)';
    }

    return null; 
  }


  static String? validateText(String value, String label) {
    if (value.trim().isEmpty) return '$label es obligatorio';
    return null;
  }

    static String? validateCedula(String value) {
    if (value.trim().isEmpty) return 'La cédula es obligatoria';
    if (!RegExp(r'^\d+$').hasMatch(value.trim())) return 'Solo se permiten números';
    if (value.trim().length < 6 || value.trim().length > 11) {
      return 'La cédula debe tener entre 6 y 11 dígitos';
    }
    return null;
  }
}