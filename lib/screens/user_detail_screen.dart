import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../graphql/user_queries.dart';
import '../models/comment.dart';
import '../widgets/error_widget.dart';
import '../utils/error_utils.dart';

class UserDetailScreen extends StatelessWidget {
  final int userId;

  const UserDetailScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Comments')),
      body: Query(
        options: QueryOptions(
          document: gql(UserQueries.getUserComments),
          variables: {'userId': userId},
        ),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (result.hasException) {
            final message = getFriendlyErrorMessage(result.exception!);
            return ErrorDisplay(message: message, onRetry: refetch);
          }

          final commentsJson =
              result.data?['user']?['comments'] as List<dynamic>? ?? [];
          final comments = commentsJson
              .map((json) => Comment.fromJson(json))
              .toList();

          if (comments.isEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                await refetch?.call();
              },
              child: ListView(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: Text("No comments found.")),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await refetch?.call();
            },
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return ListTile(
                  title: Text("Comment #${comment.id}"),
                  subtitle: Text(comment.content),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
