import 'package:flutter/material.dart';
import '../app_bar.dart';
import 'package:yaml/yaml.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class ReadingComprehension extends StatefulWidget {
  const ReadingComprehension({super.key, this.initialTest = false});

  final bool initialTest;

  @override
  State<ReadingComprehension> createState() => _ReadingComprehension();
}

class _ReadingComprehension extends State<ReadingComprehension> {
  List<String> questions = [];
  List<int> correct = [];
  List<int> usersAnswers = [];
  List<List<String>> answers = [];
  String title = "";
  String author = "";
  String text = "";
  var rng = Random();
  int selectedOption = -1;

  Widget createExercise(BuildContext context, int index) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.onPrimary,
            ],
            tileMode: TileMode.decal,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow.withOpacity(1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(5, 5),
            ),
          ],
        ),
        width: size.width * 0.8,
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Center(
            child: Text(
              questions[index],
              style: TextStyle(
                fontSize: size.width / 22,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget createDot(
    BuildContext context,
    int usersAnswer,
    Object correct,
    int val,
  ) {
    Size size = MediaQuery.of(context).size;
    return usersAnswer == val || correct == val
        ? Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width / 30,
            ),
            child: Icon(
              correct == val ? Icons.check_circle : Icons.cancel,
              color: correct == val ? Colors.green : Colors.red,
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width / 30,
            ),
            child: const Icon(Icons.circle_outlined),
          );
  }

  ListTile createListTitle(
      BuildContext context, int index, int val, String text) {
    Size size = MediaQuery.of(context).size;

    return ListTile(
      title: Text(
        text,
        style: TextStyle(fontSize: 0.02 * size.height),
      ),
      leading: (usersAnswers[index] == -1)
          ? Radio<int>(
              value: val,
              groupValue: usersAnswers[index],
              activeColor: Colors.blue,
              onChanged: (value) {
                setState(() {
                  usersAnswers[index] = value!;
                });
              },
            )
          : createDot(
              context,
              usersAnswers[index],
              correct[index],
              val,
            ),
    );
  }

  void readData() async {
    try {
      List<String> newQuestions = [];
      List<int> newCorrect = [];
      List<List<String>> newAnswers = [];
      int test = rng.nextInt(11);

      final file = await rootBundle
          .loadString('assets/linguistic/reading_comprehension.yaml');
      final tasks = loadYaml(file)["tests"][test];
      print(tasks[0]["questions"]);
      for (var i = 0; i < tasks[0]["questions"].length; i++) {
        newQuestions.add(tasks[0]["questions"][i]["question"]);
        newCorrect.add(tasks[0]["questions"][i]["correct_answer"]);

        newAnswers.add([]);
        for (var answer in tasks[0]["questions"][i]["answers"]) {
          newAnswers[newAnswers.length - 1].add(answer.toString());
        }
      }

      setState(() {
        questions = newQuestions;
        correct = newCorrect;
        answers = newAnswers;
        title = tasks[0]["title"];
        author = tasks[0]["author"];
        text = tasks[0]["text"];
        usersAnswers = List<int>.filled(questions.length, -1);
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appBar(context, ""),
      body: SingleChildScrollView(
        child: Container(
          width: size.width * 0.9,
          height: size.height * 0.9,
          margin: EdgeInsets.only(
            left: size.width / 10,
            right: size.width / 10,
          ),
          child: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title.toString(),
                      style: TextStyle(
                        fontSize: size.width / 25,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "by $author",
                      style: TextStyle(fontSize: size.width / 30),
                    ),
                    SizedBox(
                      height: size.height / 30,
                    ),
                    Text(
                      text,
                      style: TextStyle(
                          fontSize: size.height / 50,
                          height: size.height / 700),
                    ),
                    Text(questions.toString()),
                    createExercise(context, 0),
                    for (int i = 0; i < answers[0].length; i++)
                      createListTitle(
                        context,
                        0,
                        i,
                        answers[0][i],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
