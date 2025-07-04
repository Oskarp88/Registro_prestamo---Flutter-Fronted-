import 'package:flutter/material.dart';
import 'package:prestapp/common/styles/spacing_styles.dart';
import 'package:prestapp/feactures/authentication/screens/login/widgets/login_form.dart';
import 'package:prestapp/feactures/authentication/screens/login/widgets/login_header.dart';
import 'package:prestapp/utils/helpers/helper_funtions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: THelperFuntions.screenWidth() > 550 ? 550 : double.infinity,
            child: Padding(
              padding: TSpacingStyle.paddingWithAppBarHeight,
              child:  Column(
                children: [
                  ///logo, title $ Sub-title
                   LoginHaeder(),
                  ///form
                   LoginForm()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



