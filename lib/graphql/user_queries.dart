class UserQueries {
  static const String getUsers = r'''
    query {
      users {
        id
        name
        email
      }
    }
  ''';

  static const String getUserComments = r'''
    query GetComments($userId: Int!) {
      user(id: $userId) {
        comments {
          id
          content
        }
      }
    }
  ''';
}
