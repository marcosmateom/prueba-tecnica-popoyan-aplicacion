import 'package:graphql_flutter/graphql_flutter.dart';

GraphQLClient getGraphQLClient() {
  final HttpLink httpLink = HttpLink(
    'http://192.168.0.89:3000/graphql',
  );

  return GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(store: InMemoryStore()),
  );
}
