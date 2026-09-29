import 'package:flutter_architecture/modules/test/model/test_result_item_model.dart';

class TestResultModel {
  List<SubjectModel> subjects = [];
  TestResultItemModel testResultItemModel = TestResultItemModel();
  fromJson(Map<String, dynamic> json) {
    //{
    // "total_marks_obtained": 0,
    // "attempted_questions": 4,
    // "total_questions": 4,
    // "correct_questions": 0,
    // "incorrect_questions": 4,
    // "start_time": "2025-02-19T07:12:42.000Z",
    // "end_time": "2025-02-19T07:12:48.000Z",
    // "subjects": [
    // {
    // "subject_name": "Quantititive",
    // "total_marks_obtained": 0,
    // "attempted_questions": 4,
    // "total_questions": 4,
    // "correct_questions": 0,
    // "incorrect_questions": 4,
    // "speed_questions_per_min": 40,
    // "accuracy": 0
    // }
    // ],
    // "total_time_taken": 0.1,
    // "speed_questions_per_min": 40,
    // "accuracy": 0
    // }

    testResultItemModel.fromJson(json);
    //json['subjects'] is an array parse it accordingly
    if (json['subjects'] != null) {
      json['subjects'].forEach((v) {
        SubjectModel subject = SubjectModel();
        subject.fromJson(v);
        subjects.add(subject);
      });
    }
  }
}

class SubjectModel {
  String subject_name = '';
  Section section = Section();
  TestResultItemModel testResultItemModel = TestResultItemModel();
  SubjectModel();
  fromParent(String name, TestResultItemModel testResultItemModel) {
    this.subject_name = name;
    this.testResultItemModel = testResultItemModel;
    this.section = testResultItemModel.section;
  }

  fromJson(Map<String, dynamic> json) {
    //{
    // "subject_name": "Quantititive",
    // "total_marks_obtained": 0,
    // "attempted_questions": 4,
    // "total_questions": 4,
    // "correct_questions": 0,
    // "incorrect_questions": 4,
    // "speed_questions_per_min": 40,
    // "accuracy": 0
    // }

    subject_name = json['subject_name'];
    testResultItemModel.fromJson(json);
    section.fromJson(json['section']);
  }
}
