class WordListModel {
  List<WordData> wordList;

  WordListModel({required this.wordList});

  factory WordListModel.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<WordData> dataValueList =
        dataList.map((value) => WordData.fromJson(value)).toList();

    return WordListModel(wordList: dataValueList);
  }
}

class WordData {
  int id;
  String title;
  String description;
  int status;
  String created;

  WordData({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.created,
  });

  factory WordData.fromJson(Map<String, dynamic> json) {
    return WordData(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      created: json['created'],
    );
  }
}
