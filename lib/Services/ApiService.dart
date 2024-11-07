import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  // Get Method for fetching data
  Future fetch(number) async {
    final response =
        await http.get(Uri.parse('https://tasks.coderzsolution.com/api/task?phone_number=$number'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Post Method for storing data
  Future store(username, number, images, taskname, description) async {
    final response =
        await http.post(Uri.parse('https://tasks.coderzsolution.com/api/task/store'), body: {
      "user_name": username,
      "phone_number": number,
      //"images": images,
      "task_name": taskname,
      "description": description
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  //  Post Method for status update
  Future statusUpdate(id) async {
    final response =
        await http.post(Uri.parse('https://tasks.coderzsolution.com/api/task/status-update/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  //  Post Method for delete
  Future deleteTask(id) async {
    final response =
        await http.post(Uri.parse('https://tasks.coderzsolution.com/api/task/delete/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
