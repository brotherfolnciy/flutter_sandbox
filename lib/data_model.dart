import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_model.freezed.dart';
part 'data_model.g.dart';

@freezed
class NewsDTO with _$NewsDTO {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory NewsDTO({
    int? id,
    String? title,
    String? url,
    String? imageUrl,
    String? newsSite,
    String? summary,
    required DateTime? publishedAt,
    DateTime? updatedAt,
    bool? featured,
    List<dynamic>? launches,
    List<dynamic>? events,
  }) = _NewsDTO;

  factory NewsDTO.fromJson(Map<String, dynamic> json) => _$NewsDTOFromJson(json);
}

@Freezed(genericArgumentFactories: true)
class PaginationModel<T> with _$PaginationModel<T> {
  const factory PaginationModel({
    int? count,
    String? next,
    required List<T> results,
  }) = _PaginationModel;

  factory PaginationModel.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$PaginationModelFromJson(json, fromJsonT);
}
