import 'package:flutter/material.dart';
import 'main.dart';

AppBar appBar(BuildContext context, String title, {bool canReturn = true}) {
  Size size = MediaQuery.of(context).size;
  return AppBar(
    surfaceTintColor: Theme.of(context).colorScheme.background,
    backgroundColor: Theme.of(context).colorScheme.background,
    leading: canReturn
        ? IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        : null,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: size.width / 16),
        ),
        ElevatedButton(
          onPressed: () {
            MyApp.of(context).switchTheme();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.background,
            foregroundColor: Colors.yellow,
          ),
          child: const Icon(
            Icons.wb_sunny_outlined,
          ),
        ),
      ],
    ),
  );
}
