// ignore_for_file: use_is_even_rather_than_modulo, lines_longer_than_80_chars, cascade_invocations

import 'package:hive_flutter/hive_flutter.dart';
import 'package:social_media_feed_project/model/post.dart';
import 'package:social_media_feed_project/utils/date_formatter.dart';
import 'package:uuid/uuid.dart';

class PostService {
  static const String _boxName = 'posts';
  late Box<Post> _postsBox;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(PostAdapter());
    _postsBox = await Hive.openBox<Post>(_boxName);

    if (_postsBox.isEmpty) {
      await addDummyPosts();
    }
  }

  Future<List<Post>> getPosts({int page = 1, int limit = 10}) async {
    final startIndex = (page - 1) * limit;
    final endIndex = startIndex + limit;

    final posts = _postsBox.values.toList();
    posts.sort((a, b) => b.date.compareTo(a.date));

    if (startIndex >= posts.length) {
      return [];
    }

    return posts.sublist(startIndex, endIndex.clamp(0, posts.length));
  }

  Future<void> createPost(Post post) async {
    await _postsBox.put(post.id, post);
  }

  Future<void> addDummyPosts() async {
    final dummyPosts = generateDummyPosts();
    for (final post in dummyPosts) {
      await _postsBox.put(post.id, post);
    }
  }

  List<Post> generateDummyPosts() {
    const uuid = Uuid();
    return List.generate(10, (index) {
      final date = DateTime.now().subtract(Duration(days: index));
      return Post(
        id: uuid.v4(),
        date: date,
        headerText: 'Dummy Post ${10 - index}',
        bodyText:
            'This is the body of dummy post ${10 - index}. It was created on ${DateFormatter.formatSimple(date)}.',
        imageUrl: index % 2 == 0
            ? 'https://picsum.photos/seed/${index + 1}/300/200'
            : null,
      );
    });
  }

  Future<void> deletePost(String id) async {
    await _postsBox.delete(id);
  }

  Future<void> updatePost(Post post) async {
    await _postsBox.put(post.id, post);
  }

  Future<Post?> getPostById(String id) async {
    return _postsBox.get(id);
  }

  Future<void> clear() async {
    await _postsBox.clear();
  }
}
