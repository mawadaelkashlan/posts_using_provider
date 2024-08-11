import 'package:advanced_task9_provider/models/comment_model.dart';
import 'package:advanced_task9_provider/repository/comments_repostiory.dart';
import 'package:flutter/material.dart';


class CommentState with ChangeNotifier {
  CommentsRepository commentsRepository = CommentsRepository();
  List<Comment> comments = [];
  bool isLoading = false;
  String? error;

  Future<void> fetchComments(int postId) async {
    isLoading = true;
    notifyListeners();
    var callResult = await commentsRepository.get({'postId': postId});
    if (callResult.isSuscces) {
      comments = List<Comment>.from(
          callResult.data.map((e) => Comment.fromJson(e)).toList());
    } else {
      error = callResult.error;
    }
    isLoading = false;
    notifyListeners();
  }
}
