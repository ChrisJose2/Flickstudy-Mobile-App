import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/routing/app_routes.dart';
import 'package:flutter_architecture/common/widgets/app_bar_v2.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swipe_cards/swipe_cards.dart';

class BigPictureView extends StatelessWidget {
  const BigPictureView({Key? key}) : super(key: key);

  // bool assessmentSelected = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.home, (Route<dynamic> route) => false);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarViewV2(
          title: "Big Picture",
        ),
        body: Column(
          children: [
            // SizedBox(
            //   height: 20,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     Column(
            //       children: [
            //         CustomTextField(
            //           text: "Assessment Completed",
            //           styleFace: CustomTextStyles.thickb14,
            //         ),
            //         assessmentSelected
            //             ? SizedBox(
            //                 height: 5,
            //               )
            //             : Container(),
            //         assessmentSelected
            //             ? Container(
            //                 width: 200,
            //                 height: 2,
            //                 color: AppColors.primary,
            //               )
            //             : Container()
            //       ],
            //     ),
            //     Column(
            //       children: [
            //         CustomTextField(
            //             text: "Chapter Completed",
            //             styleFace: CustomTextStyles.thickb14),
            //         !assessmentSelected
            //             ? SizedBox(
            //                 height: 5,
            //               )
            //             : Container(),
            //         !assessmentSelected
            //             ? Container(
            //                 width: 200,
            //                 height: 2,
            //                 color: AppColors.primary,
            //               )
            //             : Container()
            //       ],
            //     ),
            //   ],
            // ),
            Expanded(child: SwipeableProgressCards()),
          ],
        ),
      ),
    );
  }
}

class SwipeableProgressCards extends StatefulWidget {
  @override
  _SwipeableProgressCardsState createState() => _SwipeableProgressCardsState();
}

class _SwipeableProgressCardsState extends State<SwipeableProgressCards> {
  late List<SwipeItem> _swipeItems;
  late MatchEngine _matchEngine;

  List<Map<String, dynamic>> subjects = [
    {"name": "Subject 1", "progress": 0.5},
    {"name": "Subject 2", "progress": 0.75},
    {"name": "Subject 3", "progress": 0.3},
  ];

  @override
  void initState() {
    super.initState();
    _swipeItems = subjects.map((subject) {
      return SwipeItem(
        content: ProgressCard(
          subject: subject['name'],
          progress: subject['progress'],
        ),
      );
    }).toList();

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20),
        child: SwipeCards(
          matchEngine: _matchEngine,
          itemBuilder: (BuildContext context, int index) {
            return _swipeItems[index].content;
          },
          onStackFinished: () {
            //restart
            setState(() {
              _matchEngine = MatchEngine(swipeItems: _swipeItems);
            });
            Fluttertoast.showToast(msg: "No more cards");
          },
          upSwipeAllowed: false,
          fillSpace: true,
        ),
      ),
    );
  }
}

class ProgressCard extends StatelessWidget {
  final String subject;
  final double progress;

  ProgressCard({required this.subject, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            subject,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          CustomPaint(
            size: Size(300, 250),
            painter: CircularGraphPainter(progress),
          ),
          SizedBox(height: 20),
          Text(
            'Completed ${(progress * 100).toInt()}%',
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class CircularGraphPainter extends CustomPainter {
  final double progress;

  CircularGraphPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    Paint baseCircle = Paint()
      ..strokeWidth = 30
      ..color = Colors.grey.withOpacity(0.3)
      ..style = PaintingStyle.stroke;

    Paint progressArc = Paint()
      ..strokeWidth = 40
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 3, size.height / 3);

    // Draw base circle
    canvas.drawCircle(center, radius, baseCircle);

    // Draw progress arc
    double arcAngle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // Start angle
      arcAngle, // Sweep angle
      false,
      progressArc,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
