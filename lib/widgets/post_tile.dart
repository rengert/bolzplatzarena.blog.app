import 'dart:convert';
import 'package:flutter/material.dart';

class PostTile extends StatefulWidget {
  final String userId;
  final String blogPostId;
  final String blogPostTitle;
  final String blogPostContent;
  final String date;
  final MemoryImage image = MemoryImage(base64.decode('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'));

  PostTile({
    required this.userId,
    required this.blogPostId,
    required this.blogPostTitle,
    required this.blogPostContent,
    required this.date
  });

  @override
  _PostTileState createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => BlogPostPage(userId: _user.uid, blogPostId: widget.blogPostId)));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 5.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30.0,
            backgroundColor: const Color(0xFF083663),
            backgroundImage: widget.image,
          ),
          title: Text(
            widget.blogPostTitle,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  widget.date,
                  style: const TextStyle(color: Colors.grey, fontSize: 12.0)
              ),
              Text(
                widget.blogPostContent,
                style: const TextStyle(fontSize: 13.0),
                overflow: TextOverflow.ellipsis,
                maxLines: 4,

              ),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                direction: Axis.horizontal,
                children: const [
                  Chip(
                    label: Text('Test')
                  ),
                  Chip(
                      label: Text('Test')
                  ),
                  Chip(
                      label: Text('Test')
                  ),
                  Chip(
                      label: Text('Test')
                  ),Chip(
                      label: Text('Test')
                  ),
                  Chip(
                      label: Text('Test')
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}