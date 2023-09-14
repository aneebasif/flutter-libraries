import 'package:flutter/material.dart';
import 'package:weoveri_button/capsule_button/woi_button_style.dart';
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
            WoiBaseButton(
              buttonStyle: WoiButtonStyle(
                circularProgressIndicator: const CircularProgressIndicator(),
                progressIndicatorheight: 15,
                // widgetLocation: WidgetLocation.end,
                text: 'Submit'.toUpperCase(),
                textStyle: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
            WoiCapsuleButton(
              onTap: () {},
              width: 300,
              text: 'Hello There!!!',
              borderColor: Colors.blue,
              fillColor: Colors.black,
              borderWidth: 4,
              heigth: 50,
              textStyle: const TextStyle(
                color: Colors.white,
              ),
            ),
            WoiCapsuleGradientButton(
              onTap: () {},
              text: 'Hello There!!!',
              textStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              width: 300,
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
            WoiCapsuleIconButton(
              text: 'Icon button'.toUpperCase(),
              onTap: () {},
              icon: const Padding(
                padding: EdgeInsets.only(
                  right: 8.0,
                ),
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
