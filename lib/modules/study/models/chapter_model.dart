class ChapterModel {
  List<Chapter> chapterList;

  ChapterModel({required this.chapterList});

  factory ChapterModel.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<Chapter> dataValueList =
        dataList.map((value) => Chapter.fromJson(value)).toList();

    return ChapterModel(chapterList: dataValueList);
  }
}

class Chapter {
  int id;
  int sNo;
  int subjectId;
  String chapterTitle;
  String chapterDescription;
  String image;
  int days;
  int status;
  String created;
  int createdBy;
  String type;

  Chapter({
    required this.id,
    required this.sNo,
    required this.subjectId,
    required this.chapterTitle,
    required this.chapterDescription,
    required this.image,
    required this.days,
    required this.status,
    required this.created,
    required this.createdBy,
    required this.type,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['id'],
      sNo: json['s_no'],
      subjectId: json['subject_id'],
      chapterTitle: json['chapter_title'].toString(),
      chapterDescription: json['chapter_description'].toString(),
      image: json['image'].toString(),
      days: json['days'],
      status: json['status'],
      created: json['created'].toString(),
      createdBy: json['created_by'],
      type: "chapter",
    );
  }
}
