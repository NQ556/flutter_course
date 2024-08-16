import 'package:dio/dio.dart';
import 'package:flutter_dio/task.dart';

class TaskService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://jsonplaceholder.typicode.com",
    ),
  );

  Future<List<Task>> getTasks() async {
    try {
      final response = await dio.get("/posts");

      if (response.statusCode == 200) {
        final List result = response.data;
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
      final response = await dio.post(
        "/posts",
        data: task.toMap(),
      );

      if (response.statusCode == 201) {
        return Task.fromMap(response.data);
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }

  Future<Task> updateTask(Task task) async {
    try {
      final response = await dio.put(
        "/posts/1",
        data: task.toMap(),
      );

      if (response.statusCode == 200) {
        return Task.fromMap(response.data);
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> deleteTask() async {
    try {
      final response = await dio.delete("/posts/1");
      if (response.statusCode != 200) {
        throw Exception;
      }
    } catch (e) {
      throw Exception();
    }
  }
}
