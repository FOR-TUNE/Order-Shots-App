// ignore_for_file: avoid_print, file_names
import 'package:flutter/material.dart';
import 'package:order_shots_mobile/screens/home/shotsTile.dart';
import 'package:provider/provider.dart';

import '../../models/shots.dart';

class ShotsList extends StatefulWidget {
  const ShotsList({super.key});

  @override
  State<ShotsList> createState() => _ShotsListState();
}

class _ShotsListState extends State<ShotsList> {
  @override
  Widget build(BuildContext context) {
    final shots = Provider.of<List<Shots>?>(context) ?? [];
    // print(shots!.docs);
    // shots?.forEach((shot) {
    //   print(shot.name);
    //   print(shot.dilutionStrength);
    //   print(shot.alcoholStrength);
    // });
    return ListView.builder(
      itemCount: shots.length,
      itemBuilder: (context, index) {
        return ShotsTile(shots: shots[index]);
      },
    );
  }
}
