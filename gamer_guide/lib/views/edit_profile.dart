import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/my_button.dart';
import 'package:flutter_application_2/widgets/my_text.dart';
import 'package:flutter_application_2/widgets/text_form_field.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../services/date_functions.dart';
import '../services/user_services.dart';
import '../widgets/sliver_app_bar.dart';
import '../widgets/theme_switch.dart';
import 'package:path/path.dart';

class EditProfile extends StatefulWidget {
  final String userName;
  final String userId;
  const EditProfile({super.key, required this.userName, required this.userId});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? image;

  final formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageperm = await saveImagePermanantly(image.path);
    setState(() {
      this.image = imageperm;
    });
  }

  Future<File> saveImagePermanantly(String path) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(path);
    final image = File('${directory.path}/$name');
    return File(path).copy(image.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          MySliverAppbar(
            text: 'Edit Profile',
            ontap: () {
              context.go('/home/2');
            },
            noBack: false,
          ),
        ],
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              /* Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20)),
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
                ), */
              image != null
                  ? InkWell(
                      onTap: () {
                        pickImage();
                      },
                      child: ClipOval(
                        child: Image.file(
                          image!,
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.15,
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        pickImage();
                      },
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.25,
                        backgroundImage: const AssetImage('assets/logo.jpeg'),
                      ),
                    ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
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
                      controller: nameController,
                      text: widget.userName,
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
                      controller: emailController,
                      text: FirebaseAuth.instance.currentUser!.email!,
                      validator: (value) =>
                          value != null && !EmailValidator.validate(value)
                              ? 'Please enter a valid email'
                              : null,
                    ),
                    Text(
                      'Edit your Password',
                      style: GoogleFonts.acme(
                        fontSize: 20,
                      ),
                    ),
                    MyTextFormField(
                      controller: passwordController,
                      text: 'Password',
                      secure: true,
                      validator: (value) {
                        if (value == null || value.length <= 6) {
                          return 'Please enter min 6 digits';
                        }
                        return null;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const MyText(
                            text: 'Date of birth ',
                            size: 20,
                            weight: FontWeight.bold),
                        GetUsersDOB(userId: widget.userId),
                        IconButton(
                          onPressed: () {
                            datePicker(context: context);
                          },
                          icon: const Icon(
                            Icons.calendar_month,
                            color: Colors.deepPurple,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                    MyButton(
                      text: 'Save',
                      verticalPadding: 10,
                      horizontalPadding: 30,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          update(
                              newName: nameController.text.trim(),
                              newEmail: emailController.text.trim(),
                              newPass: passwordController.text.trim());
                          context.go('/home/2');
                        }
                      },
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
