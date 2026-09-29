class WatchOutCategoryListModel {
  List<WatchOutCategory> watchOutCategory;

  WatchOutCategoryListModel({required this.watchOutCategory});

  factory WatchOutCategoryListModel.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<WatchOutCategory> dataValueList =
        dataList.map((value) => WatchOutCategory.fromJson(value)).toList();

    return WatchOutCategoryListModel(watchOutCategory: dataValueList);
  }
}

class WatchOutCategory {
  int id;
  String title;
  String description;
  String image;
  int featured;
  int status;
  String created;
  String type;

  WatchOutCategory({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.featured,
    required this.status,
    required this.created,
    required this.type,
  });

  factory WatchOutCategory.fromJson(Map<String, dynamic> json) {
    return WatchOutCategory(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      featured: json['featured'],
      status: json['status'],
      created: json['created'],
      type: "category",
    );
  }
}
