import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:social_media_feed_project/model/post.dart';
import 'package:social_media_feed_project/screen/feed_screen.dart';
import 'package:social_media_feed_project/service/post_service.dart';
import 'package:social_media_feed_project/utils/screen_sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);

  // Register the Post adapter
  Hive.registerAdapter(PostAdapter());

  // Open the Hive box
  await Hive.openBox<Post>('posts');

  // Initialize PostService
  final postService = PostService();
  await postService.init();

  runApp(MyApp(postService: postService));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.postService});
  final PostService postService;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Media Feed',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: ResponsiveSizer.fontSize(context, 5)),
          bodyMedium: TextStyle(fontSize: ResponsiveSizer.fontSize(context, 4)),
        ),
      ),
      home: Builder(
        builder: (BuildContext context) {
          return FeedScreen(postService: postService);
        },
      ),
    );
  }
}
