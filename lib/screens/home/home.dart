import 'package:flutter/material.dart';
import 'package:order_shots_mobile/models/shots.dart';
import 'package:order_shots_mobile/screens/home/settingsForm.dart';
import 'package:order_shots_mobile/screens/home/shotsList.dart';
import 'package:order_shots_mobile/services/auth.dart';
import 'package:order_shots_mobile/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    void showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: const SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Shots>?>.value(
      value: DataBaseService().shots,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.indigo[100],
        appBar: AppBar(
          title: const Text('Order Shots'),
          backgroundColor: Colors.indigo[400],
          elevation: 0,
          actions: <Widget>[
            TextButton.icon(
              onPressed: (() async {
                await _auth.signOut();
              }),
              icon: const Icon(Icons.person),
              label: const Text('logout'),
            ),
            TextButton.icon(
                icon: const Icon(Icons.settings),
                onPressed: () => showSettingsPanel(),
                label: const Text('settings'))
          ],
        ),
        body: Stack(
          children: [
            Positioned(
              left: 0,
              bottom: 0,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * 0.5,
                child: Image.asset(
                  'assets/2.png',
                  fit: BoxFit.fill,
                  opacity: const AlwaysStoppedAnimation(.3),
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * 0.5,
                child: Image.asset(
                  'assets/1.png',
                  fit: BoxFit.fill,
                  opacity: const AlwaysStoppedAnimation(.3),
                ),
              ),
            ),
            const ShotsList(),
          ],
        ),
      ),
    );
  }
}
