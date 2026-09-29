import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/styles/custom_text_styles.dart';
import 'package:flutter_architecture/common/widgets/app_bar.dart';
import 'package:flutter_architecture/common/widgets/text_widget.dart';

class FaqView extends StatelessWidget {
  const FaqView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarView(/*title: "Frequently Asked Questions"*/),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            ExpansionTile(
              title: CustomTextField(
                text: "What is Partner App?",
                styleFace: CustomTextStyles.r12,
              ),
              children: <Widget>[
                ListTile(
                  title: CustomTextField(
                    text: """WIOM is a Internet Service Company""",
                    styleFace: CustomTextStyles.r12,
                  ),
                ),
              ],
            ),
            Divider(
              height: 1,
            ),
            // Add more ExpansionTile widgets as needed
          ],
        ),
      ),
    );
  }
}
