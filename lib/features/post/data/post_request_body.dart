import 'package:json_annotation/json_annotation.dart';
part 'post_request_body.g.dart';

@JsonSerializable()
class PostRequestBody {
  String? id;
  @JsonKey(name: 'related_to_id')
  String? relatedToId;
  String? content;
  @JsonKey(name: 'created_at')
  final dynamic createdAt;
  List<String>? images;
  @JsonKey(name: 'view_count')
  int viewCount;
  @JsonKey(name: 'category_id')
  final String categoryId;
  PostRequestBody({
    this.id,
    this.images,
    required this.relatedToId,
    required this.content,
    required this.createdAt,
    this.viewCount = 0,
    required this.categoryId,
  });

  factory PostRequestBody.fromJson(Map<String, dynamic> json) =>
      _$PostRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$PostRequestBodyToJson(this);
}
