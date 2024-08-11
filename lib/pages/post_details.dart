import 'package:advanced_task9_provider/models/post_model.dart';
import 'package:advanced_task9_provider/provider/comments/comment_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostDetailsPage extends StatefulWidget {
  final Post post;

  const PostDetailsPage({required this.post, Key? key}) : super(key: key);

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<CommentState>(context, listen: false)
        .fetchComments(widget.post.id!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.title ?? 'Post Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Post header
            PhysicalModel(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(15),
              shadowColor: Colors.black,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.title ?? 'No Title',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.post.body ?? 'No Body',
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.person),
                        const SizedBox(width: 5),
                        Text(widget.post.userId.toString())
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text('Comments:',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),

            // Comments
            Expanded(
              child: Consumer<CommentState>(
                builder: (ctx, commentState, child) {
                  if (commentState.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (commentState.error != null) {
                    return Center(child: Text(commentState.error!));
                  } else {
                    return ListView.builder(
                      itemCount: commentState.comments.length,
                      itemBuilder: (ctx, index) {
                        return Card(
                          surfaceTintColor: Colors.black12,
                          child: ListTile(
                            title: Text(
                                commentState.comments[index].body ?? 'No body'),
                            subtitle: Text(commentState.comments[index].email ??
                                'No Email'),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
