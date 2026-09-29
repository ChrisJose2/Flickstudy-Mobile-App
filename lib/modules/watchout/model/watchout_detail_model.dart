class WatchOutDetailModel {
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

  WatchOutDetailModel({
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
  });

  factory WatchOutDetailModel.fromJson(Map<String, dynamic> json) {
    return WatchOutDetailModel(
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
    );
  }
}
