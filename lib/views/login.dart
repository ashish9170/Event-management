// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:partypilot/auth.dart';
import 'package:partypilot/constants/colors.dart';
import 'package:partypilot/containers/custom_input_form.dart';
import 'package:partypilot/views/homepage.dart';
import 'package:partypilot/views/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
            ),
            Text(
              "Login",
              style: TextStyle(
                color: kLightGreen,
                fontSize: 32,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CustomInputForm(
              controller: emailController,
              icon: Icons.email_outlined,
              label: "Email",
              hint: "Enter your Email",
            ),
            SizedBox(
              height: 20,
            ),
            CustomInputForm(
              obscureText: true,
              controller: passwordController,
              icon: Icons.lock,
              label: "Password",
              hint: "Enter your Password",
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Forget Password",
                  style: TextStyle(
                    color: kLightGreen,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {loginUser(emailController.text, passwordController.text)
                      .then((value) {
                    if (value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Login Successful !!!")));

                      Future.delayed(
                          Duration(seconds: 2),
                          () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Homepage())));
                                   } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Login Failed Try Again.")));
                    }
                  });
                },
                child: Text("Login"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: kLightGreen, // text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            GestureDetector(
               onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignupPage())),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Create a new account ?",
                    style: TextStyle(
                      color: kLightGreen,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      color: kLightGreen,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
