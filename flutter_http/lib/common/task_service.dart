import 'dart:convert';

import 'package:flutter_http/task.dart';
import 'package:http/http.dart' as http;

class TaskService {
  final String url = "https://jsonplaceholder.typicode.com/posts";

  Future<List<Task>> getTasks() async {
    try {
      final response = await http.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        List result = json.decode(response.body);
        return result.map((e) => Task.fromMap(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<Task> createTask(Task task) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(task.toMap()),
      );

      if (response.statusCode == 201) {
        return Task.fromMap(json.decode(response.body));
      } else {
        throw Exception;
      }
    } catch (e) {
      throw Exception();
    }
  }

  Future<Task> updateTask(Task task) async {
    try {
      final response = await http.put(
        Uri.parse("$url/1"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(task.toMap()),
      );

      if (response.statusCode == 200) {
        return Task.fromMap(json.decode(response.body));
      } else {
        throw Exception;
      }
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> deleteTask() async {
    try {
      final response = await http.delete(Uri.parse("$url/1"));
      if (response.statusCode != 200) {
        throw Exception;
      }
    } catch (e) {
      throw Exception();
    }
  }
}
