import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/widgets/app_bar.dart';

import '../../../common/styles/custom_text_styles.dart';
import '../../../common/widgets/text_widget.dart';

class NotificationListView extends StatelessWidget {
  const NotificationListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarView(/*title: "Notifications"*/),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                leading: Icon(Icons.notifications),
                title: Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: CustomTextField(
                        text: 'Notification Title',
                        upperCase: false,
                        styleFace: CustomTextStyles.r12)),
                subtitle: Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: CustomTextField(
                      text: '27 Mar 2023 9:30 PM',
                      styleFace: CustomTextStyles.r11.subtitle,
                      upperCase: false,
                    )),
              ),
              if (index != 9) Divider(),
            ],
          );
        },
      ),
    );
  }
}
