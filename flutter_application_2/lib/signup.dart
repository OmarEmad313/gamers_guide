import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        'assets/logo.jpeg',
                        width: 165,
                        height: 233,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'Enter your name',
                            style: GoogleFonts.acme(
                              fontSize: 20,
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 30),
                              child: TextField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0XFFD3D3D3),
                                  labelText: 'Name',
                                  labelStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      borderSide: BorderSide.none),
                                ),
                              )),
                          Text(
                            'Enter your email',
                            style: GoogleFonts.acme(
                              fontSize: 20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 30),
                            child: TextField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0XFFD3D3D3),
                                labelText: 'Email',
                                labelStyle: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            'Enter your Password',
                            style: GoogleFonts.acme(
                              fontSize: 20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 30),
                            child: TextField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0XFFD3D3D3),
                                labelText: 'Password',
                                labelStyle: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(40, 10, 0, 0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    context.go('/home');
                                  },
                                  // ignore: sort_child_properties_last
                                  child: const Text('Sign up ',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic)),
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.all(10)),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ))),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(130, 10, 0, 0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    context.go('/');
                                  },
                                  // ignore: sort_child_properties_last
                                  child: const Text('Back ',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic)),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(Colors.red),
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10)),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ))),
                                ),
                              ),
                            ],
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
      ),
    );
  }
}
