class SubjectSessionModel {
  List<SubjectSessionItem> sessionItemList;

  SubjectSessionModel({required this.sessionItemList});

  factory SubjectSessionModel.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<SubjectSessionItem> dataValueList =
        dataList.map((value) => SubjectSessionItem.fromJson(value)).toList();

    return SubjectSessionModel(sessionItemList: dataValueList);
  }
}

class SubjectSessionItem {
  int chapterId;
  String chapterName;
  int subjectId;
  int percentageCompletion;
  int timeSpent;

  SubjectSessionItem({
    required this.chapterId,
    required this.chapterName,
    required this.subjectId,
    required this.percentageCompletion,
    required this.timeSpent,
  });

  factory SubjectSessionItem.fromJson(Map<String, dynamic> json) {
    return SubjectSessionItem(
      chapterId: json['chapter_id'],
      chapterName: json['chapter_name'],
      subjectId: json['subject_id'],
      percentageCompletion: json['percentage_completion'],
      timeSpent: json['time_spent'],
    );
  }
}
