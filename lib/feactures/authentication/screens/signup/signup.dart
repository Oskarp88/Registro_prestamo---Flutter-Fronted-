import 'package:flutter/material.dart';
import 'package:registro_prestamos/feactures/authentication/screens/signup/widgets/signup_form.dart';
import 'package:registro_prestamos/utils/constants/dimensions.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //title
              Text('Let´s create your account', style: Theme.of(context).textTheme.headlineMedium,),
              const SizedBox(height: Dimensions.spaceBtwSections,),
              //form
              const SignUpForm(),
            ],
          ),
        ),
      ),
    );
  }
}

