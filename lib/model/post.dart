import 'package:hive/hive.dart';

part 'post.g.dart';

@HiveType(typeId: 0)
class Post extends HiveObject {
  Post({
    required this.id,
    required this.date,
    required this.headerText,
    required this.bodyText,
    this.imageUrl,
  });
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final String headerText;

  @HiveField(3)
  final String bodyText;

  @HiveField(4)
  final String? imageUrl;
}
