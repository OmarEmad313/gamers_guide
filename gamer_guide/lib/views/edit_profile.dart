import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

class EditProfile extends StatefulWidget {
  final String userName;
  final String userId;
  const EditProfile({super.key, required this.userName, required this.userId});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  PlatformFile? pickedImage;

  final formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  Future pickImage() async {
    print('in here');
    final image = await FilePicker.platform.pickFiles();
    if (image == null) return;
    setState(() {
      pickedImage = image.files.first;
    });
  }

  Future uploadImage() async {
    final path = 'files/${pickedImage!.name}';
    final file = File(pickedImage!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);
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
              context.go('/home/3');
            },
            noBack: false,
          ),
        ],
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              pickedImage != null
                  ? InkWell(
                      onTap: () {
                        pickImage();
                      },
                      child: ClipOval(
                        child: Image.file(
                          File(pickedImage!.path!),
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.15,
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: pickImage,
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
                        uploadImage();
                        if (formKey.currentState!.validate()) {
                          update(
                              newName: nameController.text.trim(),
                              newEmail: emailController.text.trim(),
                              newPass: passwordController.text.trim());
                          context.go('/home/3');
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
