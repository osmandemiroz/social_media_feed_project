// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:social_media_feed_project/model/post.dart';
import 'package:social_media_feed_project/service/post_service.dart';
import 'package:social_media_feed_project/utils/screen_sizer.dart';
import 'package:uuid/uuid.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key, required this.postService});
  final PostService postService;

  @override
  // ignore: library_private_types_in_public_api
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _headerController = TextEditingController();
  final _bodyController = TextEditingController();
  final _imageUrlController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _headerController.dispose();
    _bodyController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  Future<void> _submitPost() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final newPost = Post(
        id: const Uuid().v4(),
        date: DateTime.now(),
        headerText: _headerController.text,
        bodyText: _bodyController.text,
        imageUrl: _imageUrlController.text.isNotEmpty
            ? _imageUrlController.text
            : null,
      );

      try {
        await widget.postService.createPost(newPost);
        Navigator.pop(context, newPost);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create post')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Post',
          style: TextStyle(fontSize: ResponsiveSizer.fontSize(context, 5)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ResponsiveSizer.width(context, 4)),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _headerController,
                  decoration: InputDecoration(
                    labelText: 'Header',
                    labelStyle: TextStyle(
                      fontSize: ResponsiveSizer.fontSize(context, 4),
                    ),
                  ),
                  style:
                      TextStyle(fontSize: ResponsiveSizer.fontSize(context, 4)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a header';
                    }
                    return null;
                  },
                ),
                SizedBox(height: ResponsiveSizer.height(context, 2)),
                TextFormField(
                  controller: _bodyController,
                  decoration: InputDecoration(
                    labelText: 'Body',
                    labelStyle: TextStyle(
                      fontSize: ResponsiveSizer.fontSize(context, 4),
                    ),
                  ),
                  style:
                      TextStyle(fontSize: ResponsiveSizer.fontSize(context, 4)),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter body text';
                    }
                    return null;
                  },
                ),
                SizedBox(height: ResponsiveSizer.height(context, 2)),
                TextFormField(
                  controller: _imageUrlController,
                  decoration: InputDecoration(
                    labelText: 'Image URL (optional)',
                    labelStyle: TextStyle(
                      fontSize: ResponsiveSizer.fontSize(context, 4),
                    ),
                  ),
                  style:
                      TextStyle(fontSize: ResponsiveSizer.fontSize(context, 4)),
                ),
                SizedBox(height: ResponsiveSizer.height(context, 4)),
                ElevatedButton(
                  onPressed: _isLoading ? null : _submitPost,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: ResponsiveSizer.height(context, 2),
                    ),
                  ),
                  child: _isLoading
                      ? SizedBox(
                          width: ResponsiveSizer.width(context, 5),
                          height: ResponsiveSizer.width(context, 5),
                          child:
                              const CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
                          'Create Post',
                          style: TextStyle(
                            fontSize: ResponsiveSizer.fontSize(context, 4),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
