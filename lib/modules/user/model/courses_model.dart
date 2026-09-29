class CoursesListModel {
  List<PackageCourse> packageCourse;

  CoursesListModel({
    required this.packageCourse,
  });

  factory CoursesListModel.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<PackageCourse> data =
        dataList.map((d) => PackageCourse.fromJson(d)).toList();

    return CoursesListModel(
      packageCourse: data,
    );
  }
}

class PackageCourse {
  int id;
  String courseName;
  String? benefitsLink;
  String? previewLink;
  double amount;
  String description;
  String image;
  String subTitle;
  int dummyRating;
  String courseHours;
  String lectures;
  String banner;
  String curriculum;
  String tag;
  String fakePrice;
  String discount;
  int featured;
  int priority;
  int packageId;
  int createdBy;
  int status;
  String created;
  String packageTitle;
  List<CourseBenefits> benefits;

  PackageCourse({
    required this.id,
    required this.courseName,
    this.benefitsLink,
    this.previewLink,
    required this.amount,
    required this.description,
    required this.image,
    required this.subTitle,
    required this.dummyRating,
    required this.courseHours,
    required this.lectures,
    required this.banner,
    required this.curriculum,
    required this.tag,
    required this.fakePrice,
    required this.discount,
    required this.featured,
    required this.priority,
    required this.packageId,
    required this.createdBy,
    required this.status,
    required this.created,
    required this.packageTitle,
    required this.benefits,
  });

  factory PackageCourse.fromJson(Map<String, dynamic> json) {
    return PackageCourse(
      id: json['id'],
      courseName: json['course_name'],
      benefitsLink: json['benifits_link'],
      previewLink: json['preview_link'],
      amount: json['amount'].toDouble(),
      description: json['description'],
      image: json['image'],
      subTitle: json['sub_title'],
      dummyRating: json['dummy_rating'],
      courseHours: json['course_hours'],
      lectures: json['lectures'],
      banner: json['banner'],
      curriculum: json['curriculum'],
      tag: json['tag'],
      fakePrice: json['fake_price'],
      discount: json['discount'],
      featured: json['featured'],
      priority: json['priority'],
      packageId: json['package_id'],
      createdBy: json['created_by'],
      status: json['status'],
      created: json['created'],
      packageTitle: json['package_title'],
      benefits: List<CourseBenefits>.from(
          json["benefits"].map((abc) => CourseBenefits.fromJson(abc))),
    );
  }
}

class CourseBenefits {
  int id;
  int courseId;
  String title;
  String subtitle;
  String image;
  String icon;
  int status;
  String created;

  CourseBenefits({
    required this.id,
    required this.courseId,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.icon,
    required this.status,
    required this.created,
  });

  factory CourseBenefits.fromJson(Map<String, dynamic> json) {
    return CourseBenefits(
      id: json['id'],
      courseId: json['course_id'],
      title: json['title'],
      subtitle: json['subtitle'],
      image: json['image'],
      icon: json['icon'],
      status: json['status'],
      created: json['created'],
    );
  }
}
