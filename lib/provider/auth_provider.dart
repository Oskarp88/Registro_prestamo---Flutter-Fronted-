import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:registro_prestamos/data/repositories/user/user_repository.dart';
import 'package:registro_prestamos/model/user.dart';
import 'package:registro_prestamos/utils/constants/constants.dart';
import 'package:registro_prestamos/utils/loaders/loaders.dart';
import 'package:registro_prestamos/utils/local_storage/storage_utility.dart';

class AuthenticateProvider with ChangeNotifier { 
  
  static final AuthenticateProvider _instance = AuthenticateProvider._internal();
  factory AuthenticateProvider() => _instance;
  AuthenticateProvider._internal();

  static AuthenticateProvider get instance => _instance;

  final userRepository = Get.find<UserRepository>();

  UserModel? _user = UserModel.empty();
  bool _isProfileLoading = false;

  UserModel? get user => _user;
  bool get isProfileLoading => _isProfileLoading;

  void setIsProfileLoading(bool value){
    _isProfileLoading = value;
    notifyListeners();
  }

  void setUser(UserModel user){
    _user = user;
    notifyListeners();
  }

  Future<void> saveUserRecord(Map<String, dynamic>? userData) async{
    try {
      if(userData != null){
        final user = {     
          Constants.name: userData[Constants.name] ?? '',
          Constants.email: userData[Constants.email] ?? '',
          Constants.lastname: userData[Constants.lastname] ?? '',
          Constants.username: userData[Constants.username] ?? '',
          Constants.password: userData[Constants.password] ?? '',
          Constants.isAdmin: false,
          Constants.isActive: false,
        };
        await userRepository.saveUserRecord(user);
      }
    } catch (e) {
      Loaders.errorSnackBar(
        title: 'Data not saved',
        message: 'Something went wrong while saving your instance information. You can re-save your data in your Profile.'
      );
    }
  }
  
  Future<void> fetchUserRecord(String? id)async{
    print('llegue a fetchUserRecord ');
    try {
      
      final userData = await userRepository.fetchUserDetails(id!);
      print('<<<<<<<<<<<<<<<<<<<<<<<<<<<usermodel $userData');
      _user = userData;
      notifyListeners();
      
    } catch (e) {
      print( 'FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF$e');
    }  
  }


  // void loadUserFromStorage(Map<String, dynamic>? userData){
  //   if(userData != null){
  //     _user = User.fromSnapshot(userData);
  //     notifyListeners();
  //   }
  // }

  void clearUser(){
    UtilLocalStorage().removeData('User');
    _user = null;
    notifyListeners();
  }
}