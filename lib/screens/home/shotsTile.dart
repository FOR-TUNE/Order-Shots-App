// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:order_shots_mobile/models/shots.dart';

class ShotsTile extends StatelessWidget {
  const ShotsTile({super.key, required this.shots});

  final Shots shots;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Card(
        margin: const EdgeInsets.fromLTRB(10, 6, 10, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.indigo[shots.alcoholStrength],
          ),
          title: Text(shots.name),
          subtitle: Text(
              "Takes ${shots.dilutionStrength} cup(s) of Chapman dilution"),
          trailing: const CircleAvatar(
            radius: 15.0,
            backgroundImage: AssetImage('assets/11.png'),
          ),
        ),
      ),
    );
  }
}
