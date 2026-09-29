class UserSubjectModel {
  List<Subject> subjectList;

  UserSubjectModel({required this.subjectList});

  factory UserSubjectModel.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<Subject> dataValueList =
        dataList.map((value) => Subject.fromJson(value)).toList();

    return UserSubjectModel(subjectList: dataValueList);
  }
}

class Subject {
  int id;
  int sNo;
  int courseId;
  String subjectTitle;
  String subjectDescription;
  int createdBy;
  int status;
  String created;
  String image;
  String type;

  Subject({
    required this.id,
    required this.sNo,
    required this.courseId,
    required this.subjectTitle,
    required this.subjectDescription,
    required this.createdBy,
    required this.status,
    required this.created,
    required this.image,
    required this.type,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      sNo: json['s_no'],
      courseId: json['course_id'],
      subjectTitle: json['subject_title'].toString(),
      subjectDescription: json['subject_description'].toString(),
      createdBy: json['created_by'],
      status: json['status'],
      created: json['created'].toString(),
      image: json['image'].toString(),
      type: "subject",
    );
  }
}
