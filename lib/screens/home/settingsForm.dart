// ignore_for_file: file_names, avoid_print
import 'package:flutter/material.dart';
import 'package:order_shots_mobile/models/user.dart';
import 'package:order_shots_mobile/services/database.dart';
import 'package:order_shots_mobile/shared/constants.dart';
import 'package:order_shots_mobile/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> dilution = ['0', '1', '2', '3', '4'];

  String? currentName;
  String? currentDilution;
  int? currentAlcoholStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserNew?>(context);
    return StreamBuilder<UserData>(
        stream: DataBaseService(uid: user!.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      "Update your preffered shots properties",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      initialValue: userData!.name,
                      decoration: textInputDecoration,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter a name' : null,
                      onChanged: (value) => setState(() => currentName = value),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // dropdown
                    DropdownButtonFormField(
                      decoration: textInputDecoration,
                      value: currentDilution ?? userData.dilution!,
                      items: dilution.map((dilution) {
                        return DropdownMenuItem(
                          value: dilution,
                          child: Text('$dilution shots of dilution'),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() {
                        currentDilution = value;
                      }),
                    ),
                    // slider
                    Slider(
                      value: (currentAlcoholStrength ?? userData.strength)!
                          .toDouble(),
                      activeColor: Colors
                          .indigo[currentAlcoholStrength ?? userData.strength!],
                      inactiveColor: Colors.indigo[currentAlcoholStrength ??
                          currentAlcoholStrength ??
                          userData.strength!],
                      min: 100,
                      max: 900,
                      divisions: 8,
                      onChanged: (value) => setState(() {
                        currentAlcoholStrength = value.round();
                      }),
                    ),
                    MaterialButton(
                        color: Colors.limeAccent[400],
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await DataBaseService(uid: user.uid).updateUserData(
                                currentDilution ?? userData.dilution!,
                                currentName ?? userData.name!,
                                currentAlcoholStrength ?? userData.strength!);
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          }
                          // N.B: ?? is a null aware operator which checks if the first variable has a value,
                          // and if not it passes the second value to the form instead.
                        },
                        child: const Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ));
          } else {
            return const Loading();
          }
        });
  }
}
