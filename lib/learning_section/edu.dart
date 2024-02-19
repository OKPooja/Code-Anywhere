import 'package:flutter/material.dart';

class Edu extends StatefulWidget {
  const Edu({super.key});

  @override
  State<Edu> createState() => _EduState();
}

class _EduState extends State<Edu> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Learn'),
      ),
    );
  }
}
