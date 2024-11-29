import 'package:brain_train_app/home.dart';
import 'package:flutter/material.dart';
import '/navbar.dart';
import 'tos.dart';
import 'contact.dart';
import 'functions.dart';
import '../score_n_progress/show_improvement.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _Settings();
}

class _Settings extends State<Settings> {
  List<String> settings = [
    "Terms of Use",
    "Contact Us",
    "Restart The App",
    "End The Program",
    "Our Website",
  ];

  List<Widget?> routes = [
    const TermsOfService(),
    const Contact(),
    null,
    const ShowImprovement(
      title: "ATTENTION",
      description: "Exercise 2 - Long Term Concentration",
      exercise: 2,
      yourScore: 1.0,
      maximum: 10,
      page: Home(),
    ),
    const SizedBox(),
  ];
  List<bool> highlighted = [false, false, false, false, false, false];
  List<Color> colors = [
    const Color.fromARGB(255, 182, 182, 182),
    const Color.fromARGB(255, 211, 211, 211),
    const Color.fromARGB(255, 192, 192, 192),
    const Color.fromARGB(255, 187, 187, 187),
  ];
  Widget element(
    BuildContext context,
    int index,
  ) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        if (index == 2) {
          if (index == 2) {
            popUp(
              context,
              'By restarting the program, you will return to the welcome screen. Your ',
              'scores will be lost.',
              '',
              'Would you like to restart the App?',
              restartApp,
            );
          } else if (index == 4) {
            Site.launch();
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => routes[index]!),
            );
          }
        } else if (index == 3) {
          popUp(
            context,
            'By ending the program, you will ',
            'recieve a final test, ',
            'and be transported to the welcome screen.',
            'Do you want to end the Program?',
            endProgram,
          );
        } else if (index == 4) {
          Site.launch();
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => routes[index]!),
          );
        }
      },
      onTapUp: (details) => setState(
        () {
          highlighted[index] = false;
        },
      ),
      onTapDown: (details) {
        setState(() {
          highlighted[index] = true;
        });
      },
      onTapCancel: () => setState(() {
        highlighted[index] = false;
      }),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: colors[((Theme.of(context).brightness == Brightness.dark)
                        ? 2
                        : 0) +
                    (highlighted[index] ? 1 : 0)],
                width: 4.0,
              ),
              color: (Theme.of(context).brightness == Brightness.dark)
                  ? Theme.of(context).colorScheme.surface
                  : Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(2137.0),
            ),
            width: double.infinity,
            height: size.height * 0.07,
            //margin: EdgeInsets.only(top: 10),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colors[
                            ((Theme.of(context).brightness == Brightness.dark)
                                    ? 2
                                    : 0) +
                                (highlighted[index] ? 1 : 0)],
                        width: 4.0,
                      ),
                    ),
                    height: size.height * 0.07,
                    width: size.height * 0.07,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(
                        "assets/settings/${index + 1 + (highlighted[index] ? 6 : 0) + ((Theme.of(context).brightness == Brightness.dark) ? 12 : 0)}.png",
                        fit: BoxFit.fill,
                        gaplessPlayback: true,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.04,
                ),
                Text(
                  settings[index],
                  style: TextStyle(fontSize: size.width / 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            left: size.width / 10,
            right: size.width / 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 0.1 * size.height),
              Center(
              child: Text(
                "-Broin App-",
                style: TextStyle(
                  fontSize: size.width / 12,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
              Center(
                child: Text(
                  "Settings",
                  style: TextStyle(
                    fontSize: size.width / 8,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 0.05 * size.height),
              Column(
                children: List.generate(
                  5,
                  (index) => Column(
                    children: [
                      element(context, index),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
