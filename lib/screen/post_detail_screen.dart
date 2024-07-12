import 'package:flutter/material.dart';
import 'package:social_media_feed_project/model/post.dart';
import 'package:social_media_feed_project/utils/date_formatter.dart';
import 'package:social_media_feed_project/utils/screen_sizer.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({super.key, required this.post});
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Post Detail',
          style: TextStyle(
            fontSize: ResponsiveSizer.fontSize(context, 5),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: ResponsiveSizer.width(context, 6)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (post.imageUrl != null)
              SizedBox(
                width: ResponsiveSizer.width(context, 100),
                height: ResponsiveSizer.height(context, 30),
                child: Image.network(
                  post.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: Center(
                        child: Icon(
                          Icons.error,
                          color: Colors.red,
                          size: ResponsiveSizer.width(context, 10),
                        ),
                      ),
                    );
                  },
                ),
              ),
            Padding(
              padding: EdgeInsets.all(ResponsiveSizer.width(context, 4)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.headerText,
                    style: TextStyle(
                      fontSize: ResponsiveSizer.fontSize(context, 6),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: ResponsiveSizer.height(context, 1)),
                  Text(
                    DateFormatter.formatForPostDetails(post.date),
                    style: TextStyle(
                      fontSize: ResponsiveSizer.fontSize(context, 3.5),
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: ResponsiveSizer.height(context, 2)),
                  Text(
                    post.bodyText,
                    style: TextStyle(
                      fontSize: ResponsiveSizer.fontSize(context, 4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
