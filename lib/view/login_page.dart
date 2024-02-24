import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/constants/constants.dart';
import 'package:first_project/controllers/authentication_controller.dart';
import 'package:first_project/utils/formHelper.dart';
import 'package:first_project/view/signup_page.dart';
import 'package:first_project/utils/uiHelper.dart';
import 'package:flutter/material.dart';
import 'package:first_project/view/library_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Function to handle login with email and password
  void _handleLogin() async {
    String email = emailController.text;
    String password = passwordController.text;
    if (email == "" && password == "") {
      UiHelper.CustomAlertBox(context, "Enter the required fields");
    } else {
      try {
        UserCredential? user =
            await Authentication().loginWithEmailAndPassword(email: email, password: password);
        if (user != null) {
          print('Login success');
          Navigator.push(context, MaterialPageRoute(builder: (context) => const Library()));
        }
      } catch (e) {
        return UiHelper.CustomAlertBox(context, "Error occurred while login");
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
      appBar: AppBar(
        title: const Text('Login', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset(
              'assets/images/img.png',
              height: 100,
            ),
            _loginFormWidget(),
            const SizedBox(height: 20),
            _navigateToSignUpWidget(),
            const SizedBox(height: 20),
            _orOptionsWidget(),
          ],
        ),
      ),
    );
  }

  Widget _loginFormWidget() {
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
                controller: emailController,
                decoration: customDecoration.customInputDecoration("Email", Icons.email)),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
                obscureText: true,
                controller: passwordController,
                decoration: customDecoration.customInputDecoration("Password", Icons.password)),
            const SizedBox(
              height: 20,
            ),
            UiHelper.CustomButton(_handleLogin, "Submit"),
          ],
        ),
      ),
    );
  }

  Widget _navigateToSignUpWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Do not have an Account?",
          style: TextStyle(fontSize: 16),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }

  Widget _orOptionsWidget() {
    return Column(
      children: [
        const Text(
          "Or Sign In With",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        IconButton(
          onPressed: _handleGoogleSignIn,
          iconSize: 30,
          icon: Image.network(
            AppConstants.GOOGLE_IMAGE_URL,
            height: 30, // Adjust height as needed
          ),
        ),
      ],
    );
  }
}
