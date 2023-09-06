import 'package:flutter/material.dart';

import '../main.dart';

void main() => runApp(const Inprogress());

class Inprogress extends StatelessWidget {
  const Inprogress({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Inprogress'),
        ),
        body: const MyApp(),
      ),
    );
  }
}
