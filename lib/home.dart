import 'dart:async';
import 'package:brain_train_app/widgets/port_home_tasks_widget.dart';
import 'package:brain_train_app/widgets/port_home_tasks_widget_config.dart';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:circular_chart_flutter/circular_chart_flutter.dart';
import 'package:intl/intl.dart';
import 'navbar.dart';
import 'activities_for_each_section.dart';
import 'dart:math';
import 'score_n_progress/finish_screen.dart';
import '/memory/faces.dart';
import 'package:brain_train_app/notification.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  late SharedPreferences prefs;
  String skill = "";
  int trainingTime = 0;
  var rng = Random();
  List<String> plan = [];
  List<String> basePlanTicked = ["0", "0", "0", "0"];
  int day = 1;
  List<bool> wellBeingTicked = [false, false, false, false];
  int points = 0;
  int procent = 0;
  int strikeDays = 0;

  Future<void> initStrikeCounter() async {
    @override
    initState() {
      super.initState();
      initStrikeCounter(); // Dodaj tę linię
      readMemory();
    }

    final prefs = await SharedPreferences.getInstance();
    final currentDate = DateTime.now();
    final lastOpenDate =
        DateTime.tryParse(prefs.getString('last_open_date') ?? '');

    // Jeśli aplikacja jest otwierana po raz pierwszy
    if (lastOpenDate == null) {
      await prefs.setInt('strike_days', 1);
      await prefs.setString('last_open_date', currentDate.toIso8601String());
      setState(() {
        strikeDays = 1;
      });
    } else {
      final difference = currentDate.difference(lastOpenDate).inDays;
      if (difference == 1) {
        // Zwiększ licznik dni o 1
        strikeDays = prefs.getInt('strike_days') ?? 0;
        strikeDays++;
        await prefs.setInt('strike_days', strikeDays);
      } else if (difference > 1) {
        // Resetuje licznik, jeśli była przerwa
        strikeDays = 1;
        await prefs.setInt('strike_days', 1);
      }
      await prefs.setString('last_open_date', currentDate.toIso8601String());
      setState(() {});
    }
  }

  GlobalKey<AnimatedCircularChartState> key =
      GlobalKey<AnimatedCircularChartState>();

  double summ = 100.0;
  double value = 40.0;
  double value2 = 60.0;
  double value3 = 00.0;
  double value32 = 50.0;

  void calcValues() {
    setState(() {
      procent = int.parse((points / trainingTime * 100).toStringAsFixed(0));
      if (procent >= 200) {
        value = 100;
        value2 = 0;
        value3 = 100;
      } else {
        value = min(procent.toDouble(), 100);
        value2 = 100 - value;
        value3 = (procent > 100) ? procent % 100 : 0;
      }
      List<CircularStackEntry> data = _generateChartData();
      key.currentState!.updateData(data);
    });
  }

  Future<void> calcDay() async {
    DateTime firstDay = DateTime.now();
    DateTime today = DateTime.now();
    prefs = await SharedPreferences.getInstance();
    if (prefs.getString('beginning_date') != null) {
      firstDay = DateTime.parse(prefs.getString('beginning_date')!);
    }

    setState(() {
      day = today.difference(firstDay).inDays + 1;
    });
  }

  Future<void> setWellBeingTicked() async {
    prefs = await SharedPreferences.getInstance();

    List<String> newWellBeingTickedString = ["0", "0", "0", "0"];

    for (int i = 0; i < wellBeingTicked.length; i++) {
      newWellBeingTickedString[i] = (wellBeingTicked[i] ? "1" : "0");
    }
    prefs.setStringList("wellBeingTickedDay$day", newWellBeingTickedString);
  }

  Future<void> getWellBeingTicked() async {
    prefs = await SharedPreferences.getInstance();

    int newPoints = points;

    List<String> newWellBeingTickedString =
        prefs.getStringList('wellBeingTickedDay$day') ?? [];
    List<bool> newWellBeingTicked = [false, false, false, false];

    for (int i = 0; i < newWellBeingTickedString.length; i++) {
      newWellBeingTicked[i] =
          (newWellBeingTickedString[i] == "1" ? true : false);
      if (newWellBeingTicked[i]) {
        newPoints += wellbeingTimes[wellbeing[i]]!;
      }
    }
    if (newWellBeingTicked.isEmpty) {
      newWellBeingTicked = [false, false, false, false];
    }

    setState(() {
      wellBeingTicked = newWellBeingTicked;
      points = newPoints;
    });
  }

  var skillBaseList = [
    [Faces, "Faces", 10],
  ];

  Future<void> getSkill() async {
    prefs = await SharedPreferences.getInstance();
    String newSkill = prefs.getString('skill')!;
    int newTrainingTime = prefs.getInt('training_time')!;

    setState(() {
      skill = newSkill;
      trainingTime = newTrainingTime;
    });
  }

  Future<void> createPlan() async {
    prefs = await SharedPreferences.getInstance();
    List<String> newPlan = prefs.getStringList("basePlanDay$day") ?? [];
    print("poczatek newPlan: $newPlan");
    if (newPlan.isNotEmpty) {
      setState(() {
        plan = newPlan;
      });
      return;
    }
    skillBaseList = List.from(skillBaseLists[skill]!);
    print("skillBaseList: $skillBaseList");
    int currentTime = 0;

    if (skill == 'linguistic') {
      int x = rng.nextInt(4);
      if (x == 0) {
        int el = 2;
        newPlan.add(skillBaseList[el].toList()[1].toString());
        currentTime += skillBaseList[el].toList()[2] as int;
        skillBaseList.removeAt(el);
      } else if (x == 1) {
        int el = 3;
        newPlan.add(skillBaseList[el].toList()[1].toString());
        currentTime += skillBaseList[el].toList()[2] as int;
        skillBaseList.removeAt(el);
      }
    }

    while (currentTime < trainingTime) {
      int el = rng.nextInt(skillBaseList.length);
      newPlan.add(skillBaseList[el].toList()[1].toString());
      currentTime += skillBaseList[el].toList()[2] as int;
      skillBaseList.removeAt(el);
    }
    print("newPlan: $newPlan");
    prefs.setStringList("basePlanDay$day", newPlan);
    setState(() {
      plan = newPlan;
    });
  }

  Future<void> getBasePlanTicked() async {
    prefs = await SharedPreferences.getInstance();
    List<String> newBasePlanTicked = ["0", "0", "0", "0"];
    int newPoints = points;

    for (int i = 0; i < plan.length; ++i) {
      newBasePlanTicked[i] = prefs.getString("${plan[i]}TickedDay$day") ?? "0";
      if (newBasePlanTicked[i] == "1") {
        newPoints += sectionTimes[plan[i]]!;
      }
    }
    setState(() {
      basePlanTicked = newBasePlanTicked;
      points = newPoints;
      calcValues();
    });
  }

  void getPoints() {
    int newPoints = points;
    for (int i = 0; i < wellBeingTicked.length; ++i) {
      if (wellBeingTicked[i]) newPoints += wellbeingTimes[wellbeing[1]]!;
    }
    setState(() {
      points = newPoints;
      calcValues();
    });
  }

  Future<void> readMemory() async {
    await calcDay().then((_) {
      print("day: $day");
      if (day >= 30) {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Finish(),
          ),
        );
      }
    });
    await getSkill();
    await getWellBeingTicked();
    await createPlan();
    await getBasePlanTicked();
  }

  @override
  initState() {
    NotificationService.showInstantNotification(
        "testt", "bdedsrwrts t g ert t");
    print("INIT");
    DateTime selectedTime =
        DateTime.now().add(Duration(seconds: 10)); // For testing purposes
    NotificationService.scheduleNotification(
        0, "ASD", "TEstbody", selectedTime);

    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      PortHomeTasksWidgetConfig.initialize().then((value) async {
        callHomeWidgetUpdate();
      });
    });
    super.initState();
    readMemory();
  }

  Future<void> updatePoints() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt("pointsDay$day", points);
  }

  Widget createBaseProgram(
    BuildContext context,
  ) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        for (int i = 0; i < plan.length; i++)
          Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: size.width / 15,
                    child: Icon(
                      (basePlanTicked[i] == "1")
                          ? Icons.done_all
                          : Icons.done_rounded,
                      size: basePlanTicked[i] == "1"
                          ? size.width / 12
                          : size.width / 15,
                      color: basePlanTicked[i] == "1"
                          ? Colors.green
                          : Theme.of(context)
                              .colorScheme
                              .onSecondary
                              .withOpacity(0.3),
                    ),
                  ),
                  SizedBox(width: size.width / 40),
                  Flexible(
                    child: Text(
                      "${sectionNames[plan[i]]} - ${sectionTimes[plan[i]]} min",
                      style: TextStyle(
                        fontSize: size.width / 22,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 0.01 * size.height),
            ],
          ),
      ],
    );
  }

  void callHomeWidgetUpdate() {
    List<String> widgetItems = [];
    for (int i = 0; i < plan.length; i++) {
      widgetItems.add(
          "${basePlanTicked[i] == "1" ? "◉" : "○"}:${sectionNames[plan[i]]}");
      print(
          "plan[$i] ${plan[i]} ${sectionNames[plan[i]]} ${basePlanTicked[i]}");
    }

    HomeWidget.saveWidgetData("plan_title", "To - Do List");
    HomeWidget.saveWidgetData("plan_tasks", widgetItems.join(','));
    //HomeWidget.saveWidgetData("plan_tasks", "○:sudoku,◉:traintest");
    HomeWidget.updateWidget(
      androidName: "TodoHomeScreenWidget",
    );

    PortHomeTasksWidgetConfig.update(
      context,
      PortHomeTasksWidget(
        plan: plan,
        basePlanTicked: basePlanTicked,
        sectionNames: sectionNames,
      ),
    );
  }

  Widget createWellBeing(
    BuildContext context,
  ) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      child: Column(
        children: [
          for (int i = 0; i < wellbeing.length; i++)
            InkWell(
              onTap: () {
                setState(() {
                  wellBeingTicked[i] = !wellBeingTicked[i];
                  if (wellBeingTicked[i]) {
                    points += wellbeingTimes[wellbeing[i]]!;
                  } else {
                    points -= wellbeingTimes[wellbeing[i]]!;
                  }
                  calcValues();
                });
                setWellBeingTicked();
                updatePoints();
              },
              child: Column(
                children: [
                  SizedBox(
                    height: size.width / 15,
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width / 12,
                          child: Icon(
                            wellBeingTicked[i]
                                ? Icons.done_all_rounded
                                : Icons.done_rounded,
                            size: wellBeingTicked[i]
                                ? size.width / 12
                                : size.width / 15,
                            color: wellBeingTicked[i]
                                ? Colors.green
                                : Theme.of(context)
                                    .colorScheme
                                    .onSecondary
                                    .withOpacity(0.3),
                          ),
                        ),
                        SizedBox(width: size.width / 40),
                        Flexible(
                          child: Text(
                            wellbeing[i],
                            style: TextStyle(
                              fontSize: size.width / 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 0.01 * size.height),
                ],
              ),
            ),
        ],
      ),
    );
  }

  List<CircularStackEntry> _generateChartData() {
    Color? dialColor = Theme.of(context).colorScheme.onPrimary;
    Color? dialColor2 =
        Theme.of(context).colorScheme.onPrimary.withOpacity(0.2);
    Color? dialColor3 = (Theme.of(context).brightness == Brightness.light)
        ? const Color.fromARGB(255, 255, 136, 255)
        : const Color.fromARGB(255, 211, 54, 198);

    List<CircularStackEntry> data = <CircularStackEntry>[
      CircularStackEntry(
        <CircularSegmentEntry>[
          CircularSegmentEntry(
            value3,
            dialColor3,
            rankKey: 'percentage3',
          ),
          CircularSegmentEntry(
            value,
            dialColor,
            rankKey: 'percentage1',
          ),
          CircularSegmentEntry(
            value2,
            dialColor2,
            rankKey: 'percentage4',
          ),
        ],
        rankKey: 'percentage4',
      ),
    ];
    return data;
  }

  SizedBox buildChart(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width / 3,
      height: size.width / 3,
      child: AnimatedCircularChart(
        key: key,
        size: Size(size.width / 2, size.width / 2),
        initialChartData: _generateChartData(),
        holeRadius: size.width / 30,
        chartType: CircularChartType.Radial,
        edgeStyle: SegmentEdgeStyle.round,
        percentageValues: true,
        holeLabel: '$procent%',
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.3),
          fontWeight: FontWeight.bold,
          fontSize: size.width / 20,
        ),
      ),
    );
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
          left: size.width / 10,
          right: size.width / 10,
          top: size.height / 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  
                  Center(
                    child: Text(
                      "-Broin Plan-",
                      style: TextStyle(
                        fontSize: size.width / 8,
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
                ],
              ),
              Container(
                padding: EdgeInsets.all(8.0), // Dodaj margines wewnętrzny
                decoration: BoxDecoration(
                  color: Colors.green, // Ustaw kolor tła na zielony
                  borderRadius: BorderRadius.circular(12.0), // Zaokrąglij rogi
                ),
                child: Text(
                  "Strike Days: $strikeDays", // Dodaj zmienną strikeDays
                  style: TextStyle(
                    fontSize: size.width / 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white, // Ustaw kolor tekstu na biały
                  ),
                ),
              ),
              SizedBox(height: 0.05 * size.height),
              Text(
                "Base program",
                style: TextStyle(
                  fontSize: size.width / 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 0.01 * size.height),
              createBaseProgram(context),
              SizedBox(height: size.height / 40),
              Text(
                "Well-Being Section",
                style: TextStyle(
                  fontSize: size.width / 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 0.01 * size.height),
              createWellBeing(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Text(
                        "Your points today",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width / 25,
                        ),
                      ),
                      const Text("(calculaterd based\non the time spent)"),
                    ],
                  ),
                  SizedBox(width: 0.01 * size.width),
                  buildChart(context),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
