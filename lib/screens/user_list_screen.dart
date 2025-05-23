import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../graphql/user_queries.dart';
import '../models/user.dart';
import 'user_detail_screen.dart';
import '../widgets/error_widget.dart';
import '../utils/error_utils.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Users")),
      body: Query(
        options: QueryOptions(document: gql(UserQueries.getUsers),
),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (result.hasException) {
            final message = getFriendlyErrorMessage(result.exception!);
            return ErrorDisplay(message: message, onRetry: refetch);
          }

          final usersJson = result.data?['users'] as List<dynamic>? ?? [];
          final users = usersJson
              .map((userJson) => User.fromJson(userJson))
              .toList();

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (_, index) {
              final user = users[index];
              return ListTile(
                title: Text(user.name),
                subtitle: Text(user.email),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetailScreen(userId: user.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
