class PointsModel {
  final int id;
  final int userId;
  final int albumId;
  final int forHim;
  final int onHim;
  final int balance;
  final int point;
  final int pointerBalance;
  final String note;
  final String createdAt;

  PointsModel(
      {required this.id,
      required this.userId,
      required this.albumId,
      required this.forHim,
      required this.onHim,
      required this.balance,
      required this.point,
      required this.pointerBalance,
      required this.note,
      required this.createdAt});



  factory PointsModel.fromJson(Map<String, dynamic> json) {
    return PointsModel(
      id: json['id'] ,
      userId: json['user_id'] ,
      albumId: json['album_id'],
      forHim: json['for_him'] ,
      onHim: json['on_him'],
      balance: json['balance'],
      point: json['point'],
      pointerBalance: json['pointer_balance'],
      note: json['note'],
      createdAt: json['created_at'],
    );
  }
}
