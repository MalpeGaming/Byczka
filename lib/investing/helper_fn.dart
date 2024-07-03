import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:widget_zoom/widget_zoom.dart';
import '../buttons.dart';

Widget keyVocabulary(BuildContext context, String text, String definition) {
  Size size = MediaQuery.of(context).size;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text,
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.height * 0.020,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: size.height / 200,
      ),
      Text(
        definition,
        style: TextStyle(
          fontSize: size.height * 0.020,
        ),
      ),
    ],
  );
}

Widget zoomImage(BuildContext context, String image, {double? w, double? h}) {
  return WidgetZoom(
    heroAnimationTag: image.toString(),
    zoomWidget: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(5, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          image,
          width: w,
          height: h,
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}

Column createExercise(
  BuildContext context,
  int questionNumber,
  String question,
  List<String> answers,
  String? image,
  Widget? imageWidget,
  Function createListTitle,
  String? explanation,
) {
  Size size = MediaQuery.of(context).size;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Exercise ${questionNumber + 1}.",
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 0.02 * size.height,
        ),
      ),
      Text(
        question,
        style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.020),
      ),
      if (image != null)
        SizedBox(height: MediaQuery.of(context).size.height / 30),
      if (image != null) zoomImage(context, image),
      if (imageWidget != null) imageWidget,
      SizedBox(height: MediaQuery.of(context).size.height / 70),
      Column(
        children: List.generate(answers.length, (index) {
          return Container(
            child: createListTitle(index, answers[index], size),
          );
        }),
      ),
      explanation != null
          ? Column(
              children: [
                SizedBox(height: size.height / 40),
                Text(explanation),
              ],
            )
          : const SizedBox.shrink(),
    ],
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

Widget createDivider(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Column(
    children: [
      SizedBox(height: size.height / 20),
      Divider(
        color: Theme.of(context).colorScheme.primary,
        thickness: size.height / 200,
      ),
      SizedBox(height: size.height / 20),
    ],
  );
}

Future<void> saveResult(int lessonId, int score) async {
  late SharedPreferences prefs;

  prefs = await SharedPreferences.getInstance();
  int x = prefs.getInt('lesson$lessonId')?.toInt() ?? 0;
  if (score < x) {
    score = x;
  }
  prefs.setInt('lesson$lessonId', score);
  //print("amogus");
}

Widget subpoint(BuildContext context, String text, String definition) {
  Size size = MediaQuery.of(context).size;
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(
          top: 0.05 * size.width,
          bottom: 0.05 * size.width,
          right: 0.05 * size.width,
        ),
        child: Icon(
          Icons.circle,
          size: 0.02 * size.width,
        ),
      ),
      SizedBox(
        width: 0.7 * size.width,
        child: keyVocabulary(context, text, definition),
      ),
    ],
  );
}

Container createRecipe(
  BuildContext context,
  int qIndx,
  int index,
  List<List<String>> images, {
  double h = 0.9,
}) {
  Size size = MediaQuery.of(context).size;

  return Container(
    height: h * size.height,
    width: h * size.width,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
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
    margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
    child: Padding(
      padding: EdgeInsets.all(size.width / 30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: zoomImage(
          context,
          images[qIndx][index],
          //w: 0.2 * size.width,
          //h: 0.2 * size.width,
        ),
      ),
    ),
    //),
  );
}

class Success extends StatefulWidget {
  final Widget route;
  final int number;
  final String subject;
  final int minutes;
  final int score;
  final int maxscore;

  const Success(
    this.number,
    this.subject,
    this.minutes,
    this.score,
    this.maxscore,
    this.route, {
    super.key,
  });
  double get percentage => score / maxscore;
  final int scoreoverall = 60;
  final int maxscoreoverall = 69;
  double get percentageoverall => scoreoverall / maxscoreoverall;
  @override
  State<Success> createState() => _Success();
}

class _Success extends State<Success> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //print(widget.minutes.toString());
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/investing/success_background.gif"),
            fit: BoxFit.cover,
            opacity: 0.4,
          ),
        ),
        child: Align(
          child: Container(
            margin: EdgeInsets.only(
              left: size.width / 10,
              right: size.width / 10,
              bottom: size.height / 10,
              top: size.height / 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 0.05 * size.height),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "CONGRATS",
                    style: TextStyle(fontSize: 0.05 * size.height),
                  ),
                ),
                SizedBox(height: 0.03 * size.height),
                Text(
                  "Lesson ${widget.number.toString()}",
                  style: TextStyle(fontSize: 0.025 * size.height),
                ),
                Text(
                  widget.subject,
                  style: TextStyle(
                    fontSize: 0.025 * size.height,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 0.04 * size.height),

                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 0.025 * size.height,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    children: [
                      const TextSpan(
                        text: "Time Taken: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "${widget.minutes.toString()} minutes",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 0.04 * size.height),

                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 0.025 * size.height,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    children: [
                      const TextSpan(
                        text: "Points: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text:
                            "${widget.score.toString()} / ${widget.maxscore.toString()}",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 0.005 * size.height),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 0.025 * size.height,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    children: [
                      const TextSpan(
                        text: "Percentage Score: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text:
                            "${(widget.percentage * 100).toStringAsFixed(0)}%",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 0.01 * size.height),
                LinearProgressIndicator(
                  value: widget.percentage,
                  backgroundColor: const Color.fromRGBO(135, 136, 226, 1),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color.fromRGBO(94, 23, 235, 1),
                  ),
                  minHeight: 0.025 * size.height,
                  borderRadius: BorderRadius.circular(21312127),
                ),
                SizedBox(height: 0.025 * size.height),

                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 0.025 * size.height,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    children: [
                      const TextSpan(
                        text: "Overall Points: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text:
                            "${widget.scoreoverall.toString()} / ${widget.maxscoreoverall.toString()}",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 0.005 * size.height),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 0.025 * size.height,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    children: [
                      const TextSpan(
                        text: "Percentage Score Overall: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text:
                            "${(widget.percentageoverall * 100).toStringAsFixed(0)}%",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 0.01 * size.height),
                LinearProgressIndicator(
                  value: widget.percentageoverall,
                  backgroundColor: const Color.fromRGBO(135, 136, 226, 1),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color.fromRGBO(94, 23, 235, 1),
                  ),
                  minHeight: 0.025 * size.height,
                  borderRadius: BorderRadius.circular(21312127),
                ),
                const Spacer(),

                Center(
                  child: SizedBox(
                    height: size.height * 0.05,
                    width: size.width * 0.75,
                    child: RedirectButton(
                      route: widget.route,
                      text: 'Next Class',
                      width: size.width,
                    ),
                  ),
                ),
                //SizedBox(height: 0.1 * size.height),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
