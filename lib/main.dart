import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'screens/user_list_screen.dart';
import 'graphql/client.dart';

void main() async {
  await initHiveForFlutter(); // Needed for graphql_flutter cache
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client = ValueNotifier(getGraphQLClient());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'GraphQL Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: UserListScreen(),
      ),
    );
  }
}
