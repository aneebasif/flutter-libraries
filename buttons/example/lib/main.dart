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
            SizedBox(
              width: 250,
              child: WoiTextButton(
                buttonStyle: WoiButtonStyle(
                  sideWidget: const CircularProgressIndicator(),
                  sideWidgetSize: 20,
                  text: 'Submit'.toUpperCase(),
                  textMargin: const EdgeInsets.only(
                    left: 8,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            WoiTextButton(
              onTap: () {},
              width: 300,
              buttonStyle: WoiButtonStyle(
                text: 'Hello There!!!',
                border: Border.all(
                  width: 4,
                ),
                textStyle: const TextStyle(
                  color: Colors.white,
                ),
              ),
              borderColor: Colors.blue,
              fillColor: Colors.black,
              heigth: 50,
            ),
            WoiTextButton(
              onTap: () {},
              buttonStyle: WoiButtonStyle(
                text: 'Hello There!!!',
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                gradient: const LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.green,
                    Colors.blue,
                    Colors.orange,
                    Colors.black,
                  ],
                ),
              ),
              width: 300,
            ),
            WoiTextButton(
              onTap: () {},
              buttonStyle: WoiButtonStyle(
                text: 'Icon button'.toUpperCase(),
                sideWidget: const Padding(
                  padding: EdgeInsets.only(
                    right: 8.0,
                  ),
                  child: Icon(
                    Icons.add_link,
                    color: Colors.white,
                  ),
                ),
                widgetLocation: WidgetLocation.start,
              ),
              width: 200,
            ),
            WoiTextButton(
              onTap: () {},
              buttonStyle: WoiButtonStyle(
                text: 'Icon button'.toUpperCase(),
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                borderRadius: BorderRadius.zero,
                border: Border.all(
                  color: Colors.red,
                  width: 5,
                ),
                gradient: const LinearGradient(
                  colors: [
                    Colors.blue,
                    Colors.green,
                  ],
                ),
                backgroundColor: Colors.blue,
              ),
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
