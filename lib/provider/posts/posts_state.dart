import 'package:advanced_task9_provider/models/post_model.dart';
import 'package:advanced_task9_provider/repository/posts_repostiory.dart';
import 'package:flutter/material.dart';


class PostState with ChangeNotifier {
  PostsRepository postsRepository = PostsRepository();
  List<Post> posts = [];
  bool isLoading = false;
  String? error;

  Future<void> fetchPosts() async {
    isLoading = true;
    notifyListeners();
    var callResult = await postsRepository.get();
    if (callResult.isSuscces) {
      posts = List<Post>.from(
          callResult.data.map((e) => Post.fromJson(e)).toList());
    } else {
      error = callResult.error;
    }
    isLoading = false;
    notifyListeners();
  }
}
