import 'package:weoveri_capsule_button/capsule_button.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Capsule Button Example'),
        ),
        body: Center(
          child: MyCapsuleButton(
            text: 'button'.toUpperCase(),
            onTap: () {},
          ),
        ),
      ),
    );
  }
}
