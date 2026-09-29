class SubscriptionModel {
  List<DataValue> data;

  SubscriptionModel({
    required this.data,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<DataValue> data = dataList.map((d) => DataValue.fromJson(d)).toList();

    return SubscriptionModel(
      data: data,
    );
  }
}

class DataValue {
  int id;
  int courseId;
  int? teacherId;
  int studentId;
  double price;
  String transactionId;
  int createdBy;
  String courseStartDate;
  int status;
  String created;
  String studentName;
  String studentPhone;

  DataValue({
    required this.id,
    required this.courseId,
    required this.teacherId,
    required this.studentId,
    required this.price,
    required this.transactionId,
    required this.createdBy,
    required this.courseStartDate,
    required this.status,
    required this.created,
    required this.studentName,
    required this.studentPhone,
  });

  factory DataValue.fromJson(Map<String, dynamic> json) {
    return DataValue(
      id: json['id'],
      courseId: json['course_id'],
      teacherId: json['teacher_id'],
      studentId: json['student_id'],
      price: json['price'].toDouble(),
      transactionId: json['transaction_id'],
      createdBy: json['created_by'],
      courseStartDate: json['course_start_date'],
      status: json['status'],
      created: json['created'],
      studentName: json['student_name'],
      studentPhone: json['student_phone'],
    );
  }
}
