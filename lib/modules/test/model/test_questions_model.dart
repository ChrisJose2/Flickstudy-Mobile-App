class TestQuestionsModel {
  List<QuestionsListModel> questionModelList;

  TestQuestionsModel({required this.questionModelList});

  factory TestQuestionsModel.fromJson(Map<String, dynamic>? json) {
    if (json == null || json['data'] == null) {
      return TestQuestionsModel(questionModelList: []);
    }

    var dataList = json['data'] as List?;
    List<QuestionsListModel> dataValueList = (dataList ?? [])
        .map((value) => QuestionsListModel.fromJson(value))
        .toList();

    return TestQuestionsModel(questionModelList: dataValueList);
  }
}

class QuestionsListModel {
  int id;
  String questionCode;
  int testpaperId;
  int marks;
  num negative;
  int sequenceNo;
  int status;
  String created;
  List<QuestionModel> questions;

  QuestionsListModel({
    required this.id,
    required this.questionCode,
    required this.testpaperId,
    required this.marks,
    required this.negative,
    required this.sequenceNo,
    required this.status,
    required this.created,
    required this.questions,
  });

  factory QuestionsListModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return QuestionsListModel(
        id: 0,
        questionCode: '',
        testpaperId: 0,
        marks: 0,
        negative: 0.0,
        sequenceNo: 0,
        status: 0,
        created: '',
        questions: [],
      );
    }

    var questionsList = json['questions'] as List?;
    List<QuestionModel> questions =
        (questionsList ?? []).map((q) => QuestionModel.fromJson(q)).toList();

    return QuestionsListModel(
      id: json['id'] ?? 0,
      questionCode: json['question_code'] ?? '',
      testpaperId: json['testpaper_id'] ?? 0,
      marks: json['marks'] ?? 0,
      negative: json['negative'] ?? 0.0,
      sequenceNo: json['sequence_no'] ?? 0,
      status: json['status'] ?? 0,
      created: json['created'] ?? '',
      questions: questions,
    );
  }
}

class QuestionModel {
  int id;
  int bookmarkId;
  int packageId;
  int courseId;
  int subjectId;
  String groupQueDirections;
  String groupQueText;
  String groupQueImage;
  String groupCode;
  String queCode;
  String questionTitle;
  int questionNumber;
  String questionDescription;
  String option1;
  String option2;
  String option3;
  String option4;
  String option5;
  String hint;
  String answer;
  String answerDescription;
  String answerVideo;
  String answerImage;
  String questionImage;
  String option1Image;
  String option2Image;
  String option3Image;
  String option4Image;
  String option5Image;
  int chapterId;
  int topicId;
  int questionType;
  String classification;
  String complexity;
  int createdBy;
  int status;
  String created;

  QuestionModel({
    required this.id,
    required this.bookmarkId,
    required this.packageId,
    required this.courseId,
    required this.subjectId,
    required this.groupQueDirections,
    required this.groupQueText,
    required this.groupQueImage,
    required this.groupCode,
    required this.queCode,
    required this.questionTitle,
    required this.questionNumber,
    required this.questionDescription,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    required this.option5,
    required this.hint,
    required this.answer,
    required this.answerDescription,
    required this.answerVideo,
    required this.answerImage,
    required this.questionImage,
    required this.option1Image,
    required this.option2Image,
    required this.option3Image,
    required this.option4Image,
    required this.option5Image,
    required this.chapterId,
    required this.topicId,
    required this.questionType,
    required this.classification,
    required this.complexity,
    required this.createdBy,
    required this.status,
    required this.created,
  });

  factory QuestionModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return QuestionModel(
        id: 0,
        bookmarkId: 0,
        packageId: 0,
        courseId: 0,
        subjectId: 0,
        groupQueDirections: '',
        groupQueText: '',
        groupQueImage: '',
        groupCode: '',
        queCode: '',
        questionTitle: '',
        questionNumber: 0,
        questionDescription: '',
        option1: '',
        option2: '',
        option3: '',
        option4: '',
        option5: '',
        hint: '',
        answer: '',
        answerDescription: '',
        answerVideo: '',
        answerImage: '',
        questionImage: '',
        option1Image: '',
        option2Image: '',
        option3Image: '',
        option4Image: '',
        option5Image: '',
        chapterId: 0,
        topicId: 0,
        questionType: 0,
        classification: '',
        complexity: '',
        createdBy: 0,
        status: 0,
        created: '',
      );
    }

    return QuestionModel(
      id: json['id'] ?? 0,
      bookmarkId: json['bookmark_id'] ?? 0,
      packageId: json['package_id'] ?? 0,
      courseId: json['course_id'] ?? 0,
      subjectId: json['subject_id'] ?? 0,
      groupQueDirections: json['group_que_directions'] ?? '',
      groupQueText: json['group_que_text'] ?? '',
      groupQueImage: json['group_que_image'] ?? '',
      groupCode: json['group_code'] ?? '',
      queCode: json['que_code'] ?? '',
      questionTitle: json['question_title'] ?? '',
      questionNumber: json['question_number'] ?? 0,
      questionDescription: json['question_description'] ?? '',
      option1: json['option1'] ?? '',
      option2: json['option2'] ?? '',
      option3: json['option3'] ?? '',
      option4: json['option4'] ?? '',
      option5: json['option5'] ?? '',
      hint: json['hint'] ?? '',
      answer: json['answer'] ?? '',
      answerDescription: json['answer_description'] ?? '',
      answerVideo: json['answer_video'] ?? '',
      answerImage: json['answer_image'] ?? '',
      questionImage: json['question_image'] ?? '',
      option1Image: json['option1_image'] ?? '',
      option2Image: json['option2_image'] ?? '',
      option3Image: json['option3_image'] ?? '',
      option4Image: json['option4_image'] ?? '',
      option5Image: json['option5_image'] ?? '',
      chapterId: json['chapter_id'] ?? 0,
      topicId: json['topic_id'] ?? 0,
      questionType: json['question_type'] ?? 0,
      classification: json['classification'] ?? '',
      complexity: json['complexity'] ?? '',
      createdBy: json['created_by'] ?? 0,
      status: json['status'] ?? 0,
      created: json['created'] ?? '',
    );
  }
}

class QuestionType {
  static const int MULTIPLE_CHOICE = 1;
  static const int FILL_IN_THE_BLANK = 2;
  static const int MATCH_THE_FOLLOWING = 3;
  static const int COMPREHENSION = 4;
}
