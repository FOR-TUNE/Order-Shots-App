import 'package:flutter/material.dart';
import 'package:order_shots_mobile/screens/authenticate/register.dart';
import 'package:order_shots_mobile/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  toggleview() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn == true) {
      return SignIn(toggleView: toggleview);
    } else {
      return Register(toggleView: toggleview);
    }
  }
}
