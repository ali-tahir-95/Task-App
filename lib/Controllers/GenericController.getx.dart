// GenericController.dart
import 'package:get/get.dart';

import '../Services/ApiService.dart';

class GenericController extends GetxController {
  static GenericController instance = Get.find();
  var isLoading = false;
  final ApiService _apiService = ApiService();

// A method to delete and update the tasks in this list ?
  var tasksList = [].obs;

  // Observable variable to store fetched data
  var fetchedData = {}.obs;
  var response = {}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDataSavetoList(111222);
  }

  // Method to fetch data and update `fetchedData`
  void fetchDataSavetoList(number) async {
    try {
      final data = await _apiService.fetch(number);
      fetchedData.value = data; // Update observable variable
      tasksList.addAll(fetchedData['data']);
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  // Method to store data
  void storeData(username, number, images, taskname, description) async {
    try {
      final data = await _apiService.store(username, number, images, taskname, description);
      response.value = data; // Update observable variable
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  // Method to Status update
  void statusUpdate(id) async {
    try {
      final data = await _apiService.statusUpdate(id);
      response.value = data; // Update observable variable
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  // Method to delete Task
  void deleteTask(id) async {
    try {
      final data = await _apiService.deleteTask(id);
      response.value = data; // Update observable variable
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}
