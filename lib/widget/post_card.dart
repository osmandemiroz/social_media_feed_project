// ignore_for_file: inference_failure_on_instance_creation

import 'package:flutter/material.dart';
import 'package:social_media_feed_project/model/post.dart';
import 'package:social_media_feed_project/screen/post_detail_screen.dart';
import 'package:social_media_feed_project/utils/date_formatter.dart';
import 'package:social_media_feed_project/utils/screen_sizer.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: ResponsiveSizer.height(context, 1),
        horizontal: ResponsiveSizer.width(context, 4),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostDetailScreen(post: post),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(ResponsiveSizer.width(context, 4)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.headerText,
                    style: TextStyle(
                      fontSize: ResponsiveSizer.fontSize(context, 4.5),
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: ResponsiveSizer.height(context, 1)),
                  Text(
                    DateFormatter.formatRelative(post.date),
                    style: TextStyle(
                      fontSize: ResponsiveSizer.fontSize(context, 3),
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: ResponsiveSizer.height(context, 1)),
                  Text(
                    post.bodyText,
                    style: TextStyle(
                      fontSize: ResponsiveSizer.fontSize(context, 3.5),
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (post.imageUrl != null)
              Container(
                constraints: BoxConstraints(
                  maxHeight: ResponsiveSizer.height(context, 25),
                ),
                width: double.infinity,
                child: Image.network(
                  post.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: ResponsiveSizer.height(context, 25),
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.error, color: Colors.red),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
