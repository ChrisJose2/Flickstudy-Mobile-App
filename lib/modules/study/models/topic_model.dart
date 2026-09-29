class TopicModel {
  List<Topic> topicList;

  TopicModel({required this.topicList});

  factory TopicModel.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<Topic> dataValueList =
        dataList.map((value) => Topic.fromJson(value)).toList();

    return TopicModel(topicList: dataValueList);
  }
}

class Topic {
  int id;
  int days;
  int createdBy;
  int status;
  String created;
  String topicTitle;
  String topicDescription;
  int chapterId;
  int sNo;
  List<Lessons>? lessons;
  String type;
  bool isCompleted = false;

  Topic({
    required this.id,
    required this.days,
    required this.createdBy,
    required this.status,
    required this.created,
    required this.topicTitle,
    required this.topicDescription,
    required this.chapterId,
    required this.sNo,
    required this.lessons,
    required this.type,
    required this.isCompleted,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    List<Lessons>? lessonsValueList;
    if (json['lessons'] != null) {
      var lessonsList = json['lessons'] as List;
      lessonsValueList =
          lessonsList.map((value) => Lessons.fromJson(value)).toList();
    }
    return Topic(
      id: json['id'],
      days: json['days'],
      createdBy: json['created_by'],
      status: json['status'],
      created: json['created'],
      topicTitle: json['topic_title'],
      topicDescription: json['topic_description'],
      chapterId: json['chapter_id'],
      sNo: json['s_no'],
      lessons: lessonsValueList,
      type: "topic",
      isCompleted: json['id'] % 2 == 0 ? true : false,
    );
  }
}

class Lessons {
  int id;
  int sNo;
  String lessonTitle;
  int chapterTopicId;
  String lessonDescription;
  int type;
  int refrenceId;
  int categoryId;
  int createdBy;
  int status;
  String created;
  String videoUrl;
  String image;
  String videoLandscape;
  String classSummaryPdf;
  String classDescription;
  String classType;

  Lessons({
    required this.id,
    required this.sNo,
    required this.lessonTitle,
    required this.chapterTopicId,
    required this.lessonDescription,
    required this.type,
    required this.refrenceId,
    required this.categoryId,
    required this.createdBy,
    required this.status,
    required this.created,
    required this.videoUrl,
    required this.image,
    required this.videoLandscape,
    required this.classSummaryPdf,
    required this.classDescription,
    required this.classType,
  });

  factory Lessons.fromJson(Map<String, dynamic> json) {
    return Lessons(
      id: json['id'],
      sNo: json['s_no'],
      lessonTitle: json['lesson_title'],
      chapterTopicId: json['chapter_topic_id'],
      lessonDescription: json['lesson_description'],
      type: json['type'],
      refrenceId: json['refrence_id'],
      categoryId: json['category_id'],
      createdBy: json['created_by'],
      status: json['status'],
      created: json['created'],
      videoUrl: json['video_url'] ?? "",
      image: json['image'] ?? "",
      videoLandscape: json['video_landscape'] ?? "",
      classSummaryPdf: json['class_summary_pdf'] ?? "",
      classDescription: json['class_description'] ?? "",
      classType: json['class_type'] ?? "1",
    );
  }
}
