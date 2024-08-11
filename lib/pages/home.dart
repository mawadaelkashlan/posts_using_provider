import 'package:advanced_task9_provider/pages/post_details.dart';
import 'package:advanced_task9_provider/provider/posts/posts_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<PostState>(context, listen: false).fetchPosts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Consumer<PostState>(
          builder: (ctx, postState, child) {
            if (postState.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (postState.error != null) {
              return Center(child: Text(postState.error!));
            } else {
              return ListView.builder(
                itemCount: postState.posts.length,
                itemBuilder: (ctx, index) {
                  return Card(
                    surfaceTintColor: Colors.black12,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return PostDetailsPage(
                                post: postState.posts[index]);
                          },
                        ));
                      },
                      title: Text(postState.posts[index].title ?? 'No Title'),
                      subtitle: Text(postState.posts[index].body ?? 'No BODY'),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
