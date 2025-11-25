import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uidisign05/core/colors.dart';
import 'package:uidisign05/core/space.dart';
import 'package:uidisign05/core/text_style.dart';
import 'package:uidisign05/widget/main_button.dart';
import 'package:uidisign05/widget/text_fild.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController userName = TextEditingController();
  TextEditingController userPass = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPh = TextEditingController();

  Future<void> register() async {
    if (userName.text.isEmpty ||
        userEmail.text.isEmpty ||
        userPh.text.isEmpty ||
        userPass.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Fill all fields")));
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("name", userName.text);
    await prefs.setString("email", userEmail.text);
    await prefs.setString("phone", userPh.text);
    await prefs.setString("password", userPass.text);
    await prefs.setBool("isLogin", false);

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Account created!")));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackBG,
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SpaceVH(height: 50.0),
              const Text("Create new account", style: headline1),
              const SpaceVH(height: 10.0),
              const Text("Please fill in the form to continue", style: headline3),
              const SpaceVH(height: 60.0),
              textFild(controller: userName, image: 'user.svg', hintTxt: 'Full Name'),
              textFild(controller: userEmail, image: 'user.svg', hintTxt: 'Email Address'),
              textFild(controller: userPh, image: 'user.svg', hintTxt: 'Phone Number'),
              textFild(controller: userPass, image: 'hide.svg', isObs: true, hintTxt: 'Password'),
              const SpaceVH(height: 80.0),
              Mainbutton(onTap: register, text: 'Sign Up', btnColor: blueButton),
              const SpaceVH(height: 20.0),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(text: 'Have an account? ', style: headline.copyWith(fontSize: 14.0)),
                    TextSpan(text: ' Sign In', style: headlineDot.copyWith(fontSize: 14.0)),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
