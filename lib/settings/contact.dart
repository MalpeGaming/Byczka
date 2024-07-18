import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:brain_train_app/app_bar.dart';

class Contact extends StatefulWidget {
  final bool? initialTest;
  const Contact({this.initialTest = false, super.key});

  @override
  State<Contact> createState() => _Contact();
}

class _Contact extends State<Contact> {
  bool initialTest = false;

  @override
  void initState() {
    super.initState();
    initialTest = widget.initialTest!;
    print(initialTest);
  }

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
              data: '''E-Mail Address: **appbraintrain@gmail.com**

Phone Number: **+48 577 568 833**

On Facebook: **The Brain Train App**

&nbsp;
## Contact the leader.

E-Mail Address: **siodawera@gmail.com**

Phone Number: **+48 577 568 833**

On Facebook: **Weronika Sioda**


''',
            ),
          ],
        ),
      ),
    );
  }
}
