class WatchOutListModel {
  List<WatchOutValue> watchOutList;

  WatchOutListModel({required this.watchOutList});

  factory WatchOutListModel.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<WatchOutValue> dataValueList =
        dataList.map((value) => WatchOutValue.fromJson(value)).toList();

    return WatchOutListModel(watchOutList: dataValueList);
  }
}

class WatchOutValue {
  int id;
  String title;
  String description;
  String slug;
  int categoryId;
  String tags;
  String featuredImages;
  int featured;
  int status;
  String created;
  String blogTitle;

  WatchOutValue({
    required this.id,
    required this.title,
    required this.description,
    required this.slug,
    required this.categoryId,
    required this.tags,
    required this.featuredImages,
    required this.featured,
    required this.status,
    required this.created,
    required this.blogTitle,
  });

  factory WatchOutValue.fromJson(Map<String, dynamic> json) {
    return WatchOutValue(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      slug: json['slug'],
      categoryId: json['category_id'],
      tags: json['tags'],
      featuredImages: json['featured_images'],
      featured: json['featured'],
      status: json['status'],
      created: json['created'],
      blogTitle: json['blog_title'],
    );
  }
}
