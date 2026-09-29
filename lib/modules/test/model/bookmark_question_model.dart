import 'package:flutter_architecture/modules/test/model/test_questions_model.dart';

class BookmarkQuestionModel {
  List<QuestionModel> bookmarkQuestionItems;

  BookmarkQuestionModel({required this.bookmarkQuestionItems});

  factory BookmarkQuestionModel.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<QuestionModel> dataValueList =
        dataList.map((value) => QuestionModel.fromJson(value)).toList();

    return BookmarkQuestionModel(bookmarkQuestionItems: dataValueList);
  }
}
