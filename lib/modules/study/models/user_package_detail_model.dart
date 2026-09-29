class UserPackageModel {
  List<PackageValue> packageList;

  UserPackageModel({required this.packageList});

  factory UserPackageModel.fromJson(dynamic json) {
    var dataList = json['data'] as List;
    List<PackageValue> packageValueList =
        dataList.map((value) => PackageValue.fromJson(value)).toList();

    return UserPackageModel(packageList: packageValueList);
  }
}

class PackageValue {
  String title;
  int id;
  String subtitle;
  String description;
  String banner;
  int status;
  String created;
  List<Courses> courses;
  List<PackageTestimonials> packageTestimonials;

  PackageValue({
    required this.title,
    required this.id,
    required this.subtitle,
    required this.description,
    required this.banner,
    required this.status,
    required this.created,
    required this.courses,
    required this.packageTestimonials,
  });

  factory PackageValue.fromJson(Map<String, dynamic> json) {
    var coursesList = json['courses'] as List;
    List<Courses> coursesValueList =
        coursesList.map((value) => Courses.fromJson(value)).toList();

    var packageTestimonialsList = json['package_testimonials'] as List;
    List<PackageTestimonials> packageTestimonialsValueList =
        packageTestimonialsList
            .map((value) => PackageTestimonials.fromJson(value))
            .toList();

    return PackageValue(
      title: json['title'].toString(),
      id: json['id'],
      subtitle: json['subtitle'].toString(),
      description: json['description'].toString(),
      banner: json['banner'].toString(),
      status: json['status'],
      created: json['created'].toString(),
      courses: coursesValueList,
      packageTestimonials: packageTestimonialsValueList,
    );
  }
}

class Courses {
  int id;
  String courseName;
  int amount;
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

  Courses({
    required this.id,
    required this.courseName,
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
  });

  factory Courses.fromJson(Map<String, dynamic> json) {
    return Courses(
      id: json['id'],
      courseName: json['course_name'].toString(),
      amount: json['amount'],
      description: json['description'].toString(),
      image: json['image'].toString(),
      subTitle: json['sub_title'],
      dummyRating: json['dummy_rating'],
      courseHours: json['course_hours'].toString(),
      lectures: json['lectures'].toString(),
      banner: json['banner'].toString(),
      curriculum: json['curriculum'].toString(),
      tag: json['tag'].toString(),
      fakePrice: json['fake_price'].toString(),
      discount: json['discount'].toString(),
      featured: json['featured'],
      priority: json['priority'],
      packageId: json['package_id'],
      createdBy: json['created_by'],
      status: json['status'],
      created: json['created'].toString(),
    );
  }
}

class PackageTestimonials {
  String id;
  String title;
  String description;
  String image;
  String packageId;
  String status;
  String created;

  PackageTestimonials({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.packageId,
    required this.status,
    required this.created,
  });

  factory PackageTestimonials.fromJson(Map<String, dynamic> json) {
    return PackageTestimonials(
      id: json['id'].toString(),
      title: json['title'].toString(),
      description: json['description'].toString(),
      image: json['image'].toString(),
      packageId: json['package_id'].toString(),
      status: json['status'].toString(),
      created: json['created'].toString(),
    );
  }
}
