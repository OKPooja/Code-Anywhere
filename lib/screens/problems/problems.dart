import 'package:flutter/material.dart';

class Problems extends StatefulWidget {
  const Problems({super.key});

  @override
  State<Problems> createState() => _ProblemsState();
}

class _ProblemsState extends State<Problems> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Problems'),
      ),
    );
  }
}
