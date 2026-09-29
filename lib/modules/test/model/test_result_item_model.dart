class TestResultItemModel {
  int totalMarksObtained = 0;
  int attemptedQuestions = 0;
  int totalQuestions = 0;
  int correctQuestions = 0;
  int incorrectQuestions = 0;
  String startTime = '';
  String endTime = '';
  double totalTimeTaken = 0.0;
  double speedQuestionsPerMin = 0.0;
  int accuracy = 0;
  int totalMarks = 0;
  Section section = Section();
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

    //Implement null check on all below

    totalMarksObtained = json['total_marks_obtained'] ?? 0;
    attemptedQuestions = json['attempted_questions'] ?? 0;
    totalQuestions = json['total_questions'] ?? 0;
    totalMarks = json['total_questions'] ?? 0;
    correctQuestions = json['correct_questions'] ?? 0;
    incorrectQuestions = json['incorrect_questions'] ?? 0;

    startTime = json['start_time'] ?? '';
    endTime = json['end_time'] ?? '';
    totalTimeTaken = json['total_time_taken'] ?? 0.0;
    speedQuestionsPerMin = json['speed_questions_per_min'] != null
        ? double.parse(json['speed_questions_per_min'].toString())
        : 0.0;
    accuracy = json['accuracy'] ?? 0;

    if (json['section'] != null) {
      section.fromJson(json['section']);
    } else {
      section.fromJson(json);
    }
  }
}

class Section {
  //"section": {
  // "total_questions": 11,
  // "answered_questions": 4,
  // "percent_answered": 36.36363636363637,
  // "avg_time_spent_per_question": 0,
  // "correct_answers": 0,
  // "incorrect_answers": 4,
  // "total_time_spent": 0,
  // "accuracy": 0,
  // "marks_obtained": 0
  // }

  int total_questions = 0;
  int answered_questions = 0;
  double percent_answered = 0;
  double avg_time_spent_per_question = 0;
  int correct_answers = 0;
  int incorrect_answers = 0;
  double total_time_spent = 0;
  int accuracy = 0;
  int marks_obtained = 0;

  fromJson(Map<String, dynamic> json) {
    total_questions = json['total_questions'] ?? 0;
    answered_questions = json['answered_questions'] ?? 0;
    percent_answered = json['percent_answered'] != null
        ? double.parse(json['percent_answered'].toString())
        : 0;
    avg_time_spent_per_question = json['avg_time_spent_per_question'] != null
        ? double.parse(json['avg_time_spent_per_question'].toString())
        : 0;
    correct_answers = json['correct_answers'] != null
        ? double.parse(json['correct_answers'].toString()).toInt()
        : 0;
    incorrect_answers = json['incorrect_answers'] ?? 0;
    total_time_spent = json['total_time_spent'] != null
        ? double.parse(json['total_time_spent'].toString())
        : 0;
    accuracy =
        json['accuracy'] != null ? int.parse(json['accuracy'].toString()) : 0;
    marks_obtained = json['marks_obtained'] ?? 0;
  }
}
