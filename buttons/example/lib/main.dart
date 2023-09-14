import 'package:flutter/material.dart';
import 'package:weoveri_button/main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Capsule Buttons'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //----------Capsule Button-------------
            WoiCapsuleIconButton(
              text: 'Icon button'.toUpperCase(),
              onTap: () {},
              icon: const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.add_link,
                  color: Colors.white,
                ),
              ),
              iconLocation: WidgetLocation.start,
              width: 200,
            ),
            //----------Parallalogram Button-------------
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadingParallalogramButton(
                  text: "Parallalogram Button".toUpperCase(),
                  tiltSide: TiltSide.right,
                  buttonColor: Colors.black,
                  onPressed: () {},
                  loadingProgressIndicator: const CircularProgressIndicator(),
                  indicatorMargin: const EdgeInsets.only(
                    right: 8,
                  ),
                  indicatorSize: 24,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
