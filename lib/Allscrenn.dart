import 'package:flutter/material.dart';

void main() => runApp(const AllScrenn());

class AllScrenn extends StatelessWidget {
  const AllScrenn({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Inprogress'),
        ),
      ),
    );
  }
}
