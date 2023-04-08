import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/my_button.dart';
import 'package:flutter_application_2/widgets/text_form_field.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future createUser({
    required String name,
    required String email,
  }) async {
    final userInsatnce = FirebaseFirestore.instance.collection('users').doc();

    final userData = {
      'name': name,
      'email': email,
      'DOB': '',
      'favGames': [],
      'wishlist': [],
    };

    await userInsatnce.set(userData);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background.jpeg'), fit: BoxFit.fill),
          ),
          child: Column(
            children: [
              const SizedBox(height: 40),
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  'assets/logo.jpeg',
                  width: 165,
                  height: 233,
                  fit: BoxFit.fitHeight,
                ),
              ),
              const SizedBox(height: 40),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Text(
                              'Enter your name',
                              style: GoogleFonts.acme(
                                fontSize: 20,
                              ),
                            ),
                            MyTextFormField(
                              text: 'Name',
                              controller: nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an Name';
                                }
                              },
                            ),
                            Text(
                              'Enter your email',
                              style: GoogleFonts.acme(
                                fontSize: 20,
                              ),
                            ),
                            MyTextFormField(
                              text: 'Email',
                              controller: emailController,
                              validator: (value) => value != null &&
                                      !EmailValidator.validate(value)
                                  ? 'Please enter a valid email'
                                  : null,
                            ),
                            Text(
                              'Enter your Password',
                              style: GoogleFonts.acme(
                                fontSize: 20,
                              ),
                            ),
                            MyTextFormField(
                              secure: true,
                              text: 'Password',
                              controller: passwordController,
                              validator: (value) =>
                                  value != null && value.length <= 6
                                      ? 'Enter min 6 characters'
                                      : null,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                MyButton(
                                    text: 'Back',
                                    color: Colors.red,
                                    onPressed: () => context.go('/')),
                                MyButton(
                                  text: 'Sign up',
                                  onPressed: () {
                                    final isValid =
                                        formKey.currentState!.validate();
                                    if (!isValid) return;
                                    FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: emailController.text,
                                            password: passwordController.text)
                                        .then((value) {
                                      createUser(
                                        name: nameController.text,
                                        email: emailController.text,
                                      );
                                      context.go('/userPreference');
                                    }).onError((error, stackTrace) {
                                      print("Error ${error.toString()}");
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
