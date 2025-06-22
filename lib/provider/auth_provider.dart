import 'package:flutter/foundation.dart';
import 'package:prestapp/data/repositories/user/user_repository.dart';
import 'package:prestapp/model/capital.dart';
import 'package:prestapp/model/user.dart';
import 'package:prestapp/provider/notification_provider.dart';
import 'package:prestapp/utils/constants/constants.dart';
import 'package:prestapp/utils/loaders/loaders.dart';
import 'package:prestapp/utils/local_storage/storage_utility.dart';

class AuthenticateProvider with ChangeNotifier { 
  
  static final AuthenticateProvider _instance = AuthenticateProvider._internal();
  factory AuthenticateProvider() => _instance;
  AuthenticateProvider._internal();

  static AuthenticateProvider get instance => _instance;

  final UserRepository userRepository = UserRepository();
  ProviderNotifications? notificationsProvider; // ✅ Campo nuevo


  UserModel? _user = UserModel.empty();
  bool _isProfileLoading = false;

  UserModel? get user => _user;
  bool get isProfileLoading => _isProfileLoading;

  CapitalModel? _capital = CapitalModel.empty();
  CapitalModel? get capital => _capital;

  void setIsProfileLoading(bool value){
    _isProfileLoading = value;
    notifyListeners();
  }

  void setUser(UserModel user){
    _user = user;
    notifyListeners();
  }

  void setCapital(CapitalModel capital){
    _capital = capital;
    notifyListeners();
  }

  Future<void> userRegister(Map<String, dynamic>? userData) async{
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
        await userRepository.userRegister(user);
      }
    } catch (e) {
      Loaders.errorSnackBar(
        title: 'Data not saved',
        message: 'Something went wrong while saving your instance information. You can re-save your data in your Profile. $e'
      );
    }
  }
   
  Future<void> fetchUserRecord(String? id)async{
    try {
      
      final userData = await userRepository.fetchUserDetails(id!);
      _user = userData;
      notifyListeners();
      
    } catch (e) {
      if (kDebugMode) {
        print( '$e');
      }
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
    notificationsProvider?.dispose();
    notifyListeners();
  }
}