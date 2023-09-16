class MyPlanOrderModel {
  final int id;
  final String planId;
  final int price;
  final String date;
  final String time;
  final String status;

  MyPlanOrderModel(
      {required this.id,
      required this.planId,
      required this.price,
      required this.date,
      required this.time,
      required this.status});

  factory MyPlanOrderModel.fromJson(Map<String, dynamic> json) {
    return MyPlanOrderModel(
      id: json['id'],
      planId: json['plan_id'],
      price: json['price'],
      date: json['date'],
      time: json['time'],
      status: json['status'],
    );
  }
}
