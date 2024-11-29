import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:brain_train_app/app_bar.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _Contact();
}

class _Contact extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context, ""),
      body: Container(
        margin: EdgeInsets.only(
          left: size.width / 7,
          right: size.width / 7,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Contact Us",
                style: TextStyle(
                  fontSize: size.width / 10,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 0.035 * size.height),
            const MarkdownBody(
              data: '''E-Mail Address: **taccout7@gmail.com**




''',
            ),
          ],
        ),
      ),
    );
  }
}
