// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:order_shots_mobile/services/auth.dart';
import 'package:order_shots_mobile/shared/constants.dart';
import 'package:order_shots_mobile/shared/loading.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key, this.toggleView});

  final Function? toggleView;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
              title: const Text("Sign in to Order Shots"),
              actions: [
                TextButton.icon(
                    onPressed: () {
                      widget.toggleView!();
                    },
                    icon: const Icon(Icons.person),
                    label: const Text('Register'))
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
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error =
                                    'Could not sign in with those credentials.';
                                loading = false;
                              });
                            }
                          }
                        },
                        color: Colors.limeAccent[400],
                        child: const Text(
                          "Sign In",
                          style: TextStyle(color: Colors.white),
                        )),
                    const SizedBox(height: 20),
                    Text(error,
                        style: const TextStyle(color: Colors.red, fontSize: 14))
                  ],
                ),
              ),
              // child: ElevatedButton(
              //     onPressed: () async {
              //       dynamic result = await _auth.signInAnon();
              //       if (result == null) {
              //         print("error signing in");
              //       } else {
              //         print('Signed In');
              //         print(result.uid);
              //       }
              //     },
              //     child: const Text('Sign In Anon')),
            ),
          );
  }
}
