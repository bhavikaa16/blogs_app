import 'dart:convert';
import 'package:http/http.dart' as http;


import 'model/post_model.dart';
import 'model/to_do_model.dart';
import 'model/user_model.dart';

class UserRepository{
  bool simulateError = false;
  final String baseUrl= 'https://dummyjson.com';
  Future<List<User>> fetchUsers({int limit=10,int skip=0}) async{
    if (simulateError) {
      throw Exception('Simulated network error');
    }
    try {
      final response = await http.get(Uri.parse('$baseUrl/users?limit=$limit&skip=$skip'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> usersJson = data['users'];
        return usersJson.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load users (status: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }
  Future<List<User>> searchUsers(String query) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/users/search?q=$query'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> usersJson = data['users'];
        return usersJson.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Search failed (status: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('User search failed: $e');
    }
  }
  Future<List<PostModel>> fetchUserPosts(int userId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/posts/user/$userId'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> postsJson = data['posts'];
        return postsJson.map((json) => PostModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load posts (status: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Failed to load user posts: $e');
    }
  }
  Future<List<TodoModel>> fetchUserTodos(int userId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/todos/user/$userId'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> todosJson = data['todos'];
        return todosJson.map((json) => TodoModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load todos (status: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Failed to load user todos: $e');
    }
  }
  Future<PostModel> createUserPost({required int userId, required String title, required String body}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/posts/add'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'userId': userId,
          'title': title,
          'body': body,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        return PostModel.fromJson(data);
      } else {
        throw Exception('Failed to create post (status: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Failed to create user post: $e');
    }
  }
}


