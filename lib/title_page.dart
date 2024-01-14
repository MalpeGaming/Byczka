import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'app_bar.dart';
import 'buttons.dart';

class TitlePage extends StatefulWidget {
  const TitlePage({super.key, required this.title});

  final String title;

  @override
  State<TitlePage> createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context, "title"),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(
              left: size.width / 10,
              right: size.width / 10,
              top: size.height / 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "IMPROVE YOUR",
                style: TextStyle(
                    fontSize: size.width / 10,
                    fontWeight: FontWeight.w500,
                    height: 1),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: size.height / 8,
                child: DefaultTextStyle(
                  style: TextStyle(
                    fontSize: size.height / 10,
                    fontFamily: 'Horizon',
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      RotateAnimatedText('BRAIN'),
                      RotateAnimatedText('MIND'),
                      RotateAnimatedText('BODY'),
                    ],
                    pause: const Duration(milliseconds: 400),
                    repeatForever: true,
                  ),
                ),
              ),
              SizedBox(height: 0.01 * size.height),
              Text(
                "IN 30 DAYS!",
                style: TextStyle(fontSize: size.width / 16),
              ),
              SizedBox(height: 0.05 * size.height),
              Container(
                margin: EdgeInsets.all(size.width / 14.0),
                child: Image.asset('assets/brain_img.png'),
              ),    
              SizedBox(height: size.height / 50),
              SizedBox(
                height: size.height * 0.05,
                width: size.width * 0.75,
                child: StartButton(
                  text: "Test Yourself!",
                  width: size.width,
                  tooltip: 'Smart Decision!',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
