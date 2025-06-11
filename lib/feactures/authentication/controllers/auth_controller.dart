import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:registro_prestamos/common/screen/full_screen_loader.dart';
import 'package:registro_prestamos/data/repositories/authentication/authentication_repository.dart';
import 'package:registro_prestamos/model/user.dart';
import 'package:registro_prestamos/provider/auth_provider.dart';
import 'package:registro_prestamos/utils/connects/network_manager.dart';
import 'package:registro_prestamos/utils/constants/constants.dart';
import 'package:registro_prestamos/utils/loaders/loaders.dart';
import 'package:registro_prestamos/utils/local_storage/storage_utility.dart';
import 'package:registro_prestamos/utils/manager/assets_manager.dart';

class AuthControllers {
  
  Future<void> singIn(String usernameOrEmail, String password) async{
    OFullScreenLoader.openLoadingDialog('Loggin you in...', AssetsManager.clashcycle);
    final isConnected = await NetworkManager.instance.isConnected();

    if(!isConnected){
      OFullScreenLoader.stopLoading();
      return;
    }
    // final userCredentials = UtilLocalStorage().readData(Constants.userCredentials);

      final Uri url = Uri.parse('${dotenv.env[Constants.baseUrl]}/auth/login');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body:  jsonEncode({ 
          Constants.usernameOrEmail: usernameOrEmail, 
          Constants.password: password 
        })
      );
      // print('response login ***************: ${response.statusCode}');
      // print('************************************************************');
      if (response.statusCode == 200) {
        final setAuth = AuthenticateProvider.instance;
        final Map<String, dynamic> userData = jsonDecode(response.body);
      //   print('response login ***************: $userData');
      // print('************************************************************');
        UserModel userModel = UserModel.fromJson(userData['user']);
        setAuth.setUser(userModel);
        await UtilLocalStorage().saveData(Constants.userCredentials, userData);
        await UtilLocalStorage().saveData(Constants.isLogin, true);
        AuthenticationRepository.instance.screenRedirect();    
        return;
      } else {
        final Map<String, dynamic> errorResponse = jsonDecode(response.body);
        final String errorMessage = errorResponse['detail'] ?? 'Error desconocido';

        if (response.statusCode == 401) {
          Loaders.errorSnackBar(title: errorMessage);
          OFullScreenLoader.stopLoading();
          return;
        } else {
          OFullScreenLoader.stopLoading();
          throw 'Server error: ${response.statusCode} - $errorMessage';
        }
      } 
  }
  
//    void deleteAccountWarningPopup(){
//     Get.defaultDialog(
//       titleStyle: GoogleFonts.aDLaMDisplay(
//         color: MyColors.blueDark8
//       ),
//       middleTextStyle:  GoogleFonts.aDLaMDisplay(
//         color: MyColors.blueDark8
//       ),
//       backgroundColor: MyColors.blue1,
//       contentPadding:  const EdgeInsets.all(10),
//       title: 'Delete Account',
//       middleText: 'Are you sure want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.',
//       confirm: ElevatedButton(
//         onPressed: () async => deleteUserAccount(),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.red, side: const BorderSide(color: Colors.red),
//         ), 
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 30),
//           child: Text(
//             'Delete', 
//             style: GoogleFonts.aDLaMDisplay(
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//               color: MyColors.wesAsphalt0,
//             )
//          ,),
//         ),
//         ),
//       cancel: OutlinedButton(
//         style: OutlinedButton.styleFrom(side: const BorderSide(color: MyColors.blueDark8, width: 2)),
//         onPressed: () => Navigator.of(Get.overlayContext!).pop(), 
//         child: Text(
//           'Cancel', 
//           style: GoogleFonts.aDLaMDisplay(
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//             color:  MyColors.blueDark8,
//           )
//         )
//       )
//     );
//   }

//   void deleteUserAccount() async {
//     try {
//       OFullScreenLoader.openLoadingDialog('Processing', ImageUrlConstants.logoScreenfull);

//       final auth = AuthenticationRepository.instance;
//       final provider = auth.authUser!.providerData.map((e) => e.providerId).first;
//       if(provider.isNotEmpty){
//         if(provider == 'google.com'){
//           await auth.signInWithGoogle();
//           await auth.deleteAccount();
//           OFullScreenLoader.stopLoading();
//           Get.offAll(() => const LoginScreen());
//         }
//       }
//     } catch (e) {
//       OFullScreenLoader.stopLoading();
//       Loaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
//     }
//   }

}