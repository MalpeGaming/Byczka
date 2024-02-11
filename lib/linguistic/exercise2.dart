import "package:any_link_preview/any_link_preview.dart";
import 'package:path_provider/path_provider.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:xml/xml.dart' as xml;
import "../show_score.dart";
import '../account/login1.dart';
import 'dart:async';
import 'dart:io';

class SecondLinguisticExercise extends StatefulWidget {
  const SecondLinguisticExercise({super.key});

  @override
  State<SecondLinguisticExercise> createState() => _SecondLinguisticExercise();
}

class _SecondLinguisticExercise extends State<SecondLinguisticExercise> {
  double score = 0;
  String languageLevel = "";

  Future<String> loadLevel() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String appDocumentsPath = appDocumentsDirectory.path;

    String filePath = '$appDocumentsPath/lang_lev.xml';
    String localLevel = "";

    if (!File(filePath).existsSync()) {
      return "";
    }

    String data = File(filePath).readAsStringSync();
    var xdoc = xml.XmlDocument.parse(data);
    localLevel = xdoc.getElement("root")!.getElement("level")!.innerText;
    return localLevel;
  }

  Future<void> initMemory() async {
    languageLevel = await loadLevel();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initMemory();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width * 0.9,
          height: size.height * 0.9,
          margin: EdgeInsets.only(
            left: size.width / 10,
            right: size.width / 10,
            top: size.height / 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                        children: [
                          TextSpan(
                            text: "LINGUISTIC\n",
                            style: TextStyle(
                              fontSize: size.width / 8,
                            ),
                          ),
                          TextSpan(
                            text: "INTELLIGENCE",
                            style: TextStyle(
                              fontSize: size.width / 16,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  Text(
                    "Exercise 2 - Reading Comprehension",
                    style: TextStyle(fontSize: size.width / 20),
                  ),
                  SizedBox(
                    height: size.height / 25,
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: size.width / 24,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                      children: const <TextSpan>[
                        TextSpan(
                          text:
                              "In this exercise you will complete part of the ",
                        ),
                        TextSpan(
                          text: "SAT literature Reading Part.",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height / 20,
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: size.width / 24,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                      children: const <TextSpan>[
                        TextSpan(text: "You will have "),
                        TextSpan(
                          text: "13 minutes to complete ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: "the reading practice.\n"),
                        TextSpan(
                          text: "Prepare the timer",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: ", and turn it on when you begin the exercise.",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height / 20,
                  ),
                  Text(
                    "Click on the link to see the free exercise.",
                    style: TextStyle(
                      fontSize: size.width / 24,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  languageLevel.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : AnyLinkPreview(
                          displayDirection: UIDirection.uiDirectionHorizontal,
                          link:
                              "https://app.engxam.com/$languageLevel/listening/1/?utm_source=canva&utm_medium=iframely",
                          errorBody: 'Error body',
                          errorTitle: 'Error',
                          backgroundColor:
                              Theme.of(context).colorScheme.onSecondary,
                          titleStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          showMultimedia: false,
                        ),
                  SizedBox(
                    height: size.height / 25,
                  ),
                  Text(
                    "Write your score BELOW.",
                    style: TextStyle(fontSize: size.width / 24),
                  ),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      child: TextField(
                        style: TextStyle(fontSize: size.width / 24),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TextInputFormatter.withFunction((oldValue, newValue) {
                            String text = newValue.text;
                            if (text.isEmpty) {
                              score = 0;
                              return newValue;
                            }
                            if (int.parse(text) <= 100) {
                              score = double.parse(text);
                              text += "%";
                              return TextEditingValue(
                                text: text,
                                selection: newValue.selection,
                              );
                            }
                            return oldValue;
                          }),
                        ],
                        maxLines: 1,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: "4%",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                heightFactor: 1,
                child: SizedBox(
                  height: size.height * 0.05,
                  width: size.width * 0.75,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowScore(
                            title: "LINGUISTIC",
                            description: "Exercise 2 - Reading Comprehension",
                            exercise: 2,
                            yourScore: score,
                            maximum: 100,
                            page: const Login1(),
                            subtitle: "INTELLIGENCE",
                          ),
                        ),
                      );
                    },
                    tooltip: "Continue",
                    label: Text(
                      "Continue",
                      style: TextStyle(fontSize: size.width / 16),
                    ),
                    icon: Icon(
                      Icons.arrow_forward_rounded,
                      size: size.width / 16,
                    ),
                    backgroundColor: Colors.blue[400],
                    hoverColor: Colors.blue[900],
                    autofocus: true,
                    heroTag: "continue",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
