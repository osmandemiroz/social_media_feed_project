import 'package:flutter/material.dart';
import 'package:social_media_feed_project/model/post.dart';
import 'package:social_media_feed_project/screen/create_post_screen.dart';
import 'package:social_media_feed_project/service/post_service.dart';
import 'package:social_media_feed_project/utils/screen_sizer.dart';
import 'package:social_media_feed_project/widget/post_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key, required this.postService});
  final PostService postService;

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  List<Post> posts = [];
  bool isLoading = false;
  int currentPage = 1;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadInitialPosts();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadInitialPosts() async {
    setState(() {
      isLoading = true;
    });
    try {
      final newPosts = await widget.postService.getPosts();
      setState(() {
        posts = newPosts;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _showErrorSnackBar('Failed to load posts');
    }
  }

  Future<void> _loadMorePosts() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        currentPage++;
      });
      try {
        final newPosts = await widget.postService.getPosts(page: currentPage);
        setState(() {
          posts.addAll(newPosts);
          isLoading = false;
        });
      } catch (e) {
        setState(() {
          isLoading = false;
          currentPage--;
        });
        _showErrorSnackBar('Failed to load more posts');
      }
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMorePosts();
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Social Media Feed',
          style: TextStyle(fontSize: ResponsiveSizer.fontSize(context, 5)),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          currentPage = 1;
          await _loadInitialPosts();
        },
        child: posts.isEmpty && !isLoading
            ? const Center(child: Text('No posts available'))
            : ListView.builder(
                controller: _scrollController,
                itemCount: posts.length + 1,
                itemBuilder: (context, index) {
                  if (index < posts.length) {
                    return PostCard(post: posts[index]);
                  } else if (isLoading) {
                    return Center(
                      child: Padding(
                        padding:
                            EdgeInsets.all(ResponsiveSizer.width(context, 4)),
                        child: const CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newPost = await Navigator.push<Post>(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CreatePostScreen(postService: widget.postService),
            ),
          );
          if (newPost != null) {
            setState(() {
              posts.insert(0, newPost);
            });
          }
        },
        child: Icon(Icons.add, size: ResponsiveSizer.width(context, 6)),
      ),
    );
  }
}
