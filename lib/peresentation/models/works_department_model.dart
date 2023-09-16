import 'package:equatable/equatable.dart';

class WorksDepartmentModel extends Equatable {
  final int id;
  final String name;
  final String nameEn;
  final int weight;

  const WorksDepartmentModel(
      {required this.id,
      required this.name,
      required this.nameEn,
      required this.weight});
  factory WorksDepartmentModel.fromJson(Map<String, dynamic> json) {
    return WorksDepartmentModel(
        id: json["id"],
        name: json["name"],
        nameEn: json["name_en"],
        weight: json["weight"]);
  }

  @override
  List<Object?> get props => [
    id,
    nameEn,
    name,
    weight
  ];
}
