import 'package:flutter/material.dart';
import 'package:order_shots_mobile/models/user.dart';
import 'package:order_shots_mobile/screens/authenticate/authenticate.dart';
import 'package:order_shots_mobile/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // return either home or authenticate widget
    final user = Provider.of<UserNew?>(context);
    // ignore: avoid_print
    if (user == null) {
      return const Authenticate();
    } else {
      return Home();
    }
  }
}
