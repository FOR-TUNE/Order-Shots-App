import 'package:flutter/material.dart';
import 'package:order_shots_mobile/shared/constants.dart';
import 'package:order_shots_mobile/shared/loading.dart';

import '../../services/auth.dart';

class Register extends StatefulWidget {
  const Register({super.key, this.toggleView});

  final Function? toggleView;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  // textfield state
  String email = '';
  String password = '';
  String error = "";
  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.indigo[100],
            appBar: AppBar(
              backgroundColor: Colors.indigo[400],
              elevation: 0,
              title: const Text("Sign up to Order Shots"),
              actions: [
                TextButton.icon(
                    onPressed: () {
                      widget.toggleView!();
                    },
                    icon: const Icon(Icons.person),
                    label: const Text('Sign In'))
              ],
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (value) =>
                          value!.isEmpty ? "Enter an email" : null,
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      validator: (value) => value!.length < 6
                          ? "Enter password 6+ chars long"
                          : null,
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _auth
                                .registerWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error = 'Please supply valid email';
                                loading = false;
                              });
                            }
                          }
                        },
                        color: Colors.limeAccent[400],
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white),
                        )),
                    const SizedBox(height: 20),
                    Text(error,
                        style: const TextStyle(color: Colors.red, fontSize: 14))
                  ],
                ),
              ),
            ),
          );
  }
}
