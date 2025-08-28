class ApiService {
  static const String baseUrl = "https://dummyjson.com/";
  static const String posts = "${baseUrl}posts";
  static const String quote = "${baseUrl}quotes";
  static const String user = "${baseUrl}users";
  static const String login = "${baseUrl}auth/login";
  static const String me = "${baseUrl}auth/me";

  static String userPosts(int userId) => "${baseUrl}users/$userId/posts";
}
