class WordDetailsModel {
  WordDetail wordDetail;
  List<WordListMedia> wordListMedia;
  int? bookmarkId;

  WordDetailsModel(
      {required this.wordDetail,
      required this.wordListMedia,
      required this.bookmarkId});

  factory WordDetailsModel.fromJson(
      Map<String, dynamic> json, int? bookmarkId) {
    return WordDetailsModel(
      wordDetail: WordDetail.fromJson(json['data']),
      wordListMedia: (json['word_list_media'] as List)
          .map((value) => WordListMedia.fromJson(value))
          .toList(),
      bookmarkId: bookmarkId,
    );
  }
}

class WordDetail {
  int id;
  String title;
  String description;
  int status;
  String created;

  WordDetail({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.created,
  });

  factory WordDetail.fromJson(Map<String, dynamic> json) {
    return WordDetail(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      created: json['created'],
    );
  }
}

class WordListMedia {
  int id;
  String file;
  String type;
  int wordListId;
  int status;
  String created;

  WordListMedia({
    required this.id,
    required this.file,
    required this.type,
    required this.wordListId,
    required this.status,
    required this.created,
  });

  factory WordListMedia.fromJson(Map<String, dynamic> json) {
    return WordListMedia(
      id: json['id'],
      file: json['file'],
      type: json['type'],
      wordListId: json['word_list_id'],
      status: json['status'],
      created: json['created'],
    );
  }
}
