class BookmarkListModel {
  List<Bookmark> bookmarkList;

  BookmarkListModel({required this.bookmarkList});

  factory BookmarkListModel.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<Bookmark> dataValueList =
        dataList.map((value) => Bookmark.fromJson(value)).toList();

    return BookmarkListModel(bookmarkList: dataValueList);
  }
}

class Bookmark {
  int id;
  int wordId;
  String userId;
  int status;
  String created;
  String wordIdTitle;
  String name;

  Bookmark({
    required this.id,
    required this.wordId,
    required this.userId,
    required this.status,
    required this.created,
    required this.wordIdTitle,
    required this.name,
  });

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      id: json['id'],
      wordId: int.parse(json['word_id']),
      userId: json['user_id'],
      status: json['status'],
      created: json['created'],
      wordIdTitle: json['word_id_title'],
      name: json['name'],
    );
  }
}
