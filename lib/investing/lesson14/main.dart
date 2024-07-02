import 'package:flutter/material.dart';
import 'package:brain_train_app/buttons.dart';
import '../helper_fn.dart';
import 'questions.dart';
import '../menu.dart';

class Lesson14 extends StatefulWidget {
  const Lesson14({super.key});

  @override
  State<Lesson14> createState() => _Lesson14();
}

class _Lesson14 extends State<Lesson14> {
  int selectedOption = -1;

  Widget buildQuizScreen({
    required int questionNumber,
    String? image,
    Widget? imageWidget,
  }) {
    List<String> answers = questions[questionNumber]["answers"] as List<String>;
    ListTile createListTitle(int val, String text, Size size) {
      return ListTile(
        dense: true,
        title: Text(
          text,
          style: TextStyle(fontSize: 0.02 * size.height),
        ),
        leading: (usersAnswers[questionNumber] == -1)
            ? Radio<int>(
                value: val,
                groupValue: usersAnswers[questionNumber],
                activeColor: Colors.blue,
                onChanged: (value) {
                  setState(() {
                    usersAnswers[questionNumber] = value!;
                  });
                },
              )
            : createDot(
                context,
                usersAnswers[questionNumber],
                questions[questionNumber]["correctAnswer"]!,
                val,
              ),
      );
    }

    return createExercise(
      context,
      questionNumber,
      questions[questionNumber]["question"] as String,
      answers,
      image,
      imageWidget,
      createListTitle,
      (questions[questionNumber]["explanation"] != null &&
              usersAnswers[questionNumber] != -1)
          ? questions[questionNumber]["explanation"] as String
          : null,
    );
  }

  List<int> usersAnswers = List<int>.filled(questions.length, -1);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            left: size.width / 10,
            right: size.width / 10,
            top: size.height / 15,
            bottom: size.height / 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Lesson 14",
                style: TextStyle(
                  fontSize: size.width / 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height / 60),
              Text(
                "Practical Analysis of Stocks",
                style: TextStyle(
                  fontSize: size.width / 15,
                ),
              ),
              createDivider(context),
              buildQuizScreen(
                questionNumber: 0,
                image: "assets/investing/lesson14/ex0.png",
              ),
              createDivider(context),
              buildQuizScreen(
                questionNumber: 1,
                image: "assets/investing/lesson14/ex1.png",
              ),
              createDivider(context),
              buildQuizScreen(
                questionNumber: 2,
                image: "assets/investing/lesson14/ex2.png",
              ),
              createDivider(context),
              buildQuizScreen(
                questionNumber: 3,
                image: "assets/investing/lesson14/ex3.png",
              ),
              createDivider(context),
              buildQuizScreen(
                questionNumber: 4,
                image: "assets/investing/lesson14/ex4.png",
              ),
              createDivider(context),
              buildQuizScreen(
                questionNumber: 5,
                image: "assets/investing/lesson14/ex5.png",
              ),
              createDivider(context),
              buildQuizScreen(
                questionNumber: 6,
                image: "assets/investing/lesson14/ex6.png",
              ),
              createDivider(context),
              buildQuizScreen(
                questionNumber: 7,
                image: "assets/investing/lesson14/ex7.png",
              ),
              createDivider(context),
              buildQuizScreen(
                questionNumber: 8,
                image: "assets/investing/lesson14/ex8.png",
              ),
              createDivider(context),
              buildQuizScreen(
                questionNumber: 9,
                image: "assets/investing/lesson14/ex9.png",
              ),
              SizedBox(height: size.height / 10),
              Center(
                child: SizedBox(
                  height: size.height * 0.05,
                  width: size.width * 0.75,
                  child: RedirectButton(
                    //route: const Lesson2(),
                    onClick: () {
                      int score = 0;
                      for (int i = 0; i < usersAnswers.length; i++) {
                        if (usersAnswers[i] == questions[i]["correctAnswer"]) {
                          score++;
                        }
                      }
                      print("wynik:");
                      print(score);
                      saveResult(12, score);
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const InvestingMenu(),
                        ),
                      );
                    },
                    text: 'Continue',
                    width: size.width,
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
