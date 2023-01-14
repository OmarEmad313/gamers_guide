import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/my_button.dart';
import 'package:flutter_application_2/widgets/text_form_field.dart';
import 'package:go_router/go_router.dart';

import '../widgets/login_button.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future logIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background.jpeg'), fit: BoxFit.fill),
          ),
          child: ListView(children: [
            Column(
              children: [
                const SizedBox(height: 70),
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.asset(
                    'assets/logo.jpeg',
                    width: 164,
                    height: 234,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                const SizedBox(height: 40),
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      MyTextFormField(
                        text: 'Email',
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email';
                          }
                          return null;
                        },
                      ),
                      MyTextFormField(
                        text: 'Password',
                        controller: passwordController,
                        secure: true,
                        validator: (value) {
                          if (value == null || value.length <= 6) {
                            return 'Please enter min 6 digits';
                          }
                          return null;
                        },
                      ),
                      LoginButton(
                        text: 'Login',
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            logIn();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const Text(
                  'OR',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                LoginButton(
                    text: 'Register', onTap: () => context.go('/signup')),
                const Text(
                  'if you dant have one already',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ]),
          //--
        ),
      ),
    );
  }
}
