const String getUsersQuery = r'''
  query {
    users {
      id
      name
      email
    }
  }
''';

const String getUserCommentsQuery = r'''
  query GetComments($userId: ID!) {
    user(id: $userId) {
      comments {
        id
        content
      }
    }
  }
''';
