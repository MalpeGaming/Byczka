import 'package:flutter/material.dart';
import '/navbar.dart';
import '/your_activities.dart';
import 'bmi.dart';
import 'cal_requirements_calc.dart';
import 'brain_supplements.dart';
import 'food_table.dart';
import 'recipes.dart';

class NutritionTips extends StatefulWidget {
  const NutritionTips({super.key});

  @override
  State<NutritionTips> createState() => _NutritionTips();
}

class _NutritionTips extends State<NutritionTips> {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 0.08 * size.height),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      "Nutrition",
                      style: TextStyle(
                        fontSize: size.width / 7,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Center(
                    child: Text(
                      "-Tips by Broin-",
                      style: TextStyle(fontSize: size.width / 17),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 0.05 * size.height),
              createActivity(
                context,
                "diet/bmi",
                "Calculate your BMI.",
                "",
                0.025 * size.height,
                const BMI(),
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.onPrimary,
                zero: 0,
              ),
              createActivity(
                context,
                "diet/calorie_req",
                "Estimate Calories Requirements.",
                "",
                0.025 * size.height,
                const CalRequirementsCalc(),
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.onPrimary,
                zero: 0,
              ),
              createActivity(
                context,
                "diet/supplements",
                "Supplements for your brain",
                "",
                0.023 * size.height,
                const BrainSupplements(),
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.onPrimary,
                zero: 0,
              ),
              createActivity(
                context,
                "diet/should_avoid",
                "What should you eat?",
                "",
                0.025 * size.height,
                const FoodTable(),
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.onPrimary,
                zero: 0,
              ),
              createActivity(
                context,
                "diet/recipes",
                "5 Brain recipes",
                "",
                0.025 * size.height,
                const Recipes(),
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.onPrimary,
                zero: 0,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
