import 'package:flutter/material.dart';
import '../navbar.dart';

class BMI extends StatefulWidget {
  const BMI({super.key});

  @override
  State<BMI> createState() => _BMI();
}

bool onclick = false;

class _BMI extends State<BMI> {
  SizedBox buildButton(BuildContext context, bool pressedNum, String text) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: 0.15 * size.width,
      child: OutlinedButton(
        onPressed: () {
          onclick = pressedNum;
          setState(() {});
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              return states.contains(MaterialState.pressed)
                  ? Theme.of(context).colorScheme.secondary
                  : onclick == pressedNum
                      ? const Color.fromARGB(255, 162, 218, 255)
                      : Theme.of(context).colorScheme.background;
            },
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.all(8.0),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 0.045 * size.width),
        ),
      ),
    );
  }

  Column buildQuery(BuildContext context, String text, int hintText,
      String txt1, String txt2) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Please Enter Your $text",
          style: TextStyle(
            fontSize: 0.055 * size.width,
          ),
        ),
        SizedBox(height: 0.007 * size.height),
        Row(
          children: [
            SizedBox(
              width: 0.3 * size.width,
              height: 0.06 * size.height,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                child: TextField(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: size.width / 24),
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 0, horizontal: 0.10 * size.width),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: hintText.toString()),
                ),
              ),
            ),
            SizedBox(width: 0.01 * size.height),
            buildButton(context, false, txt1),
            SizedBox(width: 0.01 * size.height),
            buildButton(context, true, txt2),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(
          left: size.width / 10,
          right: size.width / 10,
          top: size.height / 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    "BMI",
                    style: TextStyle(
                      fontSize: size.width / 7,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    "CALCULATOR",
                    style: TextStyle(fontSize: size.width / 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                left: size.width / 15,
                right: size.width / 15,
                top: size.height / 25,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildQuery(context, "Height", 167, "cm", "in"),
                  SizedBox(height: 0.03 * size.height),
                  buildQuery(context, "Weight", 56, "kg", "lb"),
                  SizedBox(height: 0.05 * size.height),
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Your BMI is',
                          style: TextStyle(
                            fontSize: 0.03 * size.height,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: ' not bold',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 0.02 * size.height,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
