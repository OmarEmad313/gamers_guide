import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/my_text.dart';

class LoginButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const LoginButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.075,
        child: ElevatedButton(
            onPressed: onTap,
            child: MyText(
              text: text,
              weight: FontWeight.bold,
              size: 20,
            )),
      ),
    );
  }
}
