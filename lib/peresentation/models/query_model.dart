import 'package:equatable/equatable.dart';

class QueryModel extends Equatable {
  final int id;
 final String  status;
final String  createdAt;

const QueryModel(
  {
    required this.id,
    required this.status,
    required this.createdAt
}
    );
factory QueryModel.fromJson(Map<String,dynamic>  json ) {  
  
  return QueryModel(id: json["id"], status: json["status"], createdAt: json["created_at"]);

  
  
}

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
     status,
     createdAt
  ] ;
}