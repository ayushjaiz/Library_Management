import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/constants/constants.dart';
import 'package:first_project/utils/formHelper.dart';
import 'package:first_project/view/library_page.dart';
import 'package:first_project/view/login_page.dart';
import 'package:first_project/controllers/authentication_controller.dart';
import 'package:first_project/utils/uiHelper.dart';
import 'package:first_project/utils/validators.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Function to handle email and password sign up
  void _handleEmailAndPasswordSignUp() async {
    String email = emailController.text;
    String password = passwordController.text;

    if (formKey.currentState!.validate()) {
      try {
        UserCredential? user =
            await Authentication().signUpWithEmailAndPassword(email: email, password: password);
        if (user != null) {
          print('Signup success');
          Navigator.push(context, MaterialPageRoute(builder: (context) => const Library()));
        }
      } catch (e) {
        return UiHelper.CustomAlertBox(context, "Error occurred while signup");
      }
    }
  }

  // Function to handle Google sign in
  void _handleGoogleSignIn() async {
    try {
      UserCredential? user = await Authentication().signInWithGoogle();
      if (user != null) {
        print("Google SignIn success");
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Library()));
      }
    } catch (e) {
      UiHelper.CustomAlertBox(context, "Google SignIn Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Sign Up', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset(
              AppConstants.FLUTTER_IMAGE_URL,
              height: 100,
            ),
            _signUpFormWidget(),
            const SizedBox(height: 20),
            _navigateToLoginWidget(),
            const SizedBox(height: 20),
            _orOptionWidget(),
          ],
        ),
      ),
    );
  }

  Widget _signUpFormWidget() {
    return Container(
      width: 300,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            TextFormField(
                validator: Validators.emailValidator,
                controller: emailController,
                decoration: customDecoration.customInputDecoration("Email", Icons.email)),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
                validator: Validators.passwordValidator,
                obscureText: true,
                controller: passwordController,
                decoration: customDecoration.customInputDecoration("Password", Icons.password)),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
                validator: Validators.phoneNumberValidator,
                keyboardType: TextInputType.phone,
                controller: phoneController,
                decoration: customDecoration.customInputDecoration("Phone Number", Icons.phone)),
            const SizedBox(
              height: 20,
            ),
            UiHelper.CustomButton(_handleEmailAndPasswordSignUp, "Submit"),
          ],
        ),
      ),
    );
  }

  Widget _navigateToLoginWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an Account?",
          style: TextStyle(fontSize: 16),
        ),
        TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
            },
            child: const Text(
              "Login",
              style: TextStyle(fontSize: 20),
            ))
      ],
    );
  }

  Widget _orOptionWidget() {
    return Column(
      children: [
        const Text(
          "Or Sign In With",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: _handleGoogleSignIn,
              iconSize: 30,
              icon: Image.network(
                AppConstants.GOOGLE_IMAGE_URL,
                height: 30, // Adjust height as needed
              ),
            ),
          ],
        ),
      ],
    );
  }
}
