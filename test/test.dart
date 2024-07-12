import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:social_media_feed_project/model/post.dart';
import 'package:social_media_feed_project/screen/create_post_screen.dart';
import 'package:social_media_feed_project/screen/feed_screen.dart';
import 'package:social_media_feed_project/service/post_service.dart';

import 'test.mocks.dart';

@GenerateMocks([PostService])
void main() {
  group('PostService Tests', () {
    late MockPostService mockPostService;

    setUp(() {
      mockPostService = MockPostService();
    });

    test('getPosts returns a list of posts', () async {
      when(mockPostService.getPosts()).thenAnswer(
        (_) async => [
          Post(
            id: '1',
            date: DateTime.now(),
            headerText: 'Test Post 1',
            bodyText: 'Body 1',
          ),
          Post(
            id: '2',
            date: DateTime.now(),
            headerText: 'Test Post 2',
            bodyText: 'Body 2',
          ),
        ],
      );

      final posts = await mockPostService.getPosts();
      expect(posts.length, 2);
      expect(posts[0].headerText, 'Test Post 1');
      expect(posts[1].headerText, 'Test Post 2');
    });

    test('createPost adds a new post', () async {
      final newPost = Post(
        id: '3',
        date: DateTime.now(),
        headerText: 'New Post',
        bodyText: 'New Body',
      );
      when(mockPostService.createPost(newPost)).thenAnswer((_) async => {});

      await mockPostService.createPost(newPost);
      verify(mockPostService.createPost(newPost)).called(1);
    });
  });

  group('Widget Tests', () {
    late MockPostService mockPostService;

    setUp(() {
      mockPostService = MockPostService();
    });

    testWidgets('FeedScreen displays posts', (WidgetTester tester) async {
      when(mockPostService.getPosts()).thenAnswer(
        (_) async => [
          Post(
            id: '1',
            date: DateTime.now(),
            headerText: 'Test Post 1',
            bodyText: 'Body 1',
          ),
          Post(
            id: '2',
            date: DateTime.now(),
            headerText: 'Test Post 2',
            bodyText: 'Body 2',
          ),
        ],
      );

      await tester.pumpWidget(
        MaterialApp(home: FeedScreen(postService: mockPostService)),
      );

      await tester.pumpAndSettle();

      expect(find.text('Test Post 1'), findsOneWidget);
      expect(find.text('Test Post 2'), findsOneWidget);
    });

    testWidgets('CreatePostScreen creates a new post',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: CreatePostScreen(postService: mockPostService)),
      );

      await tester.enterText(
        find.byType(TextFormField).at(0),
        'New Post Header',
      );
      await tester.enterText(find.byType(TextFormField).at(1), 'New Post Body');

      await tester.tap(find.text('Create Post'));
      await tester.pumpAndSettle();

      verify(mockPostService.createPost(any)).called(1);
    });
  });
}
