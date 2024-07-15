import 'package:flutter/material.dart';

class Upgrades extends StatefulWidget {
  const Upgrades({Key? key}) : super(key: key);

  @override
  State<Upgrades> createState() => _UpgradesState();
}

class _UpgradesState extends State<Upgrades> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF8552),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Coming Soon',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
