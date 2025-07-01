
import 'package:triptery/domain/entities/tag/tag.dart';

class TagModel {
  final String id;
  final String name;

  TagModel({
    required this.id,
    required this.name,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
      id: json['id'] as String,
      name: json['name'] as String,
    ); 
  }

  Tag toEntity(){
    return Tag(
      id: id,
      name: name,
    ); 
  }
}