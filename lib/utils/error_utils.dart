import 'package:graphql_flutter/graphql_flutter.dart';

String getFriendlyErrorMessage(OperationException exception) {
  if (exception.linkException != null) {
    return 'Network error: Please check your internet connection.';
  }
  if (exception.graphqlErrors.isNotEmpty) {
    return 'Server error: ${exception.graphqlErrors.first.message}';
  }
  return 'Unknown error occurred.';
}
