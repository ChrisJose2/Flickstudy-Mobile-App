class PackageModel {
  int id;
  String title;
  String subTitle;
  String description;
  String banner;
  int status;
  String created;

  PackageModel({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.banner,
    required this.status,
    required this.created,
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      id: json['id'],
      title: json['title'],
      subTitle: json['subtitle'],
      description: json['description'],
      banner: json['banner'],
      status: json['status'],
      created: json['created'],
    );
  }
}
