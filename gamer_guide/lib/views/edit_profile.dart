import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/my_button.dart';
import 'package:flutter_application_2/widgets/my_text.dart';
import 'package:flutter_application_2/widgets/text_form_field.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';

import '../widgets/sliver_app_bar.dart';
import '../widgets/theme_switch.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          MySliverAppbar(
            text: 'Edit Profile',
            ontap: () {
              context.go('/home/2');
            },
            noBack: false,
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Colors.grey.withOpacity(0.4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        MyText(
                          text: 'Dark Theme',
                          paddingSize: 0,
                          size: 30,
                          weight: FontWeight.bold,
                        ),
                        ThemeSwitch(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Text(
                        'Edit your Name',
                        style: GoogleFonts.acme(
                          fontSize: 20,
                        ),
                      ),
                      MyTextFormField(
                        text: 'name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an Name';
                          }
                          return null;
                        },
                      ),
                      Text(
                        'Edit your email',
                        style: GoogleFonts.acme(
                          fontSize: 20,
                        ),
                      ),
                      MyTextFormField(
                        text: 'Email',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email';
                          }
                          return null;
                        },
                      ),
                      Text(
                        'Edit your Password',
                        style: GoogleFonts.acme(
                          fontSize: 20,
                        ),
                      ),
                      MyTextFormField(
                        text: 'Password',
                        secure: true,
                        validator: (value) {
                          if (value == null || value.length <= 6) {
                            return 'Please enter min 6 digits';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyButton(
                              text: 'Save',
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  context.go('/home');
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
