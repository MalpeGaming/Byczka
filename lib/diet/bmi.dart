import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter/services.dart';
import '/app_bar.dart';

class BMI extends StatefulWidget {
  const BMI({super.key});

  @override
  State<BMI> createState() => _BMI();
}

class _BMI extends State<BMI> {
  bool onclick = false;
  double bmi = 0;
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();

  SfLinearGauge createAxis(BuildContext context, double yourScore) {
    return SfLinearGauge(
      showAxisTrack: false,
      showTicks: false,
      showLabels: false,
      useRangeColorForAxis: true,
      animateAxis: true,
      axisTrackStyle: const LinearAxisTrackStyle(thickness: 1),
      ranges: <LinearGaugeRange>[
        LinearGaugeRange(
          startWidth: 30,
          endWidth: 30,
          shaderCallback: (bounds) => const RadialGradient(
            center: Alignment.topLeft,
            radius: 9,
            colors: [
              Color.fromARGB(255, 0, 102, 255),
              Color.fromARGB(255, 0, 225, 255),
              Color.fromARGB(255, 0, 255, 55),
              Colors.yellow,
              Colors.red,
            ],
          ).createShader(bounds),
        ),
      ],
      markerPointers: [
        const LinearShapePointer(
          value: 16,
          shapeType: LinearShapePointerType.rectangle,
          height: 30,
          width: 4,
        ),
        const LinearWidgetPointer(
          value: 16,
          offset: 35,
          position: LinearElementPosition.outside,
          child: Text("16"),
        ),
        LinearShapePointer(
          value: yourScore,
          shapeType: LinearShapePointerType.rectangle,
          height: 30,
          width: 4,
        ),
        LinearWidgetPointer(
          value: yourScore,
          offset: 35,
          position: LinearElementPosition.outside,
          child: const Text(
            "Your\nBMI",
            style: TextStyle(height: 1),
          ),
        ),
        const LinearShapePointer(
          value: 25,
          shapeType: LinearShapePointerType.rectangle,
          height: 30,
          width: 4,
        ),
        const LinearWidgetPointer(
          value: 25,
          offset: 35,
          position: LinearElementPosition.outside,
          child: Text("25"),
        ),
      ],
      minimum: 14,
      maximum: 27,
    );
  }

  SizedBox buildButton(BuildContext context, bool pressedNum, String text) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: 0.15 * size.width,
      child: OutlinedButton(
        onPressed: () {
          onclick = pressedNum;
          setState(() {
            if (weight.text.isNotEmpty && height.text.isNotEmpty) {
              calcBMI(int.parse(height.text) / 100.0, int.parse(weight.text));
            }
          });
        },
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              return states.contains(WidgetState.pressed)
                  ? Theme.of(context).colorScheme.secondary
                  : onclick == pressedNum
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.5)
                      : Theme.of(context).colorScheme.surface;
            },
          ),
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.all(8.0),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 0.045 * size.width,
              color: Theme.of(context).colorScheme.onSecondary,),
        ),
      ),
    );
  }

  Column buildQuery(
    BuildContext context,
    String text,
    int hintText,
    String txt1,
    String txt2,
    TextEditingController controller,
  ) {
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
                  onChanged: (String value) {
                    if (height.text.isNotEmpty && weight.text.isNotEmpty) {
                      setState(() {
                        calcBMI(
                          int.parse(height.text) / 100.0,
                          int.parse(weight.text),
                        );
                      });
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  controller: controller,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: size.width / 24),
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 0.10 * size.width,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: hintText.toString(),
                    hintStyle: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSecondary
                          .withOpacity(0.4),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 0.01 * size.height),
            buildButton(context, false, txt1),
            SizedBox(width: 0.01 * size.height),
            buildButton(context, true, txt2),
          ],
        ),
      ],
    );
  }

  void calcBMI(double height, int weight) {
    if (height != 0 && weight != 0) {
      double h = height.toDouble();
      double w = weight.toDouble();
      if (!onclick) bmi = w / (h * h);
      if (onclick) bmi = w * 703 / (h * 100 * h * 100);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context, ""),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            left: size.width / 10,
            right: size.width / 10,
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
Center(
  child: Text(
    "based on www.truthaboutweight.global",
    style: TextStyle(
      fontSize: size.width / 30,
      color: Colors.grey, // Możesz dostosować kolor według potrzeb
    ),
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
                    buildQuery(context, "Height", 167, "cm", "in", height),
                    SizedBox(height: 0.03 * size.height),
                    buildQuery(context, "Weight", 56, "kg", "lb", weight),
                    SizedBox(height: 0.05 * size.height),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 0.03 * size.height,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                        children: <TextSpan>[
                          const TextSpan(
                            text: 'Your BMI is ',
                          ),
                          TextSpan(
                            text: () {
                              try {
                                if (height.text.isNotEmpty &&
                                    weight.text.isNotEmpty) {
                                  return bmi.toStringAsFixed(1);
                                } else {
                                  return '?';
                                }
                              } catch (e) {
                                return '?';
                              }
                            }(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: (() {
                                try {
                                  if (height.text.isEmpty ||
                                      weight.text.isEmpty) {
                                    return Theme.of(context)
                                        .colorScheme
                                        .onSecondary;
                                  } else if (bmi > 25) {
                                    return Colors.red;
                                  } else if (bmi > 20) {
                                    return Colors.green;
                                  } else {
                                    return Colors.blue;
                                  }
                                } catch (e) {
                                  return Colors.black;
                                }
                              })(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 0.05 * size.height),
              createAxis(context, bmi),
              SizedBox(height: 0.05 * size.height),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 0.023 * size.height,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: () {
                        if (weight.text.isNotEmpty && height.text.isNotEmpty) {
                          return "In order to have the best “Brain BMI” we recommend that you ";
                        }
                      }(),
                    ),
                    TextSpan(
                      text: () {
                        try {
                          if (weight.text.isEmpty || height.text.isEmpty) {
                            return "";
                          } else if (bmi >= 20.5 && bmi <= 21.5) {
                            return "stay like you are";
                          } else if (bmi > 21.5) {
                            double weightValue = double.tryParse(weight.text)!;
                            double heightValue = double.tryParse(height.text)!;
                            double res = weightValue -
                                (21 *
                                    (heightValue / 100) *
                                    (heightValue / 100));
                            if (onclick) res /= 7;
                            return "lose ${res.toStringAsFixed(1)}";
                          } else if (bmi < 20.5) {
                            double weightValue = double.tryParse(weight.text)!;
                            double heightValue = double.tryParse(height.text)!;
                            double res =
                                21 * (heightValue / 100) * (heightValue / 100) -
                                    weightValue;
                            if (onclick) {
                              res = (21 * heightValue * heightValue) / 703 -
                                  weightValue;
                            }
                            return "gain ${res.toStringAsFixed(1)}";
                          }
                        } catch (e) {
                          return '?';
                        }
                      }(),
                    ),
                    TextSpan(
                      text: () {
                        try {
                          if (weight.text.isEmpty ||
                              height.text.isEmpty ||
                              bmi >= 20.5 && bmi <= 21.5) {
                            return "";
                          } else if (!onclick) {
                            return "kg";
                          } else if (onclick) {
                            return "lb";
                          }
                        } catch (e) {
                          return '?';
                        }
                      }(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
