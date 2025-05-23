import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../graphql/queries.dart';

class UserDetailScreen extends StatelessWidget {
  final String userId;

  const UserDetailScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Comments')),
      body: Query(
        options: QueryOptions(
          document: gql(getUserCommentsQuery),
          variables: {'userId': userId},
        ),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (result.hasException) {
            return Center(child: Text('Error: ${result.exception.toString()}'));
          }

          final comments = result.data?['user']?['comments'] ?? [];

          if (comments.isEmpty) {
            return const Center(child: Text("No comments found."));
          }

          return ListView.builder(
            itemCount: comments.length,
            itemBuilder: (context, index) {
              final comment = comments[index];
              return ListTile(
                title: Text("Comment #${comment['id']}"),
                subtitle: Text(comment['content']),
              );
            },
          );
        },
      ),
    );
  }
}
