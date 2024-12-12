import 'dart:io';

import 'package:cloudocz/model/post_model.dart';

import 'package:cloudocz/view/feedback.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final ValueNotifier<List<PostModel>> postListNotifier =
      ValueNotifier<List<PostModel>>([]);

  void addNewPost(PostModel newPost) {
    postListNotifier.value = [...postListNotifier.value, newPost];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Post'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FeedbackScreen(onSubmit: addNewPost),
                  ),
                ),
                child: const Icon(Icons.add, size: 34),
              ),
            )
          ],
        ),
        body: Center(
          child: Text('Dataaaaaaaaaaaas'),
        ));
  }
}
