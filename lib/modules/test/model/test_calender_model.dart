class TestCalenderModel {
  List<TestData> testData;

  TestCalenderModel({required this.testData});

  factory TestCalenderModel.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<TestData> dataValueList =
        dataList.map((value) => TestData.fromJson(value)).toList();

    return TestCalenderModel(testData: dataValueList);
  }
}

class TestData {
  int id;
  String code;
  String testpaperTitle;
  int categoryId;
  String testpaperInstructions;
  int type;
  int subjectId;
  int? chapterId;
  int? topicId;
  int courseId;
  int totalTime;
  int status;
  int createdBy;
  String created;
  int days;

  TestData({
    required this.id,
    required this.code,
    required this.testpaperTitle,
    required this.categoryId,
    required this.testpaperInstructions,
    required this.type,
    required this.subjectId,
    required this.chapterId,
    required this.topicId,
    required this.courseId,
    required this.totalTime,
    required this.status,
    required this.createdBy,
    required this.created,
    required this.days,
  });

  factory TestData.fromJson(Map<String, dynamic> json) {
    return TestData(
      id: json['id'],
      code: json['code'],
      testpaperTitle: json['testpaper_title'],
      categoryId: json['category_id'],
      testpaperInstructions: json['testpaper_instructions'],
      type: json['type'],
      subjectId: json['subject_id'],
      chapterId: json['chapter_id'],
      topicId: json['topic_id'],
      courseId: json['course_id'],
      totalTime: json['total_time'],
      status: json['status'],
      createdBy: json['created_by'],
      created: json['created'],
      days: json['days'],
    );
  }
}
