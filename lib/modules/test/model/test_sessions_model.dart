class TestSessionsResponse {
  List<TestSessionModel> testSessions = [];

  fromJson(List<dynamic> json) {
    testSessions = json.map((e) => TestSessionModel()..fromJson(e)).toList();
  }
}

class TestSessionModel {
  int testpaper_id = 0;
  int student_id = 0;
  String session_id = '';
  String testpaper_title = '';
  fromJson(Map<String, dynamic> json) {
    //{
    // "testpaper_id": 1,
    // "student_id": 1,
    // "session_id": "1"
    //}

    testpaper_id = json['testpaper_id'] ?? 0;
    student_id = json['student_id'] ?? 0;
    session_id = json['session_id'] ?? '';
    testpaper_title = json['testpaper_title'] ?? '';
  }
}
