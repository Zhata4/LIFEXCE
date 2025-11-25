import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uidisign05/core/colors.dart';
import 'package:uidisign05/core/space.dart';
import 'package:uidisign05/core/text_style.dart';
import 'package:uidisign05/page/home/home_page.dart';
import 'package:uidisign05/page/sign_up.dart';
import 'package:uidisign05/widget/main_button.dart';
import 'package:uidisign05/widget/text_fild.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userName = TextEditingController();
  TextEditingController userPass = TextEditingController();

  Future<void> login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUser = prefs.getString("name");
    String? savedPass = prefs.getString("password");

    if (userName.text == savedUser && userPass.text == savedPass) {
      await prefs.setBool("isLogin", true);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomePage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Wrong username or password")),
      );
    }
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
              const Text("Welcome Back!", style: headline1),
              const SpaceVH(height: 10.0),
              const Text("Please sign in to your account", style: headline3),
              const SpaceVH(height: 60.0),
              textFild(
                controller: userName,
                image: 'user.svg',
                hintTxt: 'Username',
              ),
              textFild(
                controller: userPass,
                image: 'hide.svg',
                isObs: true,
                hintTxt: 'Password',
              ),
              const SpaceVH(height: 10.0),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text("Forgot Password?", style: headline3),
                  ),
                ),
              ),
              const SpaceVH(height: 100.0),
              Mainbutton(
                onTap: login,
                text: 'Sign in',
                btnColor: blueButton,
              ),
              const SpaceVH(height: 20.0),
              Mainbutton(
                onTap: () {},
                text: 'Sign in with google',
                image: 'google.png',
                btnColor: white,
                txtColor: blackBG,
              ),
              const SpaceVH(height: 20.0),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => const SignUpPage()));
                },
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "Don’t have an account? ",
                      style: headline.copyWith(fontSize: 14.0),
                    ),
                    TextSpan(
                      text: " Sign Up",
                      style: headlineDot.copyWith(fontSize: 14.0),
                    ),
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
