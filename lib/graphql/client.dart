import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  GraphQLService._internal();

  static final GraphQLService _instance = GraphQLService._internal();

  factory GraphQLService() => _instance;

  final HttpLink httpLink = HttpLink('http://192.168.0.89:3000/graphql');

  late final GraphQLClient client = GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(store: InMemoryStore()),
  );
}
