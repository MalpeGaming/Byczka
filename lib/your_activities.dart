import 'package:brain_train_app/attention/find_the_number.dart';
import 'package:brain_train_app/linguistic/choose_best_word.dart';
import 'package:brain_train_app/linguistic/reading_comprehension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'navbar.dart';
import 'well_being/self_reflection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'well_being/meditation/meditation.dart';
import 'well_being/sport.dart';
import 'well_being/yoga.dart';
import 'memory/memory_game1.dart';
import 'memory/learning_words/memory.dart';
import 'memory/faces.dart';
import 'attention/long_term_concentration_video.dart';
import 'attention/short_term_concentration.dart';
import 'attention/strong_concentration_desc.dart';
import 'attention/reading/reading.dart';
import 'logical_thinking/sudoku.dart';
import 'linguistic/wordly.dart';
import 'linguistic/hangman.dart';
import 'logical_thinking/riddles.dart';
import 'linguistic/listening_comprehension_video.dart';
import 'memory/working_memory.dart';
import 'linguistic/scrabble.dart';
import 'logical_thinking/2048/game_2048.dart';
import 'linguistic/spelling_mistakes.dart';
import 'well_being/memes.dart';
import 'linguistic/grammar_mcq_test.dart';
import 'linguistic/correct_a_word.dart';
import 'investing/menu.dart';
import 'linguistic/poems_reading/poems_info.dart';
import 'linguistic/idioms.dart';
import 'package:brain_train_app/activities_for_each_section.dart';
import 'package:page_transition/page_transition.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'dart:math' as math;

class YourActivities extends StatefulWidget {
  const YourActivities({super.key});
  @override
  State<YourActivities> createState() => _YourActivities();
}

GestureDetector createActivity(
  BuildContext context,
  String img,
  String text1,
  String text2,
  double fontSize,
  Widget route,
  Color color1,
  Color color2, {
  double zero = 1,
  bool blocked = false,
  double textWidth = 0.45,
  title = false,
  bool star = false,
  String exerciseName = "",
  String skill = "",
  List<String> plan = const [],
}) {
  Size size = MediaQuery.of(context).size;
  return GestureDetector(
    onTap: () {
      if (!blocked) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: route,
            reverseDuration: const Duration(milliseconds: 100),
            opaque: true,
          ),
        );
      }
    },
    child: Stack(
      children: [
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    color1,
                    color2,
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
              height: 0.115 * size.height,
              child: Row(
                children: [
                  SizedBox(
                    height: 0.115 * size.height,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FadeInImage(
                        placeholder: (Theme.of(context).brightness ==
                                Brightness.light)
                            ? const AssetImage('assets/placeholder.png')
                            : const AssetImage('assets/placeholder_dark.png'),
                        image: AssetImage('assets/$img.png'),
                        fit: BoxFit.cover,
                        fadeInDuration: const Duration(milliseconds: 200),
                      ),
                    ),
                  ),
                  SizedBox(width: 0.045 * size.width),
                  SizedBox(
                    width: size.width * textWidth,
                    child: Stack(
                      children: [
                        if (star && plan.contains(exerciseName))
                          Align(
                            alignment: Alignment.topRight,
                            child: Transform.rotate(
                              angle: math.pi / 0.07,
                              child: DecoratedIcon(
                                icon: Icon(
                                  Icons.star,
                                  color: const Color.fromARGB(255, 255, 208, 0),
                                  size: 0.05 * size.height,
                                ),
                                decoration:
                                    const IconDecoration(border: IconBorder()),
                              ),
                            ),
                          ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              text1,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                                fontStyle: (title)
                                    ? FontStyle.italic
                                    : FontStyle.normal,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(5, 5),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              text2,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: zero * fontSize,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(5, 5),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 0.025 * size.height),
          ],
        ),
      ],
    ),
  );
}

class _YourActivities extends State<YourActivities> {
  List<String> plan = [];

  Widget createActivity2(
    BuildContext context,
    String img,
    String txt1,
    String txt2,
    Widget route,
    String activityName, {
    double fontSize = 1,
    double zero = 1,
  }) {
    Size size = MediaQuery.of(context).size;
    print(skillAllLists[skill]);

    if (skillAllLists[skill] != null &&
        skillAllLists[skill]!.contains(activityName)) {
      return createActivity(
        context,
        "activities/$img",
        txt1,
        txt2,
        0.023 * size.height * fontSize,
        route,
        Theme.of(context).colorScheme.primary,
        Theme.of(context).colorScheme.onPrimary,
        zero: zero,
        blocked: false,
        textWidth: 0.45,
        title: false,
        star: true,
        exerciseName: activityName,
        skill: skill,
        plan: plan,
      );
    }

    return const SizedBox();
  }

  Future<void> getPlan() async {
    prefs = await SharedPreferences.getInstance();
    List<String> newPlan = prefs.getStringList("basePlanDay$day") ?? [];
    print("poczatek newPlan: $newPlan");
    if (newPlan.isNotEmpty) {
      setState(() {
        plan = newPlan;
      });
      return;
    }
  }

  int day = 1;
  late SharedPreferences prefs;
  String skill = "attention";

  Future<void> getSkill() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.getString('skill') != null) {
        skill = prefs.getString('skill')!;
      } else {
        skill = "attention";
      }
    });
  }

  Future<void> calcDay() async {
    DateTime firstDay = DateTime.now();
    DateTime today = DateTime.now();
    prefs = await SharedPreferences.getInstance();
    String beginningDate = prefs.getString('beginning_date')!;
    firstDay = DateTime.parse(beginningDate);

    setState(() {
      day = today.difference(firstDay).inDays + 1;
    });
  }

  @override
  void initState() {
    super.initState();
    getSkill();
    calcDay();
    getPlan();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    DateTime now = DateTime.now();
    var formatter = DateFormat('E. dd MMM');
    String formattedDate = formatter.format(now);

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(
          left: size.width / 15,
          right: size.width / 15,
          top: size.height / 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 0.005 * size.height),
            
            Center(
              child: Text(
                "Broin Activities",
                style: TextStyle(
                  fontSize: size.width / 12,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: Text(
                "DAY $day - ${formattedDate.toString().toUpperCase()}",
                style: TextStyle(fontSize: size.width / 17),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 0.005 * size.height),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(
                  top: 0.02 * size.height, // space between "Do Today" and activities list
                ),
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: size.width / 20,
                      right: size.width / 20,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Transform.rotate(
                              angle: math.pi / 0.07,
                              child: DecoratedIcon(
                                icon: Icon(
                                  Icons.star,
                                  color: const Color.fromARGB(255, 255, 208, 0),
                                  size: 0.03 * size.height,
                                ),
                                decoration:
                                    const IconDecoration(border: IconBorder()),
                              ),
                            ),
                            SizedBox(width: 0.02 * size.width),
                            Text(
                              "Do Today",
                              style: TextStyle(
                                fontSize: 0.02 * size.height,
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 0.02 * size.height),
                        createActivity2(
                          context,
                          "learning_words",
                          "LEARNING",
                          "Words",
                          const Memory(),
                          "Memory",
                        ),
                        createActivity2(
                          context,
                          "working_memory",
                          "Working",
                          "MEMORY",
                          const WorkingMemory(),
                          "WorkingMemory",
                        ),
                        createActivity2(
                          context,
                          "find_the_number",
                          "Find the",
                          "NUMBER",
                          const FindTheNumber(),
                          "FindTheNumber",
                        ),
                        createActivity2(
                          context,
                          "listening",
                          "LISTENING",
                          "Comprehension",
                          const ListeningComprehensionVideo(),
                          "ListeningComprehensionVideo",
                        ),
                        createActivity2(
                          context,
                          "reading",
                          "READING",
                          "Comprehension",
                          const ReadingComprehension(),
                          "ReadingComprehension",
                        ),
                        createActivity2(
                          context,
                          "poems",
                          "POEMS",
                          "Reading",
                          const PoemsInfo(),
                          "PoemsInfo",
                        ),
                        createActivity2(
                          context,
                          "spelling",
                          "SPELLING",
                          "Mistakes",
                          const SpellingMistakes(
                            exerciseId: 0,
                          ),
                          "SpellingMistakes",
                        ),
                        createActivity2(
                          context,
                          "riddles",
                          "RIDDLES",
                          "",
                          const RiddlesTest(),
                          "Riddles",
                          zero: 0,
                        ),
                        createActivity2(
                          context,
                          "sudoku",
                          "SUDOKU",
                          "",
                          const SudokuGame(),
                          "SudokuGame",
                          zero: 0,
                        ),
                        createActivity2(
                          context,
                          "short_term_concentration",
                          "Short-Term",
                          "CONCENTRATION",
                          const ShortTermConcentration(),
                          "ShortTermConcentration",
                        ),
                        createActivity2(
                          context,
                          "long_term_concentration",
                          "Long-Term",
                          "CONCENTRATION",
                          const LongTermConcentrationVideo(),
                          "LongTermConcentrationVideo",
                        ),
                        createActivity2(
                          context,
                          "strong_concentration",
                          "Strong",
                          "CONCENTRATION",
                          const StrongConcentrationDesc(),
                          "StrongConcentrationDesc",
                        ),
                        createActivity2(
                          context,
                          "reading_out_loud",
                          "READING",
                          "Out-loud",
                          const Reading(),
                          "Reading",
                        ),
                        createActivity2(
                          context,
                          "hangman",
                          "HANGMAN",
                          "",
                          const Hangman(),
                          "Hangman",
                          zero: 0,
                        ),
                        createActivity2(
                          context,
                          "wordly",
                          "WORDLY",
                          "",
                          const Wordly(),
                          "Wordly",
                          zero: 0,
                        ),
                        createActivity2(
                          context,
                          "2048",
                          "2048",
                          "",
                          const Game2048(),
                          "Game2048",
                          zero: 0,
                        ),
                        createActivity2(
                          context,
                          "scrabble",
                          "Like",
                          "SCRABBLE",
                          const Scrabble(
                            iteration: 1,
                            allPoints: 0,
                          ),
                          "Scrabble",
                        ),
                        createActivity2(
                          context,
                          "faces_memory",
                          "Faces",
                          "MEMORY",
                          const Faces(),
                          "Faces",
                        ),
                        createActivity2(
                          context,
                          "correct_a_word",
                          "Correct a word",
                          "",
                          const CorrectAWord(),
                          "CorrectAWord",
                          zero: 0,
                        ),
                        createActivity2(
                          (context),
                          "investing",
                          "Investing",
                          "Course",
                          const InvestingMenu(),
                          "InvestingMenu",
                        ),
                        createActivity2(
                          context,
                          "grammar",
                          "Grammar",
                          "",
                          const Grammar(
                            exerciseId: 0,
                          ),
                          "Grammar",
                          zero: 0,
                        ),
                        createActivity2(
                          context,
                          "choose_best_word",
                          "Choose the",
                          "best WORD",
                          const ChooseBestWord(),
                          "ChooseBestWord",
                        ),
                        createActivity2(
                          context,
                          "idioms",
                          "Idioms, expressions and phrasal verbs",
                          "",
                          const Idioms(),
                          "Idioms",
                          zero: 0,
                        ),
                        createActivity2(
                          context,
                          "memory_game",
                          "MEMORY",
                          "Game",
                          const MemoryGame1(),
                          "MemoryGame1",
                        ),
                        createActivity2(
                          context,
                          "sport",
                          "SPORT",
                          "Optional",
                          const Sport(),
                          "Sport",
                        ),
                        createActivity2(
                          context,
                          "yoga",
                          "Yoga",
                          "",
                          const Yoga(),
                          "Yoga",
                          zero: 0,
                        ),
                        createActivity2(
                          context,
                          "self_reflection",
                          "Self",
                          "Reflection",
                          const SelfReflection(),
                          "SelfReflection",
                        ),
                        createActivity2(
                          context,
                          "meditation",
                          "MEDITATION",
                          "",
                          const Meditation(),
                          "Meditation",
                          zero: 0,
                        ),
                        createActivity2(
                          context,
                          "memes",
                          "Memes",
                          "",
                          const Meme(),
                          "Meme",
                          zero: 0,
                        ),
                      ],
                    ),
                  ),
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
